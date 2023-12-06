export class Admin {
    id?:number;
    nombreAdmin:string | null | undefined;
    correoAdmin:string | null | undefined;
    contrasenaAdmin:string | null | undefined;


    constructor(id?:number, nombreAdmin?:string, correoAdmin?:string, contrasenaAdmin?:string){
        this.id = id;
        this.nombreAdmin = nombreAdmin;
        this.correoAdmin = correoAdmin;
        this.contrasenaAdmin = contrasenaAdmin;
    }
}
