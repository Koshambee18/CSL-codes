/**create a checkbox as "Vaccinated" in contact ,if vaccianted checkbox is checked send a mail to contact email that ,
 * Thanks.Else if vaccinated checkbox is not checked then check pincoode of contact and send the current vacciine 
 * slots for their area in there mail
**/

trigger ContactVaccineTrigger on Contact (after insert) {
    for(Contact con : Trigger.New){
        
        
    }
    

}