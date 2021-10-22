import { LightningElement,track } from 'lwc';
import getGifs from '@salesforce/apex/GiphyAPIIntegration.getGifs';

export default class GiphyIntegration extends LightningElement {
@track available = false;
@track isLoading =false;
EName;
GifsDetails;
ChangeHandler(event){
const inputbox = event.target.value;
if(inputbox === 'EName' ){
    this.EName = event.target.value
}
}

handleClick(){
const toFindEntity = this.EName;
getGifs({toFind:toFindEntity})
.then((result)=>{
      this.isLoading = false;
      console.log(JSON.parse(JSON.stringify(result)));
      this.GifsDetails = JSON.parse(JSON.stringify(result))
      this.size = this.GifsDetails.length;
      console.log(this.size);

      if (this.size > 0) {
                    this.available = true;
                }
      })
      .catch((error) => {
                this.error = error;
                console.log('error '+error);
                 });

}
}