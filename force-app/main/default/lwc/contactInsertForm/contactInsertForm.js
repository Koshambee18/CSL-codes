import { LightningElement } from 'lwc';
import createContact from '@salesforce/apex/ContactInsertLWCController.createContact';
import { NavigationMixin } from 'lightning/navigation';
export default class ContactInsertForm extends NavigationMixin(LightningElement){

    error;
    firstName = '';
    lastName = '';
    phoneNo= '';
    emailId='';
    department='';
    title='';
    birthdate='';


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

    submitForm(event){
        
       console.log(window.location.href.match(/[a-z0-9]\w{4}0\w{12}|[a-z0-9]\w{4}0\w{9}/g)[0]);

        createContact({accId:window.location.href.match(/[a-z0-9]\w{4}0\w{12}|[a-z0-9]\w{4}0\w{9}/g)[0],firstName:this.firstName,lastname:this.lastName,email:this.emailId,title:this.title,phone:this.phoneNo,department:this.department,birthdate:this.birthdate})
        .then((result) => {
         alert('Data is saved successfully');
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
    }