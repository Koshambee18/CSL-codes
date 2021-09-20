public with sharing class CowinController {

    @AuraEnabled
    public static CowinData getDetails(Integer pincode,date cowinDate) {
        
        //Variables to set 
        Integer latitude,longitude,available_capacity_dose2,fee,min_age_limit,available_capacity_dose1,available_capacity;
        String  center_id,name,address,state_name,district_name,block_name,fee_type,vaccine,slots;
        Boolean allow_all_age;
        List<Cowin_Availability__c> cowinList = new List<Cowin_Availability__c>(); 
        String codate = String.valueOf(cowinDate.day())+'-'+String.valueOf(cowinDate.month())+'-'+String.valueOf(cowinDate.year());
        CowinData cowData = new CowinData();
        
        
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        Http http = new Http();
        
        
        req.setEndpoint('https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByPin?pincode='+pincode+'&date='+codate);
        //req.setEndpoint('https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByPin?pincode=834001&date=25-09-2021');
        
        req.setMethod('GET');
        req.setHeader('Content-Type', 'application/json');  
        
        try {
            res = http.send(req);
            system.debug(res.getStatusCode());
            if (res.getStatusCode() == 200) {
                Map<String, Object> results = (Map<String,Object>)JSON.deserializeUntyped(res.getBody());
                List<Object> cowinDetails = (List<Object>)results.get('sessions');
                for(Object fld : cowinDetails){    
                    Map<String,Object> data = (Map<String,Object>)fld;
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
                    
                    
                    
                }
                
                
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
                
                
                
                
                
                
                
                
                
                Cowin_Availability__c cowin = new Cowin_Availability__c();
                cowin.Address__c = address;
                cowin.State__c = state_name;
                cowin.Vaccine_Name__c = vaccine;
                cowin.Available_Capacity__c = available_capacity;
                cowin.Block_Name__c = block_name;
                cowin.Slots__c = slots;
                cowin.District__c = district_name;
                cowin.Fee_Type__c = fee_type;
                cowin.Available_Dose_2__c = available_capacity_dose2;
                cowin.Fee__c = fee;
                cowin.Allow_All_Age__c = true;
                cowin.Available_Dose_1__c = available_capacity_dose1;
                cowin.Center_Name__c = name;
                cowin.Center_Id_External_Id__c = center_id;
                cowin.Minimum_Age_Limit__c = min_age_limit;
                cowin.Start_Time__c = datetime.now();
                cowin.End_Time__c = datetime.now();
                cowin.Pincode__c = String.valueOf(pincode);
                cowin.Date__c = cowinDate;
                
                insert cowin;
                System.debug(center_id);
                System.debug('Success!');
                System.debug('results'+results);
                System.debug('cowinDetails'+cowinDetails);
                system.debug(res.getBody());
                System.debug(center_id);
                System.debug(available_capacity_dose2);
                System.debug(address);
                System.debug(state_name);
                System.debug(block_name);
                System.debug(fee_type);
                System.debug(vaccine);
                System.debug(slots);
                System.debug(available_capacity);
                System.debug(available_capacity_dose1);
                System.debug(allow_all_age);
                System.debug(vaccine);
                System.debug(name);
                System.debug(district_name);
                System.debug(min_age_limit);
                System.debug(fee);
            } else {
                System.debug('HTTP error: ' + res.getStatusCode());
            }
            System.debug(res.getBody());
        } catch(System.CalloutException e) {
            System.debug('Callout erro0');
            
        }
        
        return cowData;
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
        
    }

    
}