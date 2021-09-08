public with sharing class TH_WorkdayTriggerCreate {
    public static void conCreate(List<WorkDay__c> workdylist) {
        //Set<Id> conId = new Set<Id>();
        List<Contact> conList = new List<Contact>();
        List<WorkDay__c> newWorkDay = new List<WorkDay__c>(); 
        
        for(WorkDay__c wd : workdylist){
            Contact con = new Contact();
            con.Lastname = wd.Name;
            //con.id = wd.Contact__c;
       
            conList.add(con);
            //con.Starttime__c = Datetime.newInstanceGmt(today().year(), today().month(), today().day()+15, System.now().hour()-5, System.now().minute(), System.now().second());
        }
        System.debug('conList '+conList);
        if(!conList.isEmpty()){
            insert conList ; 
        }
        for(WorkDay__c wd : workdylist){
            WorkDay__c wdays = new WorkDay__c();
            wdays.Starttime__c = Datetime.newInstanceGmt(Date.Today().Year(), Date.Today().month(), Date.Today().day()+15, System.now().hour()-5, System.now().minute(), System.now().second());
            wdays.EndTime__c = Datetime.newInstanceGmt(Date.Today().Year(), Date.Today().month(), Date.Today().day()+25 , System.now().hour()+8, System.now().minute(), System.now().second());
            wdays.Daily_worker__c = true;
            wdays.id = wd.id;
            wdays.Contact__c = conList[0].id;
            newWorkDay.add(wdays);
            

        }
        System.debug('newWorkDay '+newWorkDay);
        if(!newWorkDay.isEmpty()){
          update newWorkDay;  
        }
    }
}