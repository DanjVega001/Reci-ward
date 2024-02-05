export class Material {
    id?: number;
    nombreMaterial: string | undefined | null;
    numeroPuntos?: number;
    clasificacion?: string | undefined | null;
    clasificacion_id?: number

    constructor(id?: number, nombreMaterial?: string, numeroPuntos?: number,
        clasificacion?: string, clasificacion_id?: number) {
        this.id = id;
        this.nombreMaterial = nombreMaterial;
        this.numeroPuntos = numeroPuntos;
        this.clasificacion = clasificacion;
        this.clasificacion_id = clasificacion_id;
    }
}