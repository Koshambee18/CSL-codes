public with sharing class LwcController {
    // Retrive list of contact list
    @AuraEnabled
        public static List<Contact> getContactList() {
            return [SELECT Id,AccountId, FirstName,LastName,Email,Phone FROM Contact limit 10];
        }
    }
