public class TH_OppStageTrigger {
    public static void updateRating(List<Opportunity> oppList){
        Set<ID> AccID = new Set<ID>();
        List<Account> accList = new List<Account>(); 
        for(Opportunity opp :oppList){
           System.debug('7dsd');
            if(opp.StageName =='Closed Won' && opp.AccountId!=null){
                System.debug('7');
                AccID.add(opp.AccountId); 
            }
        }
        for(Opportunity ops :[Select id,accountId, Name, StageName From Opportunity Where AccountId in :AccID]){
            Account ac = new Account();
            ac.Rating = 'Hot';
            ac.Id =  ops.accountId;
            accList.add(ac);
            
        }
        System.debug('accList'+accList);
        if(!accList.isEmpty())
        {
            update accList;
        }
    }
    
}