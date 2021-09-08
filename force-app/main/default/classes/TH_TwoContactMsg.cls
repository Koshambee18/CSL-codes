public without sharing class TH_TwoContactMsg {
    public static void showError(List<Account> accList){
        
        Set<ID> Idset = new Set<ID>();
        
        for(Account acc : accList){
          Idset.add(acc.Id); 
        }
        List<Account> accounts = [SELECT Id, Name, (SELECT id FROM Contacts) FROM Account Where id in :Idset];
        for (Account a : accounts) {
            if(a.Contacts.size()>=2){
                a.addError('This account cannot be deleted');  
            }
        }
    }
    
}