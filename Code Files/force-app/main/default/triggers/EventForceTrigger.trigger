trigger EventForceTrigger on Event__c (before insert, before update, after insert, after update, after delete, after undelete) {
    if (Trigger.isBefore) EventForceService.validateBookings(Trigger.new);
    else EventForceService.syncVenues(Trigger.isDelete ? null : Trigger.new, (Trigger.isUpdate || Trigger.isDelete) ? Trigger.old : null);
}