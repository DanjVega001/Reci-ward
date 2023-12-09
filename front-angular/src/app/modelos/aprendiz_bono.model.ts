export class Aprendiz_Bono {
    id?:number;
    estadoBono?:boolean;
    fechaCreacion: Date | undefined | null;
    fechaVencimiento: Date | undefined | null;
    codigoValidante: string | undefined | null;
    valorBono?:number

    constructor(id?: number, valorBono?: number, codigoValidante?: string,
        fechaCreacion?:Date, fechaVencimiento?:Date, estadoBono?:boolean){
        this.id=id;
        this.valorBono=valorBono;
        this.codigoValidante=codigoValidante;
        this.fechaVencimiento=fechaVencimiento;
        this.fechaCreacion=fechaCreacion;
        this.estadoBono=estadoBono;
    }
}