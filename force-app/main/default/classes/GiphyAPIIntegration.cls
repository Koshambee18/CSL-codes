public class GiphyAPIIntegration {
    public static void getGifs(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api.giphy.com/v1/gifs/trending?api_key=IptJT5a9fSf9XTATIyHOFHg7pOShbPty&s=rose&limit=20');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        try{
            if (response.getStatusCode() == 200) {
                Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                Map<String, Object> mapData = (Map<String, Object>)results.get('data');
                }
        }catch(Exception e){
            System.debug(e.getMessage());
        }
    }

}