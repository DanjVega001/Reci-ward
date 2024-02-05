export class Clasificacion {
    id?:number;
    nombreClasificacion?:string| null | undefined;
nombre_clasificaciones: any;

    constructor(id?:number, nombreClasificacion?:string){
        this.id = id;
        this.nombreClasificacion=nombreClasificacion;
    }
}
