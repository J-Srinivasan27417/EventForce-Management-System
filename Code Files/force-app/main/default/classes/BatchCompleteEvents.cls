public without sharing class BatchCompleteEvents implements Database.Batchable<SObject>, Schedulable {
    public Database.QueryLocator start(Database.BatchableContext context) {
        return Database.getQueryLocator([SELECT Id, Event_Status__c FROM Event__c WHERE Event_Date__c < TODAY AND Event_Status__c != 'Completed']);
    }
    public void execute(Database.BatchableContext context, List<Event__c> scope) {
        for (Event__c e : scope) e.Event_Status__c = 'Completed';
        update scope;
    }
    public void finish(Database.BatchableContext context) {}
    public void execute(SchedulableContext context) {
        Database.executeBatch(new BatchCompleteEvents(), 200);
    }
}
