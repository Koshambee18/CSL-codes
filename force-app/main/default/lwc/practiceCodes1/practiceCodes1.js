import {LightningElement,wire,track} from 'lwc';
import getContactList from '@salesforce/apex/LwcController.getContactList';
export default class DisplayContactWhenButtonClick extends LightningElement {
    @track contacts;
    @track errorMsg;

    handleGetContacts(){
        getContactList()
        .then(result =>{
            this.contacts = result;
        })
        .catch(error =>{
            this.errorMsg = error;
        })
    }
}