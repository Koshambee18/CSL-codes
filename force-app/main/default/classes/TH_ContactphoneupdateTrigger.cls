public class TH_ContactphoneupdateTrigger {
    public static void updatePhone(List<Account> accList, Map<Id,Account> Mapnewacc, Map<Id,Account> Mapoldacc){
        List<Contact> cc = new List<Contact>();
        Set<id> accid = new Set<id>();
        
        for(Account acc:accList)
        {
            if(acc.phone != Mapoldacc.get(acc.id).phone){
                accid.add(acc.id);
                System.debug('trigger.oldMap.get(acc.id).phone '+Mapoldacc.get(acc.id).phone);
            }
        }
        
        if(!accId.isEmpty()){
        }
        
        List<Account> ac= [Select id,name,(Select id, otherphone,homephone from contacts) from Account where Id =: accid]; 
        for(Account acc:ac){
            
            for(contact c: acc.contacts){
                c.homephone = Mapnewacc.get(acc.id).phone;
                c.otherphone = Mapoldacc.get(acc.id).phone;
                cc.add(c);
            }    
            
        }
        if(!cc.isEmpty()){
            update cc;
        }
        
    }
    
}