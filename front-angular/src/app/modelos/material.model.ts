export class Material {
    id?: number;
    nombreMaterial: string | undefined | null;
    numeroPuntos?: number;
   

    constructor(id?: number, nombreMaterial?: string, numeroPuntos?: number
        ) {
        this.id = id;
        this.nombreMaterial = nombreMaterial;
        this.numeroPuntos = numeroPuntos;
    }
}