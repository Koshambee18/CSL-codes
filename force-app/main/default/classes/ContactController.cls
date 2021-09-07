public with sharing class ContactController {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts() {
      // The following line is used only for the last challenge
      throw new AuraHandledException('Forced error');
      // return [SELECT FirstName, LastName, Email FROM Contact ORDER BY LastName, FirstName];
    }
}