trigger ThrowErrorLead on Lead (before insert,before update) {
    map<String,Contact>  conMap = new map<String, Contact>();
    List<Contact> conList = [Select id, name, email From Contact Where Email<>Null];
    Set<Id> contactId = new Set<Id>();
    for (contact con:conList)
    {
        conMap.put(con.email,con);
    }
    for(lead ld : trigger.new)
    {
        if(ld.email != null){
            if(conMap.containsKey(ld.email)){
                ld.Email.addError('Email already exists in contact');
            }                  
        }               
    }
    
    
    
}