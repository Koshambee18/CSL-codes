import { LightningElement,track } from 'lwc';
import getCompanyDetails from '@salesforce/apex/CompanyHouse.getCompanyDetails';
import getCompanyFullDetails from '@salesforce/apex/CompanyHouse.getCompanyFullDetails';
import { NavigationMixin } from 'lightning/navigation';


export default class CompanyhouseAPIIntegration extends NavigationMixin(LightningElement) {
    @track available = false;
    @track size = 0;
    @track cmpName = '';
    @track start_index = 0;
    companyDetails;
   // @track items_per_page = this.items_per_page ;
    @track start_index =this.start_index;   
    @track page_number =this.page_number;
    
    @track isLoading = false;
    @track paginationRange = [];

    @track total_results = this.total_results;
    
    
    


handleSearchData(event){

if (event.target.label == 'Enter any Company First name to search') {
    
            this.cmpName = event.target.value;
}
if (event.target.label == 'Start Index') {
    
            this.start_index = event.target.value;
}

this.isLoading = true;

 getCompanyDetails({URL:'https://api.company-information.service.gov.uk/search/companies?q='+this.cmpName+'&start_index='+this.start_index+'items_per_page=100'})
 .then((result)=>{
    this.isLoading = false;
    console.log('sdsdsddsadsadadasrfsdgbewstrhewhtjkervbhytjkgubetir');
      console.log(JSON.parse(JSON.stringify(result)));
      this.companyDetails = JSON.parse(JSON.stringify(result))

  
      this.size = this.companyDetails.length;
      
      this.items_per_page = this.companyDetails.length;

      
      console.log(this.items_per_page);
      console.log(this.page_number);
      console.log(this.start_index);
      console.log(this.total_results);

      //this.total_results = 

      if (this.size > 0) {
                    this.available = true;
                }
      })
      .catch((error) => {
                this.error = error;
                console.log(error);
                 });
}

onLinkClick(event){
    let code = event.currentTarget.dataset.cdetails;
    let fullCompanyDetails  = [];

    console.log(code);
    getCompanyFullDetails({companyNumber:code,URL:'https://api.company-information.service.gov.uk/company/'+code})
     .then((result)=>{

fullCompanyDetails = JSON.parse(JSON.stringify(result));


         console.log('Test');
          console.log(JSON.parse(JSON.stringify(result)));
          console.log('fullCompanyDetails @'+fullCompanyDetails);
         var compDefinition = {
            componentDef: "c:companyHouseDetails",
            attributes: {
                propertyValue: "500",
                fullCompanyDetails: JSON.parse(JSON.stringify(result))
            },
            
        };
        
        // Base64 encode the compDefinition JS object
        var encodedCompDef = btoa(JSON.stringify(compDefinition));
        this[NavigationMixin.Navigate]({
            type: 'standard__webPage',
            attributes: {
                url: '/one/one.app#' + encodedCompDef
            }
        });

     })
     .catch((error) => {
                this.error = error;
                console.log(error);
                 });
    
    
    }
    

}