trigger LeadTrigger on Lead (before insert,before update) {
    if(Trigger.isbefore &&(Trigger.isinsert ||Trigger.isupdate)){
        TH_ThrowErrorLead.thowError(Trigger.new);
    }

}