trigger AccountTrigger on Account (before insert,before update,after insert,after update,before delete){
    if(Trigger.IsInsert && Trigger.isAfter){
        TH_Only_Default_Account.checkOnly_Default(Trigger.new); 
    }
    if(Trigger.IsUpdate && Trigger.isAfter){
        TH_Out_of_Zip.checkOut_of_Zip(Trigger.New, Trigger.newMap, Trigger.oldMap);
    }
    if(Trigger.Isdelete && Trigger.isbefore){
        TH_TwoContactMsg.showError(Trigger.Old);
    }
    if(Trigger.isUpdate && Trigger.isbefore){
        TH_PhoneUpdateionContact.updateName(Trigger.new, Trigger.oldMap);
    }
    
    if(Trigger.IsUpdate && Trigger.isAfter){
        TH_ProfileUpdation.updateProfile(Trigger.new);
    }
    
    if(Trigger.isupdate && Trigger.isAfter){
        TH_ContactphoneupdateTrigger.updatePhone(Trigger.New, Trigger.newMap, Trigger.oldMap);
        
    }
    
    if(Trigger.IsInsert && Trigger.isAfter){
        TH_DeleteContact.deleteCon(Trigger.New);
    }
    
}