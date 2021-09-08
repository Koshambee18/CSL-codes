public class TH_Unique_check {
    public static void showUniqueCheckError(List<Contact> conNewList){
        Set<Contact> conListOld = new Set<Contact>(); 
        Set<ID> conListNew = new Set<ID>();
        Set<String> combList = new Set<String>();
        Set<String> combListOld = new Set<String>();
        
        
        for(Contact c:[SELECT id,FirstName,LastName,Email FROM Contact]){
            if(c.FirstName!=null){
                combListOld.add(c.FirstName);
            }
            if(c.LastName!=null){
                combListOld.add(c.LastName);
            }
            if(c.Email!=null){
                combListOld.add(c.Email);
            }
            
            
        }
        
        for(Contact con:conNewList){
            if(con.FirstName!=null){
                combList.add(con.FirstName);
            }
            if(con.LastName!=null){
                combList.add(con.LastName);
            }
            if(con.Email!=null){
                combList.add(con.Email);
            }
            if(combListOld.containsAll(combList)){
                con.addError('Cannot create this record because there is already');
            }
        }
        
        
    }
}