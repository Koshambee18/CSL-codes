trigger MoreThatTwoContactMsgc on Account (before delete) {
    List<Account> accounts = [SELECT Id, Name, (SELECT id FROM Contacts) FROM Account Where id in :Trigger.new];
    for (Account a : accounts) {
        
        if(a.Contacts.size()>=2){
            a.addError('This account cannot be deleted');  
        }
    }
    
}