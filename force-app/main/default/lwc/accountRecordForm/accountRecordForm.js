import { LightningElement, wire,api} from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import OWNER_NAME_FIELD from '@salesforce/schema/Account.Owner.Name';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
import TYPE_FIELD from '@salesforce/schema/Account.Type';
import SITE_FIELD from '@salesforce/schema/Account.Site';
import ACCOUNTSOURCE_FIELD from '@salesforce/schema/Account.AccountSource';
import WEBSITE_FIELD from '@salesforce/schema/Account.Website';
import FAX_FIELD from '@salesforce/schema/Account.Fax';
import RATING_FIELD from '@salesforce/schema/Account.Rating';

const FIELDS = [
    NAME_FIELD,
    OWNER_NAME_FIELD,
    PHONE_FIELD,
    INDUSTRY_FIELD,TYPE_FIELD,SITE_FIELD,ACCOUNTSOURCE_FIELD,WEBSITE_FIELD,FAX_FIELD,RATING_FIELD
];
export default class AccountRecordForm extends LightningElement {
    @api recordId;
    @api objectApiName; 
    @wire(getRecord, { recordId: '$recordId', fields: FIELDS })
    account;

    get name() {
        return this.account.data.fields.Name.value;
    }

    get owner() {
        return this.account.data.fields.Owner.Name.value;
    }

    get phone() {
        return this.account.data.fields.Phone.value;
    }

    get industry() {
        return this.account.data.fields.Industry.value;
    }

    get type() {
        return this.account.data.fields.Type.value;
    }

    get site() {
        return this.account.data.fields.Site.value;
    }

    get accountSource() {
        return this.account.data.fields.AccountSource.value;
    }

    get website() {
        return this.account.data.fields.Website.value;
    }

    get fax() {
        return this.account.data.fields.Fax.value;
    }

    get rating() {
        return this.account.data.fields.Rating.value;
    }

    
}