public class TH_Only_Default_Account {
    public Static void checkOnly_Default(List<Account> accList){
        List<Contact> conList = new List<Contact>();
        List<Account> acList = new List<Account>();
        for(Account acc : accList) {
            Contact con = new Contact(AccountId = acc.Id);
            con.FirstName='Info@';
            con.LastName='Default'+acc.Name;
            con.Email='info'+acc.Name+'@websitedomain.tld';
            
            conList.add(con);
        }
        insert conList;	
        
        for(Account ac:accList){
            Account acc = new Account();
            acc.id = ac.Id;
            acc.Only_Default_Contact__c =  true;
            acList.add(acc);    
        }
        update acList;
        
        
        
    }
    
}