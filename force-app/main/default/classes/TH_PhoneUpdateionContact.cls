public class TH_PhoneUpdateionContact {
    public static void updateName(List<Account> accountList, Map<ID,Account> oldmap){
        List<Account> accList = new List<Account>();
        for(Account ac:accountList){
            if(ac.phone != oldmap.get(ac.id).phone){
                ac.Name = ac.name+''+ac.Phone;
                accList.add(ac);
                System.debug('accList  @@'+accList);
                
            }   
            
        }
        
    }
}