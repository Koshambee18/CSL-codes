public class openPopupController {

    
@AuraEnabled
public static void getAccessToken(List<String> tokenLst){
System.debug('Fetched');
System.debug('accesstoken'+tokenLst);
AccessToken__c con = new AccessToken__c();
con.id = 'a0F5g000001X7eoEAC';
con.Token__c = tokenLst[0];
update con;



}


}