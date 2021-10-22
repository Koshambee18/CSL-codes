public class FileUploadOneDrive {
    public static String token = [SELECT id,Token__c FROM AccessToken__c].Token__c;
    public static List<uploadedFileDetails> uploadDetails = new List<uploadedFileDetails>();
    
	@AuraEnabled
    public static void uploadContentDoc(list<Object> filesToInsert){
   
        
        try{
            for (Object file : filesToInsert) {
                
            FileInfo fileData = (FileInfo)JSON.deserialize(JSON.serialize(file), FileInfo.class);

            Http http = new Http();
            httpRequest req = new httpRequest();
            req.setMethod('PUT');
        	
            
            String endPoint = 'https://graph.microsoft.com/v1.0/me/drive/root:/'+fileData.Title+':/content';
            system.debug('#### endpoint: ' + endPoint);
            req.setEndpoint(endPoint);
            
            req.setHeader('Authorization','Bearer'+' '+token);
            req.setHeader('Content-Type', 'application/pdf');
        	req.setHeader('Accept', '*/*');
            
            req.setBodyAsBlob(EncodingUtil.base64Decode(fileData.VersionData));
            
            httpResponse res = new httpResponse();
            res = http.send(req);
            integer statusCode = res.getStatusCode();
            string resBody = res.getBody();
            system.debug('#### sc: ' + statusCode);
            system.debug('#### rb: ' + resBody);
             }

        }
        catch(Exception e){
            System.debug('errormessage '+e.getMessage());
            System.debug('error Lines '+e.getLineNumber());

        }
                            
        }
        
        

        
       public class FileInfo {
        public String Title;
        public String VersionData;
    } 
    
    @AuraEnabled
    public static List<uploadedFileDetails> saveData(){
        try{
           
        Http http = new Http();
            HttpRequest req = new HttpRequest();
            HttpResponse res = new HttpResponse();
            
            String endPoint = 'https://graph.microsoft.com/v1.0/me/drive/root/children';
            system.debug('#### endpoint: ' + endPoint);
            req.setMethod('GET');
            req.setEndpoint(endPoint);
            req.setHeader('Authorization','Bearer'+' '+token);
            req.setHeader('Accept', '*/*');
            System.debug(token);
            //req.setHeader('Content-Type', 'application/json');
           
            res = http.send(req);
            system.debug('STATUS>'+res.getStatusCode());
             system.debug('STATUS>'+res.getBody());
            if (res.getStatusCode() == 200) {
                System.debug('200'+res.getBody());
                
                Map<String, Object> results = (Map<String,Object>)JSON.deserializeUntyped(res.getBody());
                List<Object> value = (List<Object>)results.get('value');
                System.debug('value ' +value);
                for(object vlue :value){
                     uploadedFileDetails uploadfile = new uploadedFileDetails();
                    Map<String,Object> data = (Map<String,Object>)vlue;
                    system.debug(data.get('createdDateTime'));
                    
                    String name = (String)data.get('name');
                    String webUrl = (String)data.get('webUrl');
                    String id = (String)data.get('id'); 
                    Integer size = (Integer)data.get('size');
                    String createdDateTime = (String)data.get('createdDateTime');
                    
                    uploadfile.NameWC = name;
                    
                    uploadfile.webUrlWC = webUrl;
                    uploadfile.idWC = id;
                    uploadfile.sizeWC = size;
                    uploadfile.createdDateTimeWC = createdDateTime;
                    uploadDetails.add(uploadfile);
                    System.debug('uploadDetails '+uploadDetails);
                    
                }
               
            }
            
        }
        catch(Exception e){
            System.debug('errormessage '+e.getMessage());
            System.debug('error Lines '+e.getLineNumber());

        }
        return uploadDetails;
        
    }

    public class uploadedFileDetails{
        @AuraEnabled
        public String NameWC{get; set;}
        @AuraEnabled
        public String webUrlWC{get; set;}
        @AuraEnabled
        public String idWC{get; set;}
        @AuraEnabled
        public Integer sizeWC{get; set;}
        @AuraEnabled
        public string createdDateTimeWC{get; set;}
        
    }
        
    }