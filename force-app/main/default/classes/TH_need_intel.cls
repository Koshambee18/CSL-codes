public class TH_need_intel {
    public static void checkNeedIntel(List<Contact> ConList){
        List<Account> accList = new List<Account>();
        Set<ID> AccountID = new Set<ID>();
        Map<ID, Integer> intMap = new Map<ID, Integer>();
        Map<ID, Integer> intMap2 = new Map<ID, Integer>();
        Integer percent;
        for(Contact con :ConList){
            if(con.AccountId!=null){
                AccountID.add(con.AccountId); 
            }
            
            
        }
        for (Account acc : [Select Id, Name, (Select id, AccountID , Name From Contacts Where Dead__c = True) From Account Where Id in :AccountID]){
            
            intMap2.put(acc.id, acc.contacts.size());
        }
        
        for (Account acc : [Select Id, Name, (Select id, AccountID , Name From Contacts) From Account Where Id in :AccountID]){
            
            intMap.put(acc.id, acc.contacts.size());
            System.debug('test1 '+intMap2.get(acc.id));
            System.debug('test2 '+intMap.get(acc.id));
            percent = intMap2.get(acc.id)*100/intMap.get(acc.id);
        }
        System.debug('percent '+percent);
        if(percent >=70){
            for (Account acc : [Select Id, Name, (Select id, AccountID , Name From Contacts) From Account Where Id in :AccountID]){
                Account ac = new Account();
                ac.need_intel__c = True;
                ac.id = acc.id;
                accList.add(ac);
            }
            if(!accList.isEmpty()){
                System.debug('accList  '+accList);
                update accList;
                //System.debug('accList  '+accList);
            }
            
        }
    }
    
}