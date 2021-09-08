public class TH_ProfileUpdation {
    public static void updateProfile(List<Account> listAcc){
        Set<Id> accId = new Set<Id>();
        List<Contact> conList = new List<Contact>(); 
        for(Account ac:listAcc){
            if(ac.Website!= null){
                accId.add(ac.id);    
                
            }
        }
        for(Contact con : [SELECT id, Profile__c, FirstName, LastName, Account.Website FROM Contact WHERE AccountId in :accId]){
            if(con.FirstName!=null && con.LastName!=null && con.Account.Website!=null){
                Contact cn = new Contact();
                cn.Id = con.Id;
                cn.Profile__c = con.Account.Website +'/'+ con.FirstName.substring(0,1)+''+con.LastName;
                conList.add(cn);  
            }
            
            
        }
        if(!conList.isEmpty()){
            update conList;    
        }
        
    }
    
}