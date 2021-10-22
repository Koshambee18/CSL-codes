import { LightningElement,wire,track} from 'lwc';
import getAccessToken from '@salesforce/apex/openPopupController.getAccessToken';
export default class OpenPopupOnSuccessfulLogin extends LightningElement {
    
connectedCallback() {
   var url = window.location.href;
        var token = new URL(url).hash.split('&').filter(function(el) { if(el.match('access_token') !== null) return true; })[0].split('=')[1];
        var decodedToken = decodeURIComponent(token);
   
        getAccessToken({
           
                tokenLst: decodedToken
            })
             .then((result) => {
                 
             })
               .catch((error) => {
                  console.log(error);
                  
               });

  var delayInMilliseconds = 2000; //2 second

setTimeout(function() {
 window.close();
}, delayInMilliseconds);



}




}