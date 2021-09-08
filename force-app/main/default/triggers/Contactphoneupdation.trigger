trigger Contactphoneupdation on Account (after insert,after update) {
    List<Contact> cc = new List<Contact>();
    Set<id> accid = new Set<id>();
    
        for(Account acc:trigger.new)
        {
            if(acc.phone != trigger.oldMap.get(acc.id).phone){
                accid.add(acc.id);
                System.debug('trigger.oldMap.get(acc.id).phone '+trigger.oldMap.get(acc.id).phone);
            }
        }
    
    if(!accId.isEmpty()){
    }
    
    List<Account> ac= [Select id,name,(Select id, otherphone,homephone from contacts) from Account where Id =: accid]; 
    for(Account acc:ac){
        
        for(contact c: acc.contacts){
            c.homephone = trigger.newMap.get(acc.id).phone;
            c.otherphone = trigger.oldMap.get(acc.id).phone;
            cc.add(c);
        }    
        
    }
    if(!cc.isEmpty()){
        update cc;
    }
}