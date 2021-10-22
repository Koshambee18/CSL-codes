import { LightningElement,track,api} from 'lwc';
import uploadContentDoc from '@salesforce/apex/FileUploadOneDrive.uploadContentDoc';
import saveData from '@salesforce/apex/FileUploadOneDrive.saveData';

import {
    ShowToastEvent
} from 'lightning/platformShowToastEvent';


const columns = [{
        label: 'Name',
        fieldName: 'NameWC'
    },
    {
        label: 'WebURL',
        fieldName: 'webUrlWC',
        type: 'url'

    },
    {
        label: 'Size',
        fieldName: 'sizeWC'
    },
    {
        label: 'CreatedDateTime',
        fieldName: 'createdDateTimeWC'
    }
];

export default class OneDriveAPIIntegration extends LightningElement {

  @track isLogout = false;
  @track isLoading = false;
  @track fileNames = '';
  @track filesUploaded = [];
  @track allFiles;
  @track data;
  columns = columns;

  


handlConnectClick(){
this.isLogout = false;

let data = {
  scope: "files.readwrite.all offline_access",
  client_secret:"Dss7Q~mUCLSzB241rLFrecRW73a6aG-JezdAn",
  client_id: "54986d57-f766-47c1-bef0-8efe4b3c9fb4",
  grant_type:"client_credentials",
  redirect_uri:"https://cloudsciencelab4-dev-ed.lightning.force.com/lightning/n/afterLoginPopup"
  }
var url = 'https://login.live.com/oauth20_authorize.srf?client_id='+data.client_id+'&scope='+data.scope+'&redirect_uri='+data.redirect_uri+'&response_type=token';
let newWindow = window.open(url,"OneDrive Connector", 'width=500,height=400,toolbar=0,location=0, directories=0, status=0,location=no,menubar=0');

}
handlelogoutClick(){
  this.isLogout = true;
  let data = {
  scope: "files.readwrite.all offline_access",
  client_secret:"Dss7Q~mUCLSzB241rLFrecRW73a6aG-JezdAn",
  client_id: "54986d57-f766-47c1-bef0-8efe4b3c9fb4",
  grant_type:"client_credentials",
  redirect_uri:"https://cloudsciencelab4-dev-ed.lightning.force.com/lightning/n/LogoutPopup"
  }
var logoouturl = 'https://login.microsoftonline.com/common/oauth2/v2.0/logout?post_logout_redirect_uri='+data.redirect_uri;
let newWindow = window.open(logoouturl,"OneDrive Connector",'width=500,height=400,toolbar=0,location=0, directories=0, status=0,location=no,menubar=0');

}



    handleUploadFinished(event) {
      let files = event.target.files;
      console.log('files '+files);

        if (files.length > 0) {
            let filesName = '';

            for (let i = 0; i < files.length; i++) {
                let file = files[i];

                filesName = filesName + file.name + ',';
                console.log(' filesName '+ filesName);
               // this.allFiles.push(filesName);

                let freader = new FileReader();
                freader.onload = f => {
                    let base64 = 'base64,';
                    let content = freader.result.indexOf(base64) + base64.length;
                    let fileContents = freader.result.substring(content);
                    this.filesUploaded.push({
                        Title: file.name,
                        VersionData: fileContents
                    });
                };
                freader.readAsDataURL(file);
            }

            this.allFiles = filesName;
            //console.log(this.allFiles);
            this.fileNames = filesName.slice(0, -1);
            console.log(' this.filesUploaded '+ this.filesUploaded);
        }
        
    }

    handleUploadClick(event){

        this.isLoading = true;
        const uploadedFiles = event.detail.files;
        console.log(' this.filesUploaded again'+ this.filesUploaded);
        console.log(uploadedFiles);
          uploadContentDoc({
                filesToInsert: this.filesUploaded
            })
            
            .then((result) => {
              this.isLoading = false;
              if(this.isLogout == false){
                const event = new ShowToastEvent({
                        title: 'Uploaded',
                        message: 'File is uploaded',
                        variant: 'Success'
                    });
                    this.dispatchEvent(event);
                    
              this.showUploadedData();
              }
              else{
                
                const event = new ShowToastEvent({
                        title: 'Logged Out',
                        message: 'Please log in again to upload a files!',
                        variant: 'error'
                    });
                    this.dispatchEvent(event);

            
              }
              
            })
            .catch((error) => {
              console.log(error);
            });

  }


  showUploadedData(){
     this.isLoading = false;
      saveData()
      .then((result) => {
        console.log(result);
        this.allFiles =  result;
        //alert('data');
      })
      .catch((error) => {
             console.log(error);
      });



  }
  

}