public with sharing class AccountHandler {
    public static Account insertNewAccount(String accName) {
        Account account = new Account(Name = accName);
        try {
            insert account;
            //Database.SaveResult[] saveResultList = Database.insert(acc,false);
        }
        catch(DMLException e){
            return null;
        }
        return account;
        //return saveResultList;
    }
}
