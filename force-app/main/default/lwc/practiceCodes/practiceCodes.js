import { LightningElement,track } from 'lwc';

export default class PracticeCodes extends LightningElement {
    
    @track Firstnum = 0;
    @track secondnum = 0;
    @track ShowResult = 0;
    handleInput1(event){
        this.Firstnum = event.target.value;
        }
    handleInput2(event){
        this.secondnum = event.target.value;
    }
    handleClickadd(event){
            this.ShowResult = parseInt(this.Firstnum) + parseInt(this.secondnum);
            console.log(this.ShowResult);
        }
        handleClicksub(event){
            
                this.ShowResult = parseInt(this.Firstnum) - parseInt(this.secondnum);
                console.log(this.ShowResult);
        }
        handleClickmultiply(event){
            this.ShowResult = parseInt(this.Firstnum) * parseInt(this.secondnum);
            console.log(this.ShowResult);
        }
        
        handleClickdivide(event){
            this.ShowResult = parseInt(this.Firstnum) / parseInt(this.secondnum);
            console.log(this.ShowResult);
        }

    }