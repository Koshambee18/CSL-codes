/**
* @File Name          : TH_AccountTrigger.cls
* @Description        : All 
* @Author             : Koshambee
* @Group              : Cloud Science Labs
* @Last Modified By   : koshambee@cloudsciencelabs.com
* @Last Modified On   : 25/8/2021
* @Modification Log   :
*================================================================================================================================
**/
public class TH_ProfileAccountTrigger {
    public static void afterupdate(List<Account> accList){
        Set<Id> AccID = new Set<Id> (); 
        List<Contact> conList = new List<Contact>();
        Map<Id,Integer> accountToNoofContact = new Map<Id,Integer>();
        for(Account ac : accList){
            AccID.add(ac.id);
        }
        
        for (Account ar : [SELECT Name,Id,Website,(SELECT LastName, Profile__c FROM Contacts ) FROM Account WHERE ID in:AccID]){
            accountToNoofContact.put(ar.id,ar.Contacts.size());
            System.debug('accountToNoofContact '+accountToNoofContact);
            System.debug(ar.Contacts);
        }
        for(Contact con :[SELECT id, Profile__c, FirstName, LastName,Account.Website FROM Contact WHERE AccountID in:AccID] ){
            if(con.FirstName!=null && con.Account.Website != null){
                Contact c = new Contact();
                c.id = con.id;
                c.Profile__c = con.Account.Website +'/' + con.FirstName.subString(0,1)+''+con.LastName;
                conList.add(c);
                
            }
        }
        
        if(!conList.isEmpty()){
            update conList;
        }
        
        
    }
}