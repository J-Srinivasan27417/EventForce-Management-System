@IsTest
private class EventForceServiceTest {
    private static Client__c client() {
        Client__c c = new Client__c(Name='Demo Client', Email__c='demo@example.com'); insert c; return c;
    }
    private static Venue__c venue() {
        Venue__c v = new Venue__c(Name='Demo Hall', Capacity__c=250, Availability_Status__c='Available'); insert v; return v;
    }
    private static Event__c eventRecord(Id c, Id v, Integer offset) {
        return new Event__c(Name='Demo Event', Client__c=c, Venue__c=v, Event_Date__c=Date.today().addDays(offset), Event_Type__c='Corporate', Event_Status__c='Confirmed');
    }
    @IsTest static void reservationLifecycle() {
        Client__c c=client(); Venue__c v=venue();
        Event__c first=eventRecord(c.Id,v.Id,10); insert first;
        System.assertEquals('Reserved',[SELECT Availability_Status__c FROM Venue__c WHERE Id=:v.Id].Availability_Status__c);
        System.assertEquals(30000,[SELECT Event_Budget__c FROM Event__c WHERE Id=:first.Id].Event_Budget__c);
        Event__c second=eventRecord(c.Id,v.Id,11); insert second;
        first.Event_Status__c='Canceled'; update first;
        System.assertEquals('Reserved',[SELECT Availability_Status__c FROM Venue__c WHERE Id=:v.Id].Availability_Status__c);
        second.Event_Status__c='Pending Cancellation'; update second;
        System.assertEquals('Reserved',[SELECT Availability_Status__c FROM Venue__c WHERE Id=:v.Id].Availability_Status__c);
        second.Event_Status__c='Canceled'; update second;
        System.assertEquals('Available',[SELECT Availability_Status__c FROM Venue__c WHERE Id=:v.Id].Availability_Status__c);
        Event__c replacement=eventRecord(c.Id,v.Id,10); insert replacement;
        delete replacement;
        System.assertEquals('Available',[SELECT Availability_Status__c FROM Venue__c WHERE Id=:v.Id].Availability_Status__c);
    }
    @IsTest static void duplicateAndBulkBookings() {
        Client__c c=client(); Venue__c v=venue();
        insert eventRecord(c.Id,v.Id,10);
        Database.SaveResult conflict=Database.insert(eventRecord(c.Id,v.Id,10),false);
        System.assertEquals(false,conflict.isSuccess());
        System.assert(conflict.getErrors()[0].getMessage().contains('already booked'));
        List<Event__c> batch=new List<Event__c>{eventRecord(c.Id,v.Id,20),eventRecord(c.Id,v.Id,20)};
        Database.SaveResult[] results=Database.insert(batch,false);
        System.assertEquals(true,results[0].isSuccess());
        System.assertEquals(false,results[1].isSuccess());
        List<Event__c> many=new List<Event__c>();
        for(Integer i=0;i<200;i++) many.add(eventRecord(c.Id,v.Id,100+i));
        Test.startTest(); insert many; Test.stopTest();
        System.assertEquals(200,many.size());
    }
    @IsTest static void requiredDetailsAndVenueMove() {
        Client__c c=client(); Venue__c a=venue(); Venue__c b=venue();
        Database.SaveResult missing=Database.insert(new Event__c(Name='Incomplete',Event_Status__c='Confirmed'),false);
        System.assertEquals(false,missing.isSuccess());
        Event__c e=eventRecord(c.Id,a.Id,10); insert e;
        e.Venue__c=b.Id; update e;
        System.assertEquals('Available',[SELECT Availability_Status__c FROM Venue__c WHERE Id=:a.Id].Availability_Status__c);
        System.assertEquals('Reserved',[SELECT Availability_Status__c FROM Venue__c WHERE Id=:b.Id].Availability_Status__c);
        b.Availability_Status__c='Not Available'; update b;
        e.Event_Status__c='Canceled'; update e;
        System.assertEquals('Not Available',[SELECT Availability_Status__c FROM Venue__c WHERE Id=:b.Id].Availability_Status__c);
    }
    @IsTest static void clientEmailRule() {
        Database.SaveResult bad=Database.insert(new Client__c(Name='Invalid'),false);
        System.assertEquals(false,bad.isSuccess());
        System.assert(bad.getErrors()[0].getMessage().contains('Valid Email'));
        System.assertNotEquals(null,client().Id);
    }
}