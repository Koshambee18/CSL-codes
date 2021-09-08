public class TH_ThrowErrorLead {
    public static void thowError(List<Lead> leadList){
        map<String,Contact>  conMap = new map<String, Contact>();
        List<Contact> conList = [Select id, name, email From Contact Where Email<>Null];
        Set<Id> contactId = new Set<Id>();
        for (contact con:conList)
        {
            conMap.put(con.email,con);
        }
        for(lead ld : leadList)
        {
            if(ld.email != null){
                if(conMap.containsKey(ld.email)){
                    ld.Email.addError('Email already exists in contact');
                }                  
            }               
        }
    }
    
}