import { LightningElement,track } from 'lwc';
import getWeatherReport from '@salesforce/apex/OpenWhetherAPIIntegration.getWeatherReport';
import myResource from '@salesforce/resourceUrl/myResource';

export default class OpenWeatherIntegration extends LightningElement {
//trailheadLogoUrl = myResource;
@track available = false;
@track size = 0;
@track picUrl ;
@track isLoading =false;
@track time;
//@track city = '';
cityName;
weatherDetails


connectedCallback() {

    var today = new Date();
    var time = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
   
    
    if(today.getHours()>=6 && today.getHours()<=7){
        this.picUrl = 'https://wallpapercave.com/wp/wp6023247.jpg';
    }
    else if(today.getHours()>=8 && today.getHours()<=9){
        this.picUrl= 'https://wallpapercave.com/wp/wp8644888.jpg';
    }
     else if(today.getHours()>=10 && today.getHours()<=11 ){
        this.picUrl= 'https://wallpapercave.com/wp/wp7903070.jpg';
    }
     else if(today.getHours()>=11 && today.getHours()<=12){
        this.picUrl= 'https://wallpapercave.com/wp/wp4077312.jpg';
    }
     else if(today.getHours()>=12 && today.getHours()<=14){ 
        this.picUrl= 'https://wallpapercave.com/wp/wp8436142.jpg';
    }
    else if(today.getHours()>=14 && today.getHours()<=16){
        this.picUrl = 'https://wallpapercave.com/wp/wp5287555.jpg';
    }
    else if(today.getHours()>=16 && today.getHours()<=18){
        this.picUrl = 'https://wallpapercave.com/wp/wp5164663.jpg';
    }
    else if(today.getHours()>=18 && today.getHours()<=20){
        this.picUrl = 'https://wallpapercave.com/wp/wp5164656.jpg';
    }
    else{
        this.picUrl= 'https://wallpapercave.com/wp/wp4881911.jpg';
    }
}

ChangeHandler(event){
        const inputBoxName = event.target.name;
        if(inputBoxName === 'cityName'){
            this.cityName = event.target.value;

    }  
}

handleClick(){
    
    const city = this.cityName;
    this.isLoading = true;
getWeatherReport({URL:'https://api.openweathermap.org/data/2.5/weather?q='+city+'&units=metric&appid=aa2b841e21e2aedb2dcd5b130bafaff4'})
 .then((result)=>{
      this.isLoading = false;
      console.log(JSON.parse(JSON.stringify(result)));
      this.weatherDetails = JSON.parse(JSON.stringify(result))

  
      this.size = this.weatherDetails.length;
      
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