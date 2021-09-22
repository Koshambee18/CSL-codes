public class CowinController {
    

        //Global variables 
        public static Integer latitude,longitude,available_capacity_dose2,fee,min_age_limit,available_capacity_dose1,available_capacity;
        public static String  center_id,name,address,state_name,district_name,block_name,fee_type,vaccine,slots;
        public static Boolean allow_all_age;
        public static List<Cowin_Availability__c> cowinList = new List<Cowin_Availability__c>(); 
        public static List<CowinData> cowinDataList = new List<CowinData>();
        public static List<Object> cowinDetails = new List<Object>();

       

    
    @AuraEnabled
    public static List<CowinData> getDetails(Integer pincode,date cowinDate) {
        
        String codate = String.valueOf(cowinDate.day())+'-'+String.valueOf(cowinDate.month())+'-'+String.valueOf(cowinDate.year());

         

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
                System.debug('200'+res.getBody());
                
                Map<String, Object> results = (Map<String,Object>)JSON.deserializeUntyped(res.getBody());
                cowinDetails = (List<Object>)results.get('sessions');
                
                
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
                
                
                

                
               

       
            } else {
                System.debug('HTTP error: ' + res.getStatusCode());
            }
            System.debug(res.getBody());
        } catch(System.CalloutException e) {
            System.debug('Callout erro0');
            
        }

        return cowinDataList;
    }


    @AuraEnabled
    public static void insertCowinDetails(Integer pincode,date cowinDate,List<Object> cowinAvailablityList) {

        for(Object fld : cowinAvailablityList){    
                    
                    Map<Object,Object> data = (Map<Object,Object>)fld;
                    Cowin_Availability__c cowin = new Cowin_Availability__c();
                    cowin.Address__c = String.valueOf(data.get('address'));
                    cowin.State__c = String.valueOf(data.get('state_name'));
                    cowin.Vaccine_Name__c = String.valueOf(data.get('vaccine'));
                    cowin.Available_Capacity__c = Integer.valueOf(data.get('available_capacity'));
                    cowin.Block_Name__c = String.valueOf(data.get('block_name'));
                    cowin.Slots__c = String.valueOf(data.get('slots'));
                    cowin.District__c = String.valueOf(data.get('district_name'));
                    cowin.Fee_Type__c = String.valueOf(data.get('fee_type'));
                    cowin.Available_Dose_2__c = Integer.valueOf(data.get('available_capacity_dose2'));
                    cowin.Fee__c = Integer.valueOf(data.get('fee'));
                    cowin.Allow_All_Age__c = boolean.valueOf(data.get('allow_all_age'));
                    cowin.Available_Dose_1__c = Integer.valueOf(data.get('available_capacity'));
                    cowin.Center_Name__c = String.valueOf(data.get('name'));
                    cowin.Center_Id_External_Id__c = String.valueOf(data.get('center_id'));
                    cowin.Minimum_Age_Limit__c = Integer.valueOf(data.get('min_age_limit'));
                    cowin.Start_Time__c = datetime.now();
                    cowin.End_Time__c = datetime.now();
                    cowin.Pincode__c = String.valueOf(pincode);
                    cowin.Date__c = cowinDate;
                    
                
                	cowinList.add(cowin);
                
                }       
                
                insert cowinList;
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