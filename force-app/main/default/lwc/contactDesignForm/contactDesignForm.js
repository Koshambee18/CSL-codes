import { LightningElement,track } from 'lwc';
import createContact from '@salesforce/apex/ContactInsertLWCController.createContact';
import { NavigationMixin } from 'lightning/navigation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class ContactDesignForm extends NavigationMixin(LightningElement) {  error;
    firstName = '';
    lastName = '';
    phoneNo= '';
    emailId='';
    department='';
    title='';
    birthdate='';
    selectedAccount;
    fields = ["Name","Type","Phone"];
    displayFields = 'Name, Type, Phone';
    @track isModalOpen = false;
    @track showError = false;
    @track accountID =window.location.href.match(/[a-z0-9]\w{4}0\w{12}|[a-z0-9]\w{4}0\w{9}/g)[0];
     contactChangeVal(event) {
        console.log(event.target.label);
        console.log(event.target.value);        
        if(event.target.label=='First Name'){
            this.firstName = event.target.value;
        }
        if(event.target.label=='Last Name'){
            this.lastName = event.target.value;
        }            
        if(event.target.label=='Phone'){
            this.phoneNo = event.target.value;
        }
        if(event.target.label=='Email'){
            this.emailId = event.target.value;
        }
        if(event.target.label=='Department'){
            this.department = event.target.value;
        }
        if(event.target.label=='Title'){
            this.title = event.target.value;
        } 
        if(event.target.label=='Birthdate'){
            this.birthdate = event.target.value;
        }

        
    }
    handleAccountSelection(event){
        this.selectedAccount = event.target.value;
        alert("The selected Accout id is"+this.selectedAccount);
    }
    closeModal() {
        // to close modal set isModalOpen tarck value as false
        this.isModalOpen = false;
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: window.location.href.match(/[a-z0-9]\w{4}0\w{12}|[a-z0-9]\w{4}0\w{9}/g)[0],
                objectApiName: 'Account',
                actionName: 'view'
            },
        });

    }
    submitForm(event){
    
       console.log(window.location.href.match(/[a-z0-9]\w{4}0\w{12}|[a-z0-9]\w{4}0\w{9}/g)[0]);

       if(this.lastName == undefined || this.lastName == '' || this.lastName == null){
           this._showValidationError(event);
       }else{
           this.showError = false;
       }

        createContact({accId:window.location.href.match(/[a-z0-9]\w{4}0\w{12}|[a-z0-9]\w{4}0\w{9}/g)[0],firstName:this.firstName,lastname:this.lastName,email:this.emailId,title:this.title,phone:this.phoneNo,department:this.department,birthdate:this.birthdate})
        .then((result) => {
            this.showToast(event);
         
         // Navigate to View Account Page
    
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: window.location.href.match(/[a-z0-9]\w{4}0\w{12}|[a-z0-9]\w{4}0\w{9}/g)[0],
                objectApiName: 'Account',
                actionName: 'view'
            },
        });
    })
        .catch((error) => {
            this.error = error;
            
            console.log(error);
        });
}

_showValidationError(event){
    this.showError = true;
}

/**handleLookup(event){
    console.log( JSON.stringify ( event.detail) )
}**/
  showToast(event) {
    const evt = new ShowToastEvent({
        title: 'Success',
        message: 'Contact is created',
        variant: 'success',
    });
    
    this.dispatchEvent(evt);
}

}