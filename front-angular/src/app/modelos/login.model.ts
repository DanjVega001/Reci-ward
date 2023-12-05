export class Login {
    user : User;
    access_token : string
    
    constructor(user :User, access_token : string){
        this.user = user;
        this.access_token = access_token;
    }
}
