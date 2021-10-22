public class QuoteAcccountSync {
    public static Map<Id,List<Quote__c>> quoteToAccountSync(){
        Map<Id,List<Quote__c>> accToQuote = new Map<Id,List<Quote__c>>();
        List<Account> acList =  new List<Account>();
        Map<List<Opportunity>,Account> accounttoOppmap = new Map<List<Opportunity>,Account>();
        List<Account> accList = [Select Id,name,(select Id,name from opportunities) from account];
        
        
        for(Account ac: accList){
            
            accounttoOppmap.put(ac.Opportunities,ac);
        }
        
        System.debug('accounttoOppmap'+accounttoOppmap);
        List<Opportunity> oppList = [Select Id,name,AccountId,(select Id,name from Quotes__r) from Opportunity];
        
        System.debug('oppList'+oppList);
        
        
        for(Opportunity opt:oppList){
            if(opt.AccountId!= null){
                accToQuote.put(opt.AccountId,opt.Quotes__r);
            }
            
        }
        
        
        System.debug('accToQuote'+accToQuote);
        return accToQuote;
        
    }
}