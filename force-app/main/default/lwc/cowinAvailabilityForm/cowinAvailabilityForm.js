import { LightningElement, track, wire} from 'lwc';
import getDetails from '@salesforce/apex/CowinController.getDetails';
import { NavigationMixin } from 'lightning/navigation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

const columns = [
    { label: 'CenterId', fieldName: 'centerid'},
    { label: 'Name', fieldName: 'Name'},
    { label: 'BlockName', fieldName: 'BlockName'},
    { label: 'District', fieldName: 'District'},
    { label: 'Pincode', fieldName: 'Pincode'},
    { label: 'AvailableCapacityDose2', fieldName: 'AvailableCapacityDose2'},
    { label: 'Fee', fieldName: 'Fee'},
    { label: 'MinAgeLimit', fieldName: 'MinAgeLimit'},
    { label: 'AvailableCapacity', fieldName: 'AvailableCapacity'},
    { label: 'AvailableCapacityDose1', fieldName: 'AvailableCapacityDose1'},
    { label: 'Slots', fieldName: 'Slots'}
    
];


export default class CowinAvailabilityForm extends LightningElement {

    @track cowinData = [];

    pincode ='';
    cowinDate ='';
    columns = columns;

    handlecowin(event){
        if(event.target.label=='Enter Pincode of the city'){
            this.pincode = event.target.value;
        }
        if(event.target.label=='Enter the date of availability'){
            this.cowinDate = event.target.value;
        }  
    
    }

submitForm(event){

        getDetails({pincode:this.pincode,cowinDate:this.cowinDate})
        .then((result) => {
            alert('Success');
            console.log(result);
            console.log(JSON.stringify(result));
            console.log(JSON.parse(JSON.stringify(result)));

            this.cowinData = JSON.parse(JSON.stringify(result));


        })
        .catch((error) => {
            this.error = error;
            console.log(error);
            this.cowinDataArray = undefined;
        });
     }
}