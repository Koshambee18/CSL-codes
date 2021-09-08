trigger Only_Default_AccountTrigger on Contact (after insert) {

    Set<Id> accountIds = new Set<Id>();
        for(Contact con : Trigger.New) {
            if(con.AccountId !=null){
                 accountIds.add(con.AccountId);
            }
            
        }
        
        List<Account> updatedAccounts = new List<Account>();
        for(AggregateResult ar : [select count(id),AccountId from Contact where AccountId IN :accountIds group by AccountId having count(id) >1]){
            updatedAccounts.add(new Account(Id = (Id)ar.get('AccountId'), Only_Default_Contact__c=false));    
        }
        
        if(!updatedAccounts.isEmpty())
            update updatedAccounts;
    }