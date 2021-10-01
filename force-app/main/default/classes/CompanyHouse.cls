/**
 * @File Name          : CompanyHouse.cls
 * @Description        : Its a APIIngration and On the basis of any Company First name it searches all the data from the google database and show the result.
 * @Author             : Koshambee
 * @Group              : Cloud Science Labs
 * @Last Modified By   : koshambee@cloudsciencelabs.com
 * @Last Modified On   : 27/09/2021
 * @Modification Log   :
 *==============================================================================
 **/
public class CompanyHouse {
    final Static String CONTENT_TYPE ='Content-Type';
    final Static String METHOD ='GET';
    final Static String AUTHORIZATION ='Authorization';
    final Static String TYPE ='application/json';
    public Static List<Object> companyDetails = new List<Object>(); 
    public static String company_number,title,description,address_snippet,kind,items,company_status,company_type,address_line_1,address_line_2,postal_code,locality,country,premises,self;
    public Static Integer items_per_page,start_index	,page_number,total_results;
    public Static Date date_of_creation; 
    public static List<CompanyShowAll> companyDataList = new List<CompanyShowAll>();
    public static List<companyFullDetails> cfdList = new List<companyFullDetails>(); 
    public static Authorization__c cs = Authorization__c.getInstance();      
    
    @AuraEnabled
    public static List<CompanyShowAll> getCompanyDetails(String URL){
        system.debug('URL '+URL);
             
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        Http ht = new Http();
        req.setEndpoint(URL);
        req.setMethod(METHOD);
        req.setHeader(CONTENT_TYPE, TYPE);
        req.setHeader(AUTHORIZATION, cs.AuthorizationKey__c);
        try {
            res = ht.send(req);
            //system.debug(res.getStatusCode());
            if (res.getStatusCode() == 200) {
                //System.debug('200'+res.getBody());
                
                Map<String, Object> results = (Map<String,Object>)JSON.deserializeUntyped(res.getBody());
                
                companyDetails = (List<Object>)results.get('items');
                //System.debug('items  '+companyDetails);
                for(Object cmp : companyDetails){
                    
                    Map<String,Object> data = (Map<String,Object>)cmp;
                    // List<Object> datadetails = (List<object>).data.get('address');
                    CompanyShowAll allData = new CompanyShowAll();
                    title = String.valueOf(data.get('title'));
                    company_number = String.valueOf(data.get('company_number'));
                    description =  String.valueOf(data.get('description'));
                    address_snippet = String.valueOf(data.get('address_snippet'));
                    company_status = String.valueOf(data.get('company_status'));
                    company_type = String.valueOf(data.get('company_type'));
                    page_number = Integer.valueOf(results.get('page_number'));
                    items_per_page = Integer.valueOf(results.get('items_per_page'));
                    total_results = Integer.valueOf(results.get('total_results'));
                    start_index = Integer.valueOf(results.get('start_index'));
                    
                    
                    
                    System.debug('title '+title);
                    System.debug('company_number '+company_number);
                    System.debug('description '+description);
                    System.debug('address_snippet '+address_snippet);
                    System.debug('company_status '+company_status);
                    System.debug('company_type '+company_type);
                    System.debug('start_index '+start_index);
                    System.debug('total_results '+total_results);
                    System.debug('items_per_page '+items_per_page);
                    System.debug('page_number '+page_number);
                    
                    allData.companyName = title;
                    allData.companyStatus = company_status;
                    allData.addressSnippet = address_snippet;
                    allData.companyType = company_type;
                    allData.companyCode = company_number;
                    allData.description = description;
                    allData.totalResults = total_results;
                    allData.pageNumber = page_number;
                    allData.itemsPerPage = items_per_page;
                    allData.startIndex = start_index;
                    
                    companyDataList.add(allData);
                    
                    
                }
            }
        }
        catch(System.CalloutException e){
            System.debug('Callout error '+e.getMessage());
            
        }
        return companyDataList;
        
    }
    
    
    @AuraEnabled
    public static List<companyFullDetails> getCompanyFullDetails(String companyNumber,String URL){
        
        
        List<Object> cfdObjList = new List<Object>();
        
        String company_name,registeredAddress,postalCode,company_status,companyType,sic_code,registeredAddress2,locality,country;
        Date date_of_creation,made_upto,due_by,last_account_date,next_statement_date,next_statement_due_date,last_statement_date;

        Authorization__c cs = Authorization__c.getInstance();      
        
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        Http ht = new Http();
        req.setEndpoint(URL);
        req.setMethod('GET');
        req.setHeader(CONTENT_TYPE,'application/json');
        req.setHeader(AUTHORIZATION, cs.AuthorizationKey__c);
        
        
        try {
            res = ht.send(req);

            if (res.getStatusCode() == 200) {
                System.debug('DEBUG'+res.getStatusCode());
              	Map<String, Object> results = (Map<String,Object>)JSON.deserializeUntyped(res.getBody());
                Map<String, Object> registerdAddMap = (Map<String,Object>)results.get('registered_office_address');
                //cfdObjList = (List<Object>)results.get('registered_office_address');
                
               
                System.debug('results'+results);
                System.debug('registered_office_address'+registerdAddMap.get('address_line_1'));

                      companyFullDetails cfd = new companyFullDetails();
                     
                     company_status = (String) results.get('company_status');
                     company_name = (String) results.get('company_name');
                     registeredAddress = (String) registerdAddMap.get('address_line_1');
                     postalCode = (String) registerdAddMap.get('postal_code');
                     registeredAddress2 =  (String) registerdAddMap.get('address_line_2');
                     locality = (String) registerdAddMap.get('locality');
                     country = (String) registerdAddMap.get('country');
                     
                     
                     cfd.registeredAddress1 = registeredAddress;
                     cfd.postalCode = postalCode;
                     cfd.registeredAddress2 = registeredAddress2;
                     cfd.locality = locality;
					 cfd.country = country;       
                     cfd.company_status =company_status;
                     cfd.company_name = company_name;             
                     
                     cfdList.add(cfd);
              //   }
            }
        }
        catch(System.CalloutException e){
            System.debug('Callout error '+e.getMessage());
            
        }
        
        
        
        
        return cfdList;
    }
    
    
    
    
    

    public class CompanyShowAll{
        @AuraEnabled
        public String companyName {get; set;}
        @AuraEnabled
        public String companyStatus {get; set;}
        @AuraEnabled
        public String addressSnippet {get; set;}
        @AuraEnabled
        public String companyType {get; set;}
        @AuraEnabled
        public String companyCode {get; set;}
        @AuraEnabled
        public String description {get; set;}
        @AuraEnabled
        public Integer totalResults {get; set;}
        @AuraEnabled
        public Integer startIndex {get; set;}
        @AuraEnabled
        public Integer pageNumber {get; set;}
        @AuraEnabled
        public Integer itemsPerPage {get; set;}
        
        
    }
    
    public class companyFullDetails{
        
        @AuraEnabled
        public String registeredAddress1 {get; set;}
        @AuraEnabled
        public String registeredAddress2 {get; set;}
        @AuraEnabled
        public String locality {get; set;}
        @AuraEnabled
        public String country {get; set;}
        @AuraEnabled
        public String postalCode {get; set;}
        @AuraEnabled
        public String company_status {get; set;}
         @AuraEnabled
        public String company_name {get; set;}
        @AuraEnabled
        public String companyType {get; set;}
        @AuraEnabled
        public Date  date_of_creation{get; set;}
        @AuraEnabled
        public Date  made_upto{get; set;}
        @AuraEnabled
        public Date  due_by{get; set;}
        @AuraEnabled
        public Date  last_account_date{get; set;}
        @AuraEnabled
        public Date  next_statement_date{get; set;}
        @AuraEnabled
        public Date  next_statement_due_date{get; set;}
        @AuraEnabled
        public Date  last_statement_date{get; set;}
        @AuraEnabled
        public String sic_code{get; set;}

        
      
    }
    
}