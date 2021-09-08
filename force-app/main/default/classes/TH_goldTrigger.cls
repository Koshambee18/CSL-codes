public class TH_goldTrigger{
    public static void updateAcc(List<Opportunity> oppLists){
    Set<ID> AccID = new Set<ID>();
    Set<ID> AccID2 = new Set<ID>();
    List<Opportunity> oppList = new List<Opportunity>();
    List<Account> AccList = new List<Account>();
    List<Account> AccList2 = new List<Account>();
    for(Opportunity op : oppLists){
        if(op.Amount>20000){
            AccID.add(op.AccountId);  
        }
        else{
            AccID2.add(op.AccountId); 
        }
    }
    for(Id accids :AccID){
        Account ac = new Account();
        ac.id = accids;
        ac.is_gold__c = true;
        AccList.add(ac);
    }
    if(!AccList.isEmpty()){
        update AccList;
        
    }
    for(Id accids :AccID2){
        Account ac = new Account();
        ac.id = accids;
        ac.is_gold__c = false;
        AccList2.add(ac);
    }
    if(!AccList2.isEmpty()){
        update AccList2;
    }   
    }
}