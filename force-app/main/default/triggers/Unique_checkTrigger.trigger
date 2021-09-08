trigger Unique_checkTrigger on Contact (before insert,before update) {
    Set<Contact> conListOld = new Set<Contact>(); 
    Set<Contact> conListNew = new Set<Contact>();
    Boolean result;
    if(Trigger.isInsert){
        for(Contact connew:Trigger.new){
            conListNew.add(connew);
            
            System.debug('conListNew '+conListNew);
            
        }
    }
    if(Trigger.isupdate){
        for(Contact conold:Trigger.old){
            
            conListOld.add(conold);
            
            System.debug('conListOld '+conListOld);
        } 
    }
    
    for(Contact connew:Trigger.new){
        conListNew.add(connew);
        if(!conListOld.isEmpty()){
            result = conListOld.containsAll(conListNew);
            
            if(result=true){
                connew.addError('Cannot create this record because there is already contact exists with given information.');
                System.debug('conListNew '+conListNew);
            }
        }
        
        
        
    }
    
}