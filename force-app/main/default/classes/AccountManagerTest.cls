@isTest 
private class AccountManagerTest{
    @isTest
    static void checkAccount() {
        Account acc = new Account(Name = 'TestAcc');
        insert acc;

        Contact con = new Contact(FirstName = 'aa', LastName = 'bb', AccountId = acc.Id);
        insert con;

        Id recordId = acc.Id;

        RestRequest request = new RestRequest();
        request.requestUri = 'https://brave-moose-gp2a6h-dev-ed.my.salesforce.com/services/apexrest/Accounts/'
            + recordId +'/contacts';
        request.httpMethod = 'GET';
        RestContext.request = request;
        
        Account thisAccount = AccountManager.getAccount();
        
        System.assert(thisAccount!= null);
        System.assertEquals('TestAcc', thisAccount.Name);
    }

    @isTest
    static void checkCreation() {
        
        Map<String, String> s = new Map <String, String>();
        
        s.put ('anna', 'v');
        s.put ('v', 'anna');
        ID thisAccId = AccountManager.createAccountAndContacts('AccountPostName', s);
        
        System.assert(thisAccId != null);
        Account thisAcc = [
            SELECT Id, Name 
            FROM Account 
            WHERE Id=:thisAccId
        ];
        System.assert(thisAcc != null);
        System.assertEquals(thisAcc.Name, 'AccountPostName');
    }
}
