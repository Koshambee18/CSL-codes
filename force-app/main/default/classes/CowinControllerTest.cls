@istest
public class CowinControllerTest {
    static testMethod void validateData(){

        Test.setMock(HttpCalloutMock.class, new CowinControllerMock());
		Test.startTest();
        cowinController.getDetails(834001, date.newInstance(2021, 09, 23),true);
        cowinController.getDetails(834001, date.newInstance(2021, 09, 23),false);
       
		Test.stopTest();
        
    }
         
}