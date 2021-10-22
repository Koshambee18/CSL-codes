/**
* @File Name          : GiphyAPIIntegration.cls
* @Description        : .
* @Author             : Koshambee
* @Group              : Cloud Science Labs
* @Last Modified By   : koshambee@cloudsciencelabs.com
* @Last Modified On   : 11/10/2021
* @Modification Log   :
*==============================================================================
**/

public class GiphyAPIIntegration {
    final Static String CONTENT_TYPE ='Content-Type';
    final Static String METHOD ='GET';
    final Static String AUTHORIZATION ='Authorization';
    final Static String TYPE ='application/json';
    Public static String imgURL,embed_url;
    Public static List<GifsDetails> gifsList = new List<GifsDetails>();
    public static List<Object> DataList = new List<Object>();
    @AuraEnabled
    public static List<GifsDetails> getGifs(String toFind){
        String API = 'IptJT5a9fSf9XTATIyHOFHg7pOShbPty';
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api.giphy.com/v1/gifs/trending?api_key='+API+'&s='+toFind+'&limit=20');
        //request.setEndpoint(URL);
        request.setMethod(METHOD);
        request.setHeader(CONTENT_TYPE, TYPE);
        request.setHeader(AUTHORIZATION, API);
        HttpResponse response = http.send(request);
        try{
            if (response.getStatusCode() == 200) {
                Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                DataList = (List<Object>)results.get('data');
                system.debug('Data '+DataList);
                }
            
            for(Object gifsObj : DataList){
                Map<String,Object> DataMap = (Map<String,Object>)gifsObj;
                GifsDetails allgifs = new GifsDetails();
                //System.debug('DataMap '+DataMap);
                imgURL = String.valueOf(DataMap.get('url'));
                embed_url = String.valueOf(DataMap.get('embed_url'));
                System.debug('imgURL '+imgURL);
                System.debug('embed_url '+embed_url);
                allgifs.urlwc = imgURL;
                allgifs.embadedurlwc = embed_url;
                gifsList.add(allgifs);
                
            }
        }catch(Exception e){
            System.debug(e.getMessage());
        }
        return gifsList;
    }
    
    public class GifsDetails{
        
        @AuraEnabled
        public String urlwc {get; set;}
        @AuraEnabled
        public String embadedurlwc {get; set;}
    
    }

}