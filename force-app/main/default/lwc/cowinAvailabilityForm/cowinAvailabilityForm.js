import {
    LightningElement,
    track,
    wire
} from 'lwc';
import getDetails from '@salesforce/apex/CowinController.getDetails';
import {
    NavigationMixin
} from 'lightning/navigation';
import {
    ShowToastEvent
} from 'lightning/platformShowToastEvent';

const columns = [{
        label: 'CenterId',
        fieldName: 'centerid'
    },
    {
        label: 'Name',
        fieldName: 'Name'
    },
    {
        label: 'BlockName',
        fieldName: 'BlockName'
    },
    {
        label: 'District',
        fieldName: 'District'
    },
    {
        label: 'Pincode',
        fieldName: 'Pincode'
    },
    {
        label: 'AvailableCapacityDose2',
        fieldName: 'AvailableCapacityDose2'
    },
    {
        label: 'Fee',
        fieldName: 'Fee'
    },
    {
        label: 'MinAgeLimit',
        fieldName: 'MinAgeLimit'
    },
    {
        label: 'AvailableCapacity',
        fieldName: 'AvailableCapacity'
    },
    {
        label: 'AvailableCapacityDose1',
        fieldName: 'AvailableCapacityDose1'
    },
    {
        label: 'Slots',
        fieldName: 'Slots'
    }

];


export default class CowinAvailabilityForm extends LightningElement {

    @track cowinData = [];
    @track cowinDetails = [];
    @track size = 0;
    @track cardTitle = '';
    @track available = false;


    pincode = '';
    cowinDate = '';
    columns = columns;

    handlecowin(event) {
        if (event.target.label == 'Enter Pincode of the city') {
            this.pincode = event.target.value;
        }
        if (event.target.label == 'Enter the date of availability') {
            this.cowinDate = event.target.value;
        }

    }

    //To show data in table
    submitForm(event) {

        getDetails({
                pincode: this.pincode,
                cowinDate: this.cowinDate,
                isInsert: false
            })
            .then((result) => {
                console.log('COWINDATA');
                console.log(JSON.parse(JSON.stringify(result)));
                this.cowinDetails = JSON.parse(JSON.stringify(result))[0].cowinDetailsList;
                this.cowinData = JSON.parse(JSON.stringify(result));
                this.size = this.cowinData.length;
                if (this.size > 0) {
                    this.available = true;
                    this.cardTitle = 'Total Cowin Avilability Today : '+this.size;
                }
            })
            .catch((error) => {
                this.error = error;
                console.log(error);
                this.cowinDataArray = undefined;
                        const event = new ShowToastEvent({
                        title: 'Error',
                        message: 'No Records found for this date!',
                        variant: 'Error'
                    });
                    this.dispatchEvent(event);
            });
    }
    closeModal() {
        window.location.reload();
        //eval("$A.get('e.force:refreshView').fire();");

    }

    //To insert cowin availabilty records
    insertCowinData(event) {
        getDetails({
                pincode: this.pincode,
                cowinDate: this.cowinDate,
                isInsert: true
            })

            .then((result) => {
                if (this.size == 0) {

                    const event = new ShowToastEvent({
                        title: 'Error',
                        message: 'No Records to sync, Please click Search button to get the Data',
                        variant: 'Error'
                    });
                    this.dispatchEvent(event);
                } else {

                    const event = new ShowToastEvent({

                        title: 'Saved',
                        message: 'Records Inserted Successfully',
                        variant: 'success'
                    });
                    this.dispatchEvent(event);
                }


            })

            .catch((error) => {
                this.error = error;
                console.log(error);
            });



    }
}