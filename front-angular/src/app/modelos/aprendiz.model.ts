export class Aprendiz {
    id?:number;
    tipoDocumento:string | null | undefined;
    numeroDocumento?:number;
    contrasena:string | null | undefined;
    correo:string | null | undefined;
    user_id?: number;
    ficha_id?: number;

    constructor(id?:number, tipoDocumento?:string, contrasena?:string, correo?:string, ficha_id?:number, user_id?: number){
        this.id = id;
        this.tipoDocumento = tipoDocumento;
        this.contrasena = contrasena;
        this.correo = correo;
        this.ficha_id = ficha_id;
        this.user_id = user_id;
    }

}
