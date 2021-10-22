import { LightningElement,track} from 'lwc';
import digitalClock from '@salesforce/resourceUrl/digitalClock';
import { loadStyle, loadScript } from 'lightning/platformResourceLoader';
export default class Digiclock extends LightningElement {


@track abhiKaTime;

renderedCallback() {
  loadStyle(this, digitalClock); 
  var date = new Date(); /* creating object of Date class */
  var hour = date.getHours();
  var min = date.getMinutes();
  var sec = date.getSeconds();
  if (hour < 10) {
    hour= "0" + hour;
  }
 if (min < 10) {
    min= "0" + min;
  }
  if (sec < 10) {
    sec= "0" + sec;
  }
  this.abhiKaTime = hour + " : " + min + " : " + sec;
//  hour = updateTime(hour);
  //min = updateTime(min);
  //sec = updateTime(sec); 
  //  this.template.querySelector('.clock').appendChild('10:33');
  //document.getElementsByClassName('clock').innerText = hour + " : " + min + " : " + sec; /* adding time to the div */
    var t = setTimeout(function(){
       var date = new Date(); /* creating object of Date class */
  var hour = date.getHours();
  var min = date.getMinutes();
  var sec = date.getSeconds();
  if (hour < 10) {
    hour= "0" + hour;
  }
 if (min < 10) {
    min= "0" + min;
  }
  if (sec < 10) {
    sec= "0" + sec;
  }

//  hour = updateTime(hour);
  //min = updateTime(min);
  //sec = updateTime(sec);
   // var t = setTimeout(function(){ this.currentTime();}, 1000);

this.abhiKaTime = hour + " : " + min + " : " + sec;
    },1000); /* setting timer */

}


}