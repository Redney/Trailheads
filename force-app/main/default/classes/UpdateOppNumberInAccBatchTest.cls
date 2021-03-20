@isTest
private class UpdateOppNumberInAccBatchTest {
    @testSetup
    static void setup() {
        List<Account> accounts = new List<Account>();
        List<Opportunity> opportunities = new List<Opportunity>();
        
        for (Integer i=0;i<10;i++) {
            accounts.add(new Account(name='AccountBatchTest'));
        }
        insert accounts;
        
        for (Account account : [
            SELECT id
            FROM account]) {
                opportunities.add(new Opportunity(Name = 'oppName',
                StageName = 'Prospecting',
                CloseDate = system.today()+1, accountId=account.id));
        }
        insert opportunities;
    }


    @isTest static void testEmptyField() {
        Test.startTest();
        UpdateOpportunityNumberInAccountBatch updateFieldBatch = new UpdateOpportunityNumberInAccountBatch();
        Id batchId = Database.executeBatch(updateFieldBatch);
        Test.stopTest();
        
        System.assertNotEquals(null, [
            SELECT Number_of_Opportunities__c
            FROM Account
            ]);
    }
}
