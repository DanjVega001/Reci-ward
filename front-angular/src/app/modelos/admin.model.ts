export class Admin {
    id?:number;
    nombreAdmin:string | null | undefined;
    correoAdmin:string | null | undefined;
    contrasenaAdmin:string | null | undefined;
    user_id?: number;

    constructor(id?:number, nombreAdmin?:string, correoAdmin?:string, contrasenaAdmin?:string)
}
