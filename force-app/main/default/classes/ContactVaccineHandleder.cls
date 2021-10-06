public class ContactVaccineHandleder {
    
    public static Integer latitude,longitude,available_capacity_dose2,fee,min_age_limit,available_capacity_dose1,available_capacity;
    public static String  center_id,name,address,state_name,district_name,block_name,fee_type,vaccine,slots;
    public static Boolean allow_all_age;
    public static List<Cowin_Availability__c> cowinList = new List<Cowin_Availability__c>(); 
    public static List<CowinData> cowinDataList = new List<CowinData>();
    public static List<Object> cowinDetails = new List<Object>();
    
    @InvocableMethod(label='Send Vaccine Email' description='Send the mail to vaccinated or non-vaccinated people' category='Contact')
    public static void vaccinated(List<Id> contactIds){
        Map<Id,Contact> conMap = new Map<Id,Contact>();
        for(Contact contact: [SELECT id,name,Vaccinated__c,Pincode__c,cowinDate__c,IsInsert__c,Email FROM Contact WHERE ID IN: contactIds]){
            conMap.put(contact.Id,contact);
        }
        
        
        
        for(Id con:contactIds){
            if(conMap.get(con).Vaccinated__c == true){
                
                EmailTemplate templateId = [Select id from EmailTemplate where name = 'VaccinatedNotificationTemplate'];
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                String[] sendingTo = new String[]{conMap.get(con).Email};
                mail.setToAddresses(sendingTo);
                mail.setTemplateID(templateId.Id);
                mail.setSaveAsActivity(false);
                mail.setTargetObjectId(con);
                system.debug(' templateId  '+templateId);
                system.debug(' sendingTo  '+sendingTo);
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
                
            }
            if(conMap.get(con).Vaccinated__c == false){
                List<CowinController.cowinData> cowin = new List<CowinController.CowinData>();
                getDetails(Integer.valueof(conMap.get(con).Pincode__c), conMap.get(con).cowinDate__c, conMap.get(con).IsInsert__c,con);   
                System.debug('<<<<<<cowinDataList>>>>>'+cowinDataList);
                
            }
            
        }
    }
    
    @future(callout=true)
    public static void getDetails(Integer pincode,date cowinDate,Boolean isInsert,Id conId) {
        Map<Id,Contact> contMap = new Map<Id,Contact>();
        for(Contact contact: [SELECT id,name,Vaccinated__c,Pincode__c,cowinDate__c,IsInsert__c,Email FROM Contact WHERE ID =: conId]){
            contMap.put(contact.Id,contact);
        }
        
        String codate = String.valueOf(cowinDate.day())+'-'+String.valueOf(cowinDate.month())+'-'+String.valueOf(cowinDate.year());
        
        
        
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        Http http = new Http();
        
        
        req.setEndpoint('https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByPin?pincode='+pincode+'&date='+codate);
        
        req.setMethod('GET');
        req.setHeader('Content-Type', 'application/json');  
        
        try {
            res = http.send(req);
            system.debug(res.getStatusCode());
            if (res.getStatusCode() == 200) {
                System.debug('200'+res.getBody());
                
                Map<String, Object> results = (Map<String,Object>)JSON.deserializeUntyped(res.getBody());
                cowinDetails = (List<Object>)results.get('sessions');
                system.debug('cowinDetails '+cowinDetails);
                
                
                for(Object fld : cowinDetails){    
                    CowinData cowData = new CowinData();
                    
                    Map<String,Object> data = (Map<String,Object>)fld;
                    System.debug('CenterID');
                    System.debug(String.valueOf(data.get('center_id')));
                    center_id = String.valueOf(data.get('center_id'));
                    latitude = Integer.valueOf(data.get('lat'));
                    longitude = Integer.valueOf(data.get('long'));
                    available_capacity_dose2 = Integer.valueOf(data.get('available_capacity_dose2'));
                    fee = Integer.valueOf(data.get('fee'));
                    min_age_limit = Integer.valueOf(data.get('min_age_limit'));
                    name =  String.valueOf(data.get('name'));
                    address = String.valueOf(data.get('address'));
                    state_name = String.valueOf(data.get('state_name'));
                    district_name = String.valueOf(data.get('district_name'));
                    block_name = String.valueOf(data.get('block_name'));
                    fee_type = String.valueOf(data.get('fee_type'));
                    vaccine = String.valueOf(data.get('vaccine'));
                    slots = String.valueOf(data.get('slots'));
                    allow_all_age = boolean.valueOf(data.get('allow_all_age'));
                    available_capacity = Integer.valueOf(data.get('available_capacity'));
                    available_capacity_dose1 = Integer.valueOf(data.get('available_capacity'));
                    
                    
                    cowData.centerid =center_id;
                    cowData.Name = Name;
                    cowData.BlockName = block_name;
                    cowData.DistrictName = district_name;
                    cowData.Pincode = pincode;
                    cowData.AvailableCapacity = available_capacity;
                    cowData.AvailableCapacityDose1 = available_capacity_dose1;
                    cowData.MinAgeLimit = min_age_limit;
                    cowData.Fee=fee;
                    cowData.AvailableCapacityDose2 = available_capacity_dose2;
                    cowData.longitude = longitude; 
                    cowData.latitude = latitude;
                    cowData.Slots = slots;
                    cowData.cowinDetailsList = cowinDetails;
                    
                    cowinDataList.add(cowData);
                    
                }
                
                
                //EmailTemplate templateId = [Select id from EmailTemplate where name = 'NotVaccinatedNotificationTemplate'];
                
                string body = '<div  style="background-color: aliceblue;margin-top: 40px;font-size: medium;"><b>Hello,<br/><br/>This mail is regarding the Covid-19 vaccine Details in your Block. Please Check the details from the below table<br/><br/></div>';
                
                for(CowinData cowData : cowinDataList)
                {
                    body = body+'<br/>CenterId : '+cowData.centerid+' Name of the Hospital : '+cowData.Name+' Block Name : '+cowData.BlockName+' District Name : '+cowData.DistrictName+' Available Capacity : '+cowData.AvailableCapacity+' Minimum Age Limit : '+cowData.MinAgeLimit+' Slots : '+cowData.Slots;
                    
                }
                
                body = body+'<br/><br/>Thanks and Regards<br/>Koshambee';
                
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                String[] sendingTo = new String[]{contMap.get(conId).Email};
                mail.setToAddresses(sendingTo);
                mail.setSaveAsActivity(false);
                mail.setTargetObjectId(conId);
                mail.setSubject('COVID Vaccine Details');
                
                mail.setHtmlBody(body);
                //con.CowinDataList__c = CowinController.getDetails(834001, date.newInstance(2021, 10, 01), false)
                //con.CowinDataList__c = CowinController.CowinData;
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
                
                
            } else {
                System.debug('HTTP error: ' + res.getStatusCode());
            }
            
        }catch(System.CalloutException e) {
            System.debug('Callout erro0');
            System.debug('error'+e.getLineNumber());
            System.debug('errormsf'+e.getMessage());
            
        }
        
        
    }
    
    public class CowinData{
        
        @AuraEnabled
        public String centerid {get; set;}
        @AuraEnabled
        public String Name {get; set;}
        @AuraEnabled
        public String BlockName {get; set;}
        @AuraEnabled
        public String DistrictName {get; set;}
        @AuraEnabled
        public Integer Pincode {get; set;}
        @AuraEnabled
        public Integer latitude {get; set;}
        @AuraEnabled
        public Integer longitude {get; set;}
        @AuraEnabled
        public Integer AvailableCapacityDose2 {get; set;}
        @AuraEnabled
        public Integer Fee {get; set;}
        @AuraEnabled
        public Integer MinAgeLimit {get; set;}
        @AuraEnabled
        public Integer AvailableCapacity {get; set;}
        @AuraEnabled
        public Integer AvailableCapacityDose1 {get; set;}
        @AuraEnabled
        public String Slots {get; set;}
        @AuraEnabled
        public List<Object> cowinDetailsList {get; set;}
        
    }    
    
}