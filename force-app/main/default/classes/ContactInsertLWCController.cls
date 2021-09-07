public without sharing class ContactInsertLWCController {
    @AuraEnabled
    public static void createContact(String accId,string firstname,string lastname,string email,string title,string phone,string department,date birthdate){
    List<Contact> newContact = new List<Contact>();
    Contact con = new Contact();
    con.AccountId = accId;
    con.firstname = firstname;
    con.lastname = lastname;
    con.email = email;
    con.phone = phone;
    con.department = department;
    con.birthdate = birthdate;
    con.title = title;

    newContact.add(con);
    insert newContact;


    }


    }