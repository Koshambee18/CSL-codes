trigger Out_of_ZipTrigger on Account (after update) {
    Set<ID> AccIDs = new Set<ID>();
    List<Account> accList = new List<Account>(); 
    Map<ID,Account> accountID = new Map<ID,Account>();
    for(Account ac : Trigger.new){
        if(Trigger.newMap.get(ac.id).BillingPostalCode!= Trigger.oldMap.get(ac.id).BillingPostalCode){
            AccIDs.add(ac.Id);
            accountID.put(ac.Id, ac);
        }  
    }
    for(Contact con:[SELECT id, AccountId, Name, MailingAddress, MailingPostalCode 
                     FROM Contact WHERE AccountID in:AccIDs]){
        if(con.AccountId!=null){
            //accountID.get(con.AccountId);
            System.debug('accountID.get(con.AccountId).BillingPostalCode'+accountID.get(con.AccountId).BillingPostalCode);
            System.debug('con.MailingPostalCode'+con.MailingPostalCode);
            if(accountID.get(con.AccountId).BillingPostalCode != con.MailingPostalCode){
                
                Account acc = new Account();
                acc.Out_of_Zip__c = true;
                acc.Id = con.AccountId;
                accList.add(acc);
            }

        } 
    }
    if(!accList.isEmpty()){
        update accList;
        
    }
}