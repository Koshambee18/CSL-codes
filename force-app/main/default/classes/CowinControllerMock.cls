@isTest
global class CowinControllerMock implements HttpCalloutMock {
    private static final String RESPONSE_BODY ='{"sessions":[{"center_id":578371,"name":"ORCHID HOSPITAL","address":"H.B.ROAD","state_name":"Jharkhand","district_name":"Ranchi","block_name":"Ranchi Urban","pincode":834001,"from":"09:30:00","to":"16:30:00","lat":23,"long":85,"fee_type":"Paid","session_id":"0fef1b99-a878-433d-b879-b1f4e93d2192","date":"25-09-2021","available_capacity":50,"available_capacity_dose1":20,"available_capacity_dose2":30,"fee":"1200","min_age_limit":18,"allow_all_age":true,"vaccine":"COVAXIN","slots":["09:30AM-11:30AM","11:30AM-01:30PM","01:30PM-03:30PM","03:30PM-04:30PM"]},{"center_id":620078,"name":"SARJOO NURSING HOME","address":"PURULIA ROAD RANCHI","state_name":"Jharkhand","district_name":"Ranchi","block_name":"Ranchi Urban","pincode":834001,"from":"09:00:00","to":"18:00:00","lat":23,"long":85,"fee_type":"Paid","session_id":"0246524d-4ed6-497d-96de-3b39cb6a5344","date":"25-09-2021","available_capacity":35,"available_capacity_dose1":17,"available_capacity_dose2":18,"fee":"1410","min_age_limit":18,"allow_all_age":true,"vaccine":"COVAXIN","slots":["09:00AM-11:00AM","11:00AM-01:00PM","01:00PM-03:00PM","03:00PM-06:00PM"]},{"center_id":607446,"name":"SEVA SADAN","address":"UPPER BAZAR","state_name":"Jharkhand","district_name":"Ranchi","block_name":"Ranchi Urban","pincode":834001,"from":"10:00:00","to":"15:00:00","lat":23,"long":85,"fee_type":"Paid","session_id":"b46d48e0-a06b-4e4d-b60f-b044e7e07696","date":"25-09-2021","available_capacity":46,"available_capacity_dose1":18,"available_capacity_dose2":28,"fee":"780","min_age_limit":18,"allow_all_age":true,"vaccine":"COVISHIELD","slots":["10:00AM-11:00AM","11:00AM-12:00PM","12:00PM-01:00PM","01:00PM-03:00PM"]},{"center_id":578371,"name":"ORCHID HOSPITAL","address":"H.B.ROAD","state_name":"Jharkhand","district_name":"Ranchi","block_name":"Ranchi Urban","pincode":834001,"from":"09:30:00","to":"16:30:00","lat":23,"long":85,"fee_type":"Paid","session_id":"e203d880-1828-4022-9f6f-c634b5cd48b7","date":"25-09-2021","available_capacity":49,"available_capacity_dose1":20,"available_capacity_dose2":29,"fee":"780","min_age_limit":18,"allow_all_age":true,"vaccine":"COVISHIELD","slots":["09:30AM-11:30AM","11:30AM-01:30PM","01:30PM-03:30PM","03:30PM-04:30PM"]},{"center_id":579831,"name":"Hospital Medanta","address":"Irba Ranchi","state_name":"Jharkhand","district_name":"Ranchi","block_name":"Ranchi Urban","pincode":834001,"from":"09:00:00","to":"15:00:00","lat":28,"long":77,"fee_type":"Paid","session_id":"6b353430-a93f-4ee5-ac88-fae319759f89","date":"25-09-2021","available_capacity":57,"available_capacity_dose1":57,"available_capacity_dose2":0,"fee":"1145","min_age_limit":18,"allow_all_age":true,"vaccine":"SPUTNIK V","slots":["09:00AM-10:00AM","10:00AM-11:00AM","11:00AM-12:00PM","12:00PM-03:00PM"]}]}';
    public static final String RESPONSE_HEADER_PARAM_NAME = 'Content-Type';
    public static final String RESPONSE_HEADER_CONTENT_TYPE = 'application/json';
    
    //implement the following method
    
    global HTTPResponse respond(HttpRequest req){
        HttpResponse resp=new HttpResponse();
        resp.setHeader(RESPONSE_HEADER_PARAM_NAME, RESPONSE_HEADER_CONTENT_TYPE);
        resp.setBody(RESPONSE_BODY);
        resp.setStatusCode(200);
        return resp;
        
    }
    
}