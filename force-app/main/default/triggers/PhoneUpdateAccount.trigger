trigger PhoneUpdateAccount on Account (before insert,before update) {
    List<Account> accList = new List<Account>();
    for(Account ac:Trigger.new){
        if(ac.phone != null){
            ac.Name = ac.name+''+ac.Phone;
            accList.add(ac);
            System.debug('accList  @@'+accList);
            
        }   
    }
}