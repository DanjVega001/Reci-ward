// Cambiando de 'nombre_clasificacion' a 'nombreClasificacio'
export class Clasificacion {
    id?: number;
    nombreClasificacion: string | undefined | null;
    descripcion: string | undefined | null;
    admin_id?: number;
  
    constructor(id?: number, nombreClasificacion?: string, descripcion?: string, admin_id?: number) {
      this.id = id;
      this.nombreClasificacion = nombreClasificacion;
      this.descripcion = descripcion;
      this.admin_id = admin_id;
    }
  }
  
  