import { LightningElement, wire } from "lwc";
import { reduceErrors } from "c/ldsUtils";
import FIRST_NAME_FIELD from "@salesforce/schema/Contact.FirstName";
import LAST_NAME_FIELD from "@salesforce/schema/Contact.LastName";
import EMAIL_FIELD from "@salesforce/schema/Contact.Email";
import getContacts from "@salesforce/apex/ContactController.getContacts";

const COLUMNS = [
  {
    label: "FirstName",
    fieldName: FIRST_NAME_FIELD.fieldApiName,
    type: "text"
  },
  {
    label: "LastName",
    fieldName: LAST_NAME_FIELD.fieldApiName,
    type: "text"
  },
  { label: "Email", fieldName: EMAIL_FIELD.fieldApiName, type: "email" }
];

export default class ContactList extends LightningElement {
  columns = COLUMNS;
  @wire(getContacts)
  contacts;

  get errors() {
    return this.accounts.error ? reduceErrors(this.accounts.error) : [];
  }
}