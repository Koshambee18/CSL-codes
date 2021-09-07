import { LightningElement, track} from 'lwc';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';
import ACCONT_NUMBER from '@salesforce/schema/Account.AccountNumber';
import ANNUAL_REVENUE from '@salesforce/schema/Account.AnnualRevenue';
import DESCRIPTON from '@salesforce/schema/Account.Description';
import createAccount from '@salesforce/apex/createAcc.createAccount';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class MyPracticeCode extends LightningElement {
    @track name = NAME_FIELD;
    @track industry = INDUSTRY_FIELD;
    @track phone = PHONE_FIELD;
    @track accnumber = ACCONT_NUMBER;
    @track revenue = ANNUAL_REVENUE;
    @track description = DESCRIPTON; 
    rec = {
        Name : this.name,
        Industry : this.industry,
        Phone : this.phone,
        AccountNumber : this.accnumber,
        AnnualRevenue : this.revenue,
        Description : this.description
    }
    handleNameChange(event) {
        this.rec.Name = event.target.value;
        console.log("name1", this.rec.Name);
    }
    handleIndChange(event) {
        this.rec.Industry = event.target.value;
        console.log("Industry", this.rec.Industry);
    }
    handlePhnChange(event) {
        this.rec.Phone = event.target.value;
        console.log("Phone", this.rec.Phone);
    }
    handleAcnoChange(event) {
        this.rec.AccountNumber = event.target.value;
        console.log("accno", this.rec.AccountNumber);
    }
    handleRevChange(event) {
        this.rec.AnnualRevenue = event.target.value;
        console.log("annualrev", this.rec.AnnualRevenue);
    }
    handleDepChange(event) {
        this.rec.Description = event.target.value;
        console.log("description", this.rec.Description);
    }

    handleClick() {
        createAccount({ acc : this.rec })
            .then(result => {
                this.message = result;
                this.error = undefined;
                if(this.message !== undefined) {
                    this.rec.Name = '';
                    this.rec.Industry = '';
                    this.rec.Phone = '';
                    this.rec.AccountNumber = '';
                    this.rec.AnnualRevenue = '';
                    this.rec.Description = '';
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Success',
                            message: 'Account created',
                            variant: 'success',
                        }),
                    );
                }
                console.log(JSON.stringify(result));
                console.log("result", this.message);
            })
            .catch(error => {
                this.message = undefined;
                this.error = error;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error creating record',
                        message: error.body.message,
                        variant: 'error',
                    }),
                );
                console.log("error", JSON.stringify(this.error));
            });
    }
}