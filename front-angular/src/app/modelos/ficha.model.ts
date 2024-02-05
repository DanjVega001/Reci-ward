export class Ficha{
  id?: number
  nombreFicha: string | undefined | null;
  fechaCreacion: any | undefined | null;
  fechaFin: any | undefined | null;
  codigoFicha?: number;
  admin_id?: number

  constructor(id?: number, nombreFicha?: string, fechaCreacion?: Date, fechaFin?: Date,
    codigoFicha?: number, admin_id?: number){
      this.id=id,
      this.nombreFicha=nombreFicha,
      this.fechaCreacion=fechaCreacion,
      this.fechaFin=fechaFin,
      this.codigoFicha=codigoFicha,
      this.admin_id=admin_id
    }
}