import { Admin } from "./admin.model";

export class Login {
    admin : Admin;
    access_token : string
    
    constructor(admin :Admin, access_token : string){
        this.admin = admin;
        this.access_token = access_token;
    }
}
