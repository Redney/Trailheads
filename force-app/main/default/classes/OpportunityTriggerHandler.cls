public with sharing class OpportunityTriggerHandler {

    public void oppInsertUndelete(List<Opportunity> oppsNew) {
        // System.debug('--->  TRIGGERED  ->  inserter or undeleted');
        
        List<Id> accIds = new List<Id>();

        for (Opportunity opp : oppsNew) {
            accIds.add(opp.AccountId);
        }
        
        updateNumber(accIds);
    }

    public void oppDelete(List<Opportunity> oppsOld) {
        List<Id> accIds = new List<Id>();
        for (Opportunity opp : oppsOld) {
            accIds.add(opp.AccountId);
        }
        updateNumber(accIds);
    }

    public void oppUpdate(List<Opportunity> oppsNew, Map<Id, Opportunity> oppsOldMap) {
        List<Id> accIds = new List<Id>();
        for (Opportunity oppCurrent : oppsNew) {
            if (oppCurrent.AccountId != oppsOldMap.get(oppCurrent.Id).AccountId) {
                // add both new and old id to update 
                accIds.add(oppCurrent.AccountId);
                accIds.add(oppsOldMap.get(oppCurrent.Id).AccountId);
            }
            accIds.add(oppCurrent.AccountId);
        }
        updateNumber(accIds);
    }

    public static void updateNumber(List<Id> accIds) {   
        List<Account> oppNumbersOnAccount = [
            SELECT Number_of_Opportunities__c, (SELECT Id FROM Opportunities)
            FROM Account
            WHERE Id IN :accIds
        ];
        // System.debug('list nums in updateNumber ---->' + oppNumbersOnAccount);
                 
        for(Account acc : oppNumbersOnAccount) {
            acc.Number_of_Opportunities__c = acc.Opportunities.size();
            // System.debug('number of opps ---->' + acc.Number_of_Opportunities__c);
        }	

        update oppNumbersOnAccount;
    }
}
