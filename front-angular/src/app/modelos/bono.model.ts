export class Bono {
    id?:number;
    valorBono?:number | null | undefined;
    puntosRequeridos?:number | null | undefined;

    constructor(id?:number, valorBono?:number, pubtosRequeridos?:number ){
        this.id = id;
        this.valorBono = valorBono;
        this.puntosRequeridos = pubtosRequeridos;
    }
}