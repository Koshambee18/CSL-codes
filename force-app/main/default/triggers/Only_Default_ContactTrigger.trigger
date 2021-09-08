trigger Only_Default_ContactTrigger on Account (after insert) {
    List<Contact> conList = new List<Contact>();
    List<Account> accList = new List<Account>();
    for(Account acc : Trigger.New) {
        Contact con = new Contact(AccountId = acc.Id);
        con.FirstName='Info@';
        con.LastName='Default'+acc.Name;
        con.Email='info'+acc.Name+'@websitedomain.tld';
        
        conList.add(con);
    }
    insert conList; 
    
    for(Account ac:Trigger.New){
        Account acc = new Account();
        acc.id = ac.Id;
        acc.Only_Default_Contact__c =  true;
        
        accList.add(acc);    
    }
    
    
    update accList;
    
    
}