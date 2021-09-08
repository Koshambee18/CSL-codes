trigger RevenueTrigger on Revenue__c (after insert,before insert) {
    if(Trigger.isBefore && Trigger.isInsert){
        TH_RevenueTrigger.beforeInsertError(Trigger.new);
    }
    if(Trigger.isAfter && Trigger.isInsert){
        TH_RevenueTrigger.afterInsert(Trigger.new);
    }
}