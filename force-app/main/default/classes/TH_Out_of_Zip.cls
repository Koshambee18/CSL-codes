public class TH_Out_of_Zip {
    public static void checkOut_of_Zip(List<Account> accList, Map<Id,Account> Mapnewacc, Map<Id,Account> Mapoldacc){
        Set<ID> AccIDs = new Set<ID>();
        List<Account> acList = new List<Account>(); 
        Map<ID,Account> accountID = new Map<ID,Account>();
        for(Account ac : accList){
            if(Mapnewacc.get(ac.id).BillingPostalCode!= Mapoldacc.get(ac.id).BillingPostalCode){
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
                                     acList.add(acc);
                                 }
                                 
                             } 
                         }
        if(!accList.isEmpty()){
            update acList;
            
        }
    }
    
}