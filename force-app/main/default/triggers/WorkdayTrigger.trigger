trigger WorkdayTrigger on Workday__c (after insert ,after update) {
    if(Trigger.isInsert && Trigger.isAfter){
        TH_WorkdayTriggerCreate.conCreate(Trigger.new);
    }

}