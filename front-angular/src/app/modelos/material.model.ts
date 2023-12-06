export class Material {
    id?:number;
    nombreMaterial:string | undefined | null;
    numeroPuntos?:number;
    clasificacion:string | undefined | null;

    constructor(id?:number, nombreMaterial?:string, numeroPuntos?:number, 
        clasificacion?:string){
        this.clasificacion=clasificacion;
        this.id=id;
        this.nombreMaterial=nombreMaterial;
        this.numeroPuntos=numeroPuntos;
    }
}