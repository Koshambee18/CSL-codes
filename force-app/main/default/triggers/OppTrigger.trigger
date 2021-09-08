trigger OppTrigger on Opportunity (after insert,after update) {

       if(Trigger.isUpdate && Trigger.isAfter){
            TH_OppStageTrigger.updateRating(Trigger.new);
    }

    TH_goldTrigger.updateAcc(Trigger.new);
}