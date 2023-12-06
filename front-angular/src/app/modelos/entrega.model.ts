export class Entrega {
    id?:number
    cantidadMaterial?:number 
    canjeada?:boolean
    puntosAcumulados?:number

    constructor(id?:number, cantidadMaterial?:number, canjeada?:boolean, puntosAcumulados?:number){
        this.canjeada=canjeada;
        this.id=id;
        this.cantidadMaterial=cantidadMaterial;
        this.puntosAcumulados=puntosAcumulados;
    }
}