@RestResource(urlMapping='/Accounts/*')
global with sharing class AccountManager {
    
    @HttpGet
    global static Account getAccount() {
        RestRequest request = RestContext.request;
        String accountId = request.requestURI.substringBetween('Accounts/','/contacts');
        
        Account acc = [
            SELECT Id, Name,   (SELECT Id, Name
                                FROM Contacts) 
            FROM Account
            WHERE Id = :accountId
        ];

        return acc;
    }

    // @HttpPost
    // global static ID createAccountAndContacts(String accName, String cFirstname, String cLastname) {
    //     Account thisAcc = new Account(Name = accName);
    //     insert thisAcc;

    //     Contact thisCon = new Contact(Firstname = cFirstname, Lastname = cLastname, AccountId = thisAcc.Id);
    //     insert thisCon;

    //     return thisAcc.Id;
    // }

    @HttpPost
    global static ID createAccountAndContacts(String accName, Map<String, String> conMap) {
        Account thisAcc = new Account(Name = accName);
        insert thisAcc;

        Map<String, String> contactsNameMap = new Map<String, String> (conMap);
        List<Contact> contactsToInsert = new List<Contact>();
        String fName = 'anna', lName = 'v';
        contactsNameMap.put(fName, lName);
        
        for (String s : contactsNameMap.values()) {
            Contact thisCon = new Contact(Firstname = contactsNameMap.get(fName), Lastname = contactsNameMap.get(fName), AccountId = thisAcc.Id);
            contactsToInsert.add(thisCon);
        }
        insert contactsToInsert;

        return thisAcc.Id;
    }
}
