trigger TestPracticeTrigger on Account (before insert) {

    for(Account acc:Trigger.New){
        if(acc.is_gold__c == true){
            acc.AccountNumber = '012121';
        }        
    }
    
    
    
}