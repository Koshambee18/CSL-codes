/**
* @File Name          : OpenWhetherAPIIntegration.cls
* @Description        : It's a APIIngration for weather forcast.
* @Author             : Koshambee
* @Group              : Cloud Science Labs
* @Last Modified By   : koshambee@cloudsciencelabs.com
* @Last Modified On   : 07/10/2021
* @Modification Log   :
*==============================================================================
**/

public class OpenWhetherAPIIntegration {
    final Static String CONTENT_TYPE ='Content-Type';
    final Static String METHOD ='GET';
    final Static String AUTHORIZATION ='Authorization';
    final Static String TYPE = 'application/json';
    public Static List<Object> weather = new List<Object>();
    public static String name,base,description;
    public static Integer lon,lat,sunset,sunrise,deg,speed,pressure,humidity,temp_max,feels_like,temp,visibility,timezone,id;
    public static List<WeatherDetails> weatherList = new List<WeatherDetails>();
    
    @AuraEnabled
    public static List<WeatherDetails> getWeatherReport(String URL){
        System.debug(URL);
        String API = 'aa2b841e21e2aedb2dcd5b130bafaff4';
        //String CITY = 'Ranchi';
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        Http ht = new Http();
        //req.setEndpoint('https://api.openweathermap.org/data/2.5/weather?q='+CITY+'&appid='+API);
        req.setEndpoint(URL);
        req.setMethod(METHOD);
        req.setHeader(CONTENT_TYPE, TYPE);
        req.setHeader(AUTHORIZATION, API);
        try {
            res = ht.send(req);
            system.debug(res.getStatusCode());
            if (res.getStatusCode() == 200) {
                //System.debug('200'+res.getBody());
                WeatherDetails alldata = new WeatherDetails();
                
                Map<String, Object> results = (Map<String,Object>)JSON.deserializeUntyped(res.getBody());
                System.debug('results '+results);
                weather = (List<Object>)results.get('weather');
                Map<String, Object> main = (Map<String,Object>)results.get('main');
                Map<String, Object> sys = (Map<String,Object>)results.get('sys');
                Map<String, Object> wind = (Map<String,Object>)results.get('wind');
                Map<String, Object> coord = (Map<String,Object>)results.get('coord');
                id = Integer.valueOf(results.get('id'));
                timezone = Integer.valueOf(results.get('timezone'));
                name = (String) results.get('name');
                visibility = Integer.valueOf( results.get('visibility'));
                base = String.valueOf(results.get('base'));
                lon = Integer.valueOf(coord.get('lon'));
                lat = Integer.valueOf(coord.get('lat'));
                temp = Integer.valueOf(main.get('temp'));
                feels_like = Integer.valueOf(main.get('feels_like'));
                temp_max = Integer.valueOf(main.get('temp_max'));
                pressure = Integer.valueOf(main.get('pressure'));
                humidity = Integer.valueOf(main.get('humidity'));
                speed = Integer.valueOf(wind.get('speed'));
                deg = Integer.valueOf(wind.get('deg'));
                sunrise = Integer.valueOf(sys.get('sunrise'));
                sunset = Integer.valueOf(sys.get('sunset'));
                
                for(Object ob : weather){
                    Map<String,Object> data = (Map<String,Object>)ob;
                    //System.debug('data '+data);
                    description = (String)data.get('description');
                    System.debug('description '+description);
                    
                    
                }
                
                System.debug('main '+main);
                System.debug('sys '+sys);
                System.debug('id '+id);
                System.debug('wind '+wind);
                System.debug('coord '+coord);
                System.debug('name '+name);
                System.debug('visibility '+visibility);
                System.debug('base '+base);
                System.debug('humidity '+humidity);
                System.debug('speed '+speed);
                System.debug('deg '+deg);
                System.debug('sunrise '+sunrise);
                System.debug('sunset '+sunset);
                System.debug('pressure '+pressure);
                System.debug('lon '+lon);
                
                
                
                alldata.timezonewc = timezone;
                alldata.idwc = id;
                alldata.namewc = name;
                alldata.sunsetwc = sunset;
                alldata.sunrisewc = sunrise;
                alldata.degwc = deg;
                alldata.speedwc = speed;
                alldata.humiditywc = humidity;
                alldata.pressurewc = pressure;
                alldata.temp_maxwc = temp_max;
                alldata.visibilitywc = visibility;
                alldata.basewc = base;
                alldata.feels_likewc = feels_like;
                alldata.tempwc = temp;
                alldata.latwc = lat;
                alldata.lonwc = lon;
                alldata.descriptionwc = description;

                weatherList.add(alldata);
                
                
                
                
            }
        }
        catch(System.CalloutException e){
            System.debug('Callout error '+e.getMessage());
            System.debug('Error at line '+e.getLineNumber());
            System.debug('Cause of Error '+e.getCause());
            
        }
        return weatherList;
    }
    
    public class WeatherDetails{
        
        @AuraEnabled
        public Integer timezonewc {get; set;}
        @AuraEnabled
        public Integer idwc {get; set;}
        @AuraEnabled
        public String namewc {get; set;}
        @AuraEnabled
        public Integer sunsetwc {get; set;}
        @AuraEnabled
        public Integer sunrisewc {get; set;}
        @AuraEnabled
        public Integer degwc {get; set;}
        @AuraEnabled
        public Integer speedwc {get; set;}
        @AuraEnabled
        public Integer humiditywc {get; set;}
        @AuraEnabled
        public Integer pressurewc {get; set;}
        @AuraEnabled
        public Integer temp_maxwc {get; set;}
        @AuraEnabled
        public Integer visibilitywc {get; set;}
        @AuraEnabled
        public String basewc {get; set;}
        @AuraEnabled
        public Integer lonwc {get; set;}
        @AuraEnabled
        public Integer latwc {get; set;}
        @AuraEnabled
        public Integer tempwc {get; set;}
        @AuraEnabled
        public Integer feels_likewc {get; set;}
        @AuraEnabled
        public String descriptionwc {get; set;}
        
        
    }
}