/**
* @File Name          : TH_RevenueTrigger.cls
* @Description        : On the basis of start date and end date of revenue monthly revenue will be generated
* @Author             : Koshambee
* @Group              : Cloud Science Labs
* @Last Modified By   : koshambee@cloudsciencelabs.com
* @Last Modified On   : 25/8/2021
* @Modification Log   :
*==============================================================================
**/
public class TH_RevenueTrigger {
    public static void beforeInsertError(List<Revenue__c> revLstBefore){
        for(Revenue__c rev1 :revLstBefore){
            if(rev1.Start_Date__c>rev1.End_Date__c){
               rev1.Start_Date__c.addError('Please enter a valid date. Start Date cannot be in future'); 
            }
        }
    }
    public static void afterInsert(List<Revenue__c> revLst){
        List<Monthly_Revenue__c> monthlyRevList =  new List<Monthly_Revenue__c>();
        List<Revenue__c> revList = new List<Revenue__c>();
        Integer monthDiff,noOfDays, dateDiff, DayinMonth,dateDifffromfirsttolastday;
        Date dt;
        Date startDate;
        Date endDate;
        
        
        List<String> monthYearList = new List<String>(); 
        Map<Integer,String> monthNameMap=new Map<Integer, String>{1 =>'Jan', 2=>'Feb', 3=>'Mar', 4=>'Apr', 5=>'May',
            6=>'Jun', 7=>'July', 8=>'Aug', 9=>'Sep',10=>'Oct',
            11=>'Nov', 12=>'Dec'};
                for(Revenue__c rev:revLst){
                    revList.add(rev);
                    startDate = rev.Start_Date__c;
                    endDate = rev.End_Date__c;
                }
        
        while(startDate<endDate){
            monthYearList.add(startDate.Year() + '|' + startDate.Month());
   			 startDate = startDate.AddMonths(1);
        }
         monthYearList.add(Enddate.Year() + '|' + Enddate.Month());
        System.debug('monthYearList'+monthYearList.size());
        for(Revenue__c rev:revList){
            for(String monYr:monthYearList){
                dateDiff= Date.daysInMonth(integer.valueof(monYr.SubStringBefore('|')),integer.valueof(monYr.SubStringAfter('|'))) - rev.Start_Date__c.day();
                DayinMonth = Date.daysInMonth(integer.valueof(monYr.SubStringBefore('|')),integer.valueof(monYr.SubStringAfter('|')));


                Monthly_Revenue__c mrev = new Monthly_Revenue__c();
                mrev.Start_Date__c = Date.newInstance(integer.valueof(monYr.SubStringBefore('|')),integer.valueof(monYr.SubStringAfter('|')),1);
                mrev.End_Date__c = Date.newInstance(integer.valueof(monYr.SubStringBefore('|')),integer.valueof(monYr.SubStringAfter('|')),Date.daysInMonth(integer.valueof(monYr.substringBefore('|')),integer.valueof(monYr.SubStringAfter('|'))));
                dateDifffromfirsttolastday = mrev.Start_Date__c.daysBetween(mrev.End_Date__c);
                mrev.Name = monthNameMap.get(integer.valueof(monYr.SubStringAfter('|'))) +' '+monYr.SubStringBefore('|') + ' ' +'('+dateDifffromfirsttolastday+' '+ 'days'+')-'+DayinMonth;
                mrev.Monthly_Quantity__c= DayinMonth*rev.Quantity__c/rev.Start_Date__c.daysBetween(rev.End_Date__c);
                mrev.Price__c = rev.Price__c;
                mrev.Monthly_Amount__c= Math.round(DayinMonth*rev.Quantity__c/rev.Start_Date__c.daysBetween(rev.End_Date__c)) *rev.Price__c;
                mrev.Revenue__c = rev.Id;
                
                monthlyRevList.add(mrev);
                System.debug('dateDifffromfirsttolastday --- ' +dateDifffromfirsttolastday);
                System.debug('Days in month --- ' +DayinMonth);
                System.debug('Difference between dates --- '+rev.Start_Date__c.daysBetween(rev.End_Date__c));
                
            } 
        }
        if(!monthlyRevList.isEmpty()){
            insert monthlyRevList;
        }
    }
}