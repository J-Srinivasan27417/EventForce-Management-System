public without sharing class EventForceService {
    private static Boolean blocks(Event__c e) {
        return e.Event_Status__c != 'Canceled' && e.Event_Status__c != 'Rejected' && e.Event_Status__c != 'Completed';
    }
    public static void validateBookings(List<Event__c> records) {
        Set<Id> venues = new Set<Id>();
        Set<Id> ids = new Set<Id>();
        Set<Date> dates = new Set<Date>();
        for (Event__c e : records) {
            if (e.Id != null) ids.add(e.Id);
            if (e.Venue__c != null) venues.add(e.Venue__c);
            if (e.Event_Date__c != null) dates.add(e.Event_Date__c);
            if ((e.Event_Status__c == 'Confirmed' || e.Event_Status__c == 'Pending Cancellation') && (e.Venue__c == null || e.Client__c == null || e.Event_Date__c == null)) {
                e.addError('A confirmed event needs a client, venue, and event date.');
            }
        }
        if (venues.isEmpty()) return;
        // Lock shared venues to serialize competing booking transactions.
        List<Venue__c> locked = [SELECT Id FROM Venue__c WHERE Id IN :venues FOR UPDATE];
        Set<String> booked = new Set<String>();
        for (Event__c e : [SELECT Id, Venue__c, Event_Date__c, Event_Status__c FROM Event__c WHERE Venue__c IN :venues AND Event_Date__c IN :dates AND Id NOT IN :ids]) {
            if (blocks(e)) booked.add(String.valueOf(e.Venue__c) + ':' + String.valueOf(e.Event_Date__c));
        }
        for (Event__c e : records) {
            if (!blocks(e) || e.Venue__c == null || e.Event_Date__c == null) continue;
            String key = String.valueOf(e.Venue__c) + ':' + String.valueOf(e.Event_Date__c);
            if (booked.contains(key)) e.addError('This venue is already booked for the selected event date.');
            else booked.add(key);
        }
    }
    public static void syncVenues(List<Event__c> records, List<Event__c> previous) {
        Set<Id> venues = new Set<Id>();
        if (records != null) for (Event__c e : records) if (e.Venue__c != null) venues.add(e.Venue__c);
        if (previous != null) for (Event__c e : previous) if (e.Venue__c != null) venues.add(e.Venue__c);
        if (venues.isEmpty()) return;
        Set<Id> reserved = new Set<Id>();
        for (AggregateResult row : [SELECT Venue__c venue FROM Event__c WHERE Venue__c IN :venues AND Event_Status__c IN ('Confirmed', 'Pending Cancellation') GROUP BY Venue__c]) {
            reserved.add((Id) row.get('venue'));
        }
        List<Venue__c> changes = new List<Venue__c>();
        for (Venue__c v : [SELECT Id, Availability_Status__c FROM Venue__c WHERE Id IN :venues]) {
            if (v.Availability_Status__c == 'Not Available') continue;
            String desired = reserved.contains(v.Id) ? 'Reserved' : 'Available';
            if (v.Availability_Status__c != desired) {
                v.Availability_Status__c = desired;
                changes.add(v);
            }
        }
        if (!changes.isEmpty()) update changes;
    }
}