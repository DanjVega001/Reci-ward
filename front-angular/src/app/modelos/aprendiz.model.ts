export class Aprendiz {
    id?:number;
    tipoDocumento:string | null | undefined;
    nombre:string | null | undefined;
    apellido:string | null | undefined;
    numeroDocumento?:number;
    contrasena:string | null | undefined;
    correo:string | null | undefined;
    user_id?: number;
    ficha_id?: number;
    numeroFicha?: number;

    constructor(id?:number, tipoDocumento?:string, contrasena?:string, correo?:string, 
        numeroFicha?:number, user_id?: number, nombre?: string, apellido?: string, ficha_id?:number){
        this.id = id;
        this.tipoDocumento = tipoDocumento;
        this.contrasena = contrasena;
        this.correo = correo;
        this.numeroFicha = numeroFicha;
        this.user_id = user_id;
        this.nombre = nombre;
        this.apellido = apellido;
        this.ficha_id = ficha_id
    }

}
