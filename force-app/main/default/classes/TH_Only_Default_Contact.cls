public class TH_Only_Default_Contact {
    public static void checkDefault(List<Contact> conList){
        Set<Id> accountIds = new Set<Id>();
        for(Contact con : conList) {
            if(con.AccountId!=null){
                 accountIds.add(con.AccountId);
            }
            
        }
        
        List<Account> updatedAccounts = new List<Account>();
        for(AggregateResult ar : [select count(id),AccountId from Contact where AccountId IN :accountIds group by AccountId having count(id) >1]){
            updatedAccounts.add(new Account(Id = (Id)ar.get('AccountId'), Only_Default_Contact__c=false));    
        }
        
    if(!updatedAccounts.isEmpty()){
        update updatedAccounts;
    }
    }

}