export class Tip {
    id?: number
    nombre_tips:  string | undefined | null;
    descripcion: string | undefined | null
    admin_id?: number
 

    constructor(id?: number, nombre_tips?:string, descripcion?:string,
      admin_id?: number){
            this.id = id;
            this.nombre_tips = nombre_tips;
            this.descripcion = descripcion;
            this.admin_id =admin_id;
         }
}
