@isTest
private class OpportunityTriggerTest {
    @testSetup
    static void setup() {
        List<Account> accounts = new List<Account>();
        List<Opportunity> opportunities = new List<Opportunity>();
        
        for (Integer i=0;i<10;i++) {
            accounts.add(new Account(Name='AccountOppTriggerTest'+i));
        }
        insert accounts;
        
        for (Account account : [
            SELECT id
            FROM account]) {
                opportunities.add(new Opportunity(Name = 'OppTriggerTest',
                StageName = 'Prospecting',
                CloseDate = system.today()+1, accountId=account.id));
        }
        insert opportunities;
    }

    @isTest static void testInsertOpportunities() {
        Test.startTest();
        List<Opportunity> opp = [
            SELECT Id
            FROM Opportunity
            WHERE Name = 'OppTriggerTest'
        ];
        Test.stopTest();
        
        System.assertEquals(10, opp.size());   
    }

    @isTest static void testDeleteOpportunities() {
        Test.startTest();
        Opportunity opp = [
            SELECT Id
            FROM Opportunity
            WHERE Name = 'OppTriggerTest'
            LIMIT 1
        ];
        Database.DeleteResult result = Database.delete(opp, true);
        Test.stopTest();

        System.assertNotEquals(null, [
            SELECT Number_of_Opportunities__c
            FROM Account
            ]);   
    }

    @isTest static void testUpdateOpportunities() {
        Test.startTest();
        Account accId1 = [
            SELECT Id
            FROM Account
            WHERE Name = 'AccountOppTriggerTest1'
            LIMIT 1
        ];
        Opportunity opp = [
            SELECT Id
            FROM Opportunity
            WHERE AccountId = :accId1.Id
            LIMIT 1
        ];
        Account accId2 = [
            SELECT Id
            FROM Account
            WHERE Name = 'AccountOppTriggerTest0'
            LIMIT 1
        ];
        
        opp.AccountId = accId2.Id;
        
        Database.SaveResult result = Database.update(opp, true);
        Test.stopTest();

        Account acc = [
            SELECT Number_of_Opportunities__c
            FROM Account
            WHERE Name = 'AccountOppTriggerTest0'
            LIMIT 1
            ];
        System.assertEquals(2, acc.Number_of_Opportunities__c);   
    }
}
