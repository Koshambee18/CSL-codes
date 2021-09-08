public class TH_DeleteContact {
    public static void deleteCon(List<Account> accList){
        Set<String> accName = new Set<String>();
        Set<String> ConFirstName = new Set<String>();
        Set<String> ConLastName = new Set<String>();
        List<Contact> conList = new List<Contact>();
        for(Account ac: accList){
            accName.add(ac.Name);
        }
        for(Contact con : [SELECT id, FirstName, LastName FROM Contact]){
            ConFirstName.add(con.FirstName);
            ConLastName.add(con.LastName);
            if(ConFirstName.containsAll(accName)||ConLastName.containsAll(accName)){
                conList.add(con);
                System.debug('conList' +conList);
            }
            
        }
        if(!conList.isEmpty()){
         Delete conList; 
        }
    }

}