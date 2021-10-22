public class OneDriveController {
    public virtual class BaseException extends Exception {}
    public static String getAccessToken(){
        String token;
        String redirectUrl = 'https://login.microsoftonline.com/common/oauth2/nativeclient';
        oneDrive__c onedrive = oneDrive__c.getInstance();
        //Getting access token from google
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setEndpoint('https://login.microsoftonline.com/common/oauth2/v2.0/token');
        //req.setHeader('content-type', 'application/x-www-form-urlencoded');
        
        String messageBody='client_id='+onedrive.ClientID__c+
            '&scope=https://graph.microsoft.com/.default'+
            '&client_secret='+onedrive.ClientSecret__c+
            '&redirect_uri='+redirectUrl+
            '&grant_type=client_credentials';        
        
        req.setHeader('Content-length', String.valueOf(messageBody.length()));
        req.setBody(messageBody);
        req.setTimeout(60*1000);
        
        Http callout = new Http();
        String responseText;
        HttpResponse response = callout.send(req);
        
        system.debug('response:' + response.getBody());
        if(response.getStatusCode()==200)
        {            
            responseText = response.getBody();
            Map<String,object> responseMap =(Map<String,object>)JSON.deserializeUntyped(responseText) ;  
            token=String.valueOf(responseMap.get('access_token'));
            system.debug('responseMap:' + responseMap);
            System.debug('token'+token);
        }
        return token;
        
    }
    
    
    //Upload Documents of passed record id
    public void UploadDocuments(string recordId)
    {
        string accessToken=getAccessToken();
        if(string.isBlank(accessToken))
        {
            throw new BaseException('Issue in Authentication');
        }
        List<ContentDocumentLink> links=[SELECT ContentDocumentId,LinkedEntityId FROM ContentDocumentLink where LinkedEntityId=:recordId];
        Set<Id> ids=new Set<Id>();
        for(ContentDocumentLink link:links)
        {
            ids.add(link.ContentDocumentId);
        }
        List<ContentVersion> versions=[SELECT VersionData,Title,ContentDocumentId,FileExtension FROM ContentVersion WHERE ContentDocumentId = :ids AND IsLatest = true];
        
        for(ContentVersion attach:versions)
        {
            try
            {
                uploadFile();
            }
            catch(Exception ex)
            {
                throw new BaseException(ex);
            }
        }
    }
    
    //Content Type based on Content Version
    public static string ContentType(string fileType)
    {
        switch on fileType.toLowerCase()
        {
            when 'docx'
            {
                return 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
            }
            when 'csv'
            {
                return 'application/vnd.ms-excel';
            }
            when 'wav'
            {
                return 'audio/wav';
            }
            when 'wmv'
            {
                return 'video/x-ms-wmv';
            }
            when 'mp3'
            {
                return 'audio/mpeg';
            }
            when 'mp4'
            {
                return 'video/mp4';
            }
            when 'png'
            {
                return 'image/png';
                
            }
            when 'pdf'
            {
                return 'application/pdf';
                
            }
            when 'txt'
            {
                return 'text/plain';
                
            }
            when else {
                return 'image/jpeg';
            }
        }
    }
    
    public static void uploadFile(){
        List<ContentVersion> ListFilesToBeUploaded = [select id,title,VersionData from ContentVersion];
        String accessToken,title,extn;
        String filename = 'gif';
        string contentType = ContentType('png');
        try{
        System.debug('Test');   
        String endpointUrl='https://graph.microsoft.com/v1.0/users/54986d57-f766-47c1-bef0-8efe4b3c9fb4/drive/items/root:/{file}:/content';
        String file=EncodingUtil.URLENCODE(filename,'UTF-8').replace('+', '%20');
        endpointUrl=endpointUrl.replace('{file}',file+'.'+'png');
        for(ContentVersion cv : ListFilesToBeUploaded){
           
        System.debug(cv.versionData);
		System.debug(cv.title);
		System.debug(getAccessToken());
            
        String attachmentBody = EncodingUtil.base64Encode(cv.versionData);
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpointUrl);
        req.setMethod('PUT'); 
        req.setHeader('Authorization','Bearer ' + getAccessToken());
        req.setHeader('Content-Encoding', 'UTF-8');
        req.setHeader('Content-type', 'application/octet-stream');
        req.setHeader('accept', 'application/json');
        Http http = new Http();
        system.debug('getBody1 '+req);
        req.setBodyAsBlob(cv.VersionData);
        req.setTimeout(120000);
        
        HTTPResponse res = http.send(req);
        system.debug('getBody2 '+res.getBody());
        System.debug('Status Code '+res.getStatusCode());
        if(res.getStatusCode()==200)
        {
            system.debug('getBody '+res.getBody());
            
        }
            
        }
            
        }
        
        catch(exception e){
        System.debug('Error Line '+e.getLineNumber());     
        System.debug('Error Message '+e.getMessage());    
        }
        
        
    } 
    
}