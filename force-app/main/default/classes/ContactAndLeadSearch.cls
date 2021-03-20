public with sharing class ContactAndLeadSearch {
    public static List<List<sObject>> searchContactsAndLeads(String namePart) {
        
        List<List<sObject>> searchList = [FIND :namePart IN Name FIELDS 
                   RETURNING Contact(Name, LastName),Lead(FirstName,LastName)];

        return searchList;
    }
}
