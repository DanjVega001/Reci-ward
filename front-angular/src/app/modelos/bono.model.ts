export class Bono {
    id?:number;
    valorBono:number | null | undefined;
    fechaCreacion:Date | null | undefined;
    fechaFin:Date | null | undefined;

    constructor(id?:number, valorBono?:number, fechaCreacion?:Date, fechaFin?:Date, ){
        this.id = id,
        this.valorBono = valorBono,
        this.fechaCreacion = fechaCreacion,
        this.fechaFin = fechaFin
    }
}