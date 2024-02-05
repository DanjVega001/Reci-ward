export class Clasificacion {
    id?:number;
    nombreClasificacion?:string| null | undefined;

    constructor(id?:number, nombreClasificacion?:string){
        this.id = id;
        this.nombreClasificacion=nombreClasificacion;
    }
}
