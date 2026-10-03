@IsTest
private class BatchCompleteEventsTest {
    @IsTest static void completesOnlyEligibleEvents() {
        Client__c c=new Client__c(Name='Batch Client',Email__c='batch@example.com'); insert c;
        Venue__c v=new Venue__c(Name='Batch Hall',Availability_Status__c='Available'); insert v;
        List<Event__c> events=new List<Event__c>{
            new Event__c(Name='Past confirmed',Client__c=c.Id,Venue__c=v.Id,Event_Date__c=Date.today().addDays(-1),Event_Status__c='Confirmed'),
            new Event__c(Name='Past canceled',Client__c=c.Id,Venue__c=v.Id,Event_Date__c=Date.today().addDays(-2),Event_Status__c='Canceled'),
            new Event__c(Name='Past planned',Client__c=c.Id,Venue__c=v.Id,Event_Date__c=Date.today().addDays(-3),Event_Status__c='Planned'),
            new Event__c(Name='Future confirmed',Client__c=c.Id,Venue__c=v.Id,Event_Date__c=Date.today().addDays(1),Event_Status__c='Confirmed')
        }; insert events;
        Test.startTest(); Database.executeBatch(new BatchCompleteEvents(),200); Test.stopTest();
        Map<Id,Event__c> actual=new Map<Id,Event__c>([SELECT Id,Event_Status__c FROM Event__c]);
        System.assertEquals('Completed',actual.get(events[0].Id).Event_Status__c);
        System.assertEquals('Completed',actual.get(events[1].Id).Event_Status__c);
        System.assertEquals('Completed',actual.get(events[2].Id).Event_Status__c);
        System.assertEquals('Confirmed',actual.get(events[3].Id).Event_Status__c);
        System.assertEquals('Reserved',[SELECT Availability_Status__c FROM Venue__c WHERE Id=:v.Id].Availability_Status__c);
    }
    @IsTest static void scheduleDispatchesBatch() {
        Test.startTest(); new BatchCompleteEvents().execute((SchedulableContext)null); Test.stopTest();
        System.assertEquals(1,[SELECT count() FROM AsyncApexJob WHERE ApexClass.Name='BatchCompleteEvents' AND JobType='BatchApex' AND Status='Completed']);
    }
}
