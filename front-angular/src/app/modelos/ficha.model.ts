export class Ficha{
  id?: number
  nombreFicha: string | undefined | null;
  fechaCreacion: Date | undefined | null;
  fechaFin: Date | undefined | null;
  codigoFicha?: number;
  admin_id?: number

  constructor(id?: number, nombreFicha?: string, fechaCreacion?: Date, fechaFin?: Date,
    codigoFicha?: number, admin_id?: number){}
}