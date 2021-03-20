public class UpdateOpportunityNumberInAccountBatch implements Database.Batchable<sObject>, Database.Stateful {
    public integer processedRecords = 0;

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator ([
            SELECT Id 
            FROM Account
            WHERE Number_of_Opportunities__c = null
        ]);
    }
     
    
    public void execute(Database.BatchableContext bc, List<Account> accList) {
        List<Account> numbers = [
            SELECT Number_of_Opportunities__c, (SELECT Id FROM Opportunities)
            FROM Account
            WHERE Id IN :accList
        ];
        
        for (Account acc : accList) {
            acc.Number_of_Opportunities__c = acc.Opportunities.size();
        }

        try {
            database.saveresult[] ds =  Database.update(accList,false);
                for(database.SaveResult d : ds){
                    if(d.issuccess()) {
                        processedRecords++;
                    }
                    
                }
            } catch(exception e) {
            System.debug('update failed');
        }
    }
    
    public void finish(Database.BatchableContext bc) {
        // System.debug('finish-context: ' + bc);
        System.debug('Total updated records: ' + processedRecords);

        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();

        AsyncApexJob apexJob = [
            SELECT Id, Status, NumberOfErrors, TotalJobItems, CreatedBy.Email
            FROM AsyncApexJob
            WHERE Id =: bc.getJobId()
        ];

        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

        List<String> toAddresses = new List<String>{'anna.volodko@gmail.com'};

        mail.setToAddresses(toAddresses);
        mail.setSubject('Batch UpgradeOpptyToActiveDialogue finished. Status: ' + apexJob.Status);
        mail.setPlainTextBody('The batch apex job processed.\nTotal job items: ' 
            + apexJob.TotalJobItems + '.\nBatches errors: ' + apexJob.NumberOfErrors
            + ' failures.\nTotat ' + processedRecords + ' records were processed.');

        List<Messaging.SingleEmailMessage> emailsToSend = new List<Messaging.SingleEmailMessage>();
        emailsToSend.addAll(emails);
        emailsToSend.add(mail);

        if (!Test.isRunningTest()) {
            Messaging.sendEmail(emailsToSend);
        }
    }
}
