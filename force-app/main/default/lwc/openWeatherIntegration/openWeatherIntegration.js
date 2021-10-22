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
    
    
    if(today.getHours()>20 && today.getHours()<23){
        this.picUrl = 'https://wallpapercave.com/wp/wp2077495.jpg';
    }else if(today.getHours()>23 && today.getHours()<5){
        this.picUrl= 'https://biztreat.com/wp-content/uploads/2017/06/Sunrise-7-1024x683.jpg';
    }
    else if(today.getHours()>16 && today.getHours()<20){
        this.picUrl = 'https://wallpapercave.com/wp/wp9123825.jpg';
    }
    else{
        this.picUrl= 'https://wallpapercave.com/wp/wp3057844.jpg';
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