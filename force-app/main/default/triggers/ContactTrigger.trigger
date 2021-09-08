trigger ContactTrigger on Contact (before insert,before update,after insert,after update) {
    if(Trigger.isafter && (Trigger.isinsert||Trigger.isUpdate)){
        TH_need_intel.checkNeedIntel(Trigger.new);  
    }
    
    if(Trigger.isInsert && Trigger.isAfter){
        TH_Only_Default_Contact.checkDefault(Trigger.new);
    }
    if(Trigger.isInsert && Trigger.isBefore){
        TH_Unique_check.showUniqueCheckError(Trigger.New);
    }
}