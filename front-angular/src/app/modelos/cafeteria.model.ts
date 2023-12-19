export class Cafeteria {
    id?:number;
    nombreCafeteria?: string | undefined | null;
    correoCafeteria?: string | undefined | null;
    contrasenaCafeteria?: string | undefined | null;
    contrasenaAntigua?: string | undefined | null;

    constructor(nombreCafeteria: string, correoCafeteria: string, 
        contrasenaAntigua: string, contrasenaCafeteria:string ){
        this.nombreCafeteria = nombreCafeteria;
        this.correoCafeteria = correoCafeteria;
        this.contrasenaCafeteria = contrasenaCafeteria;
        this.contrasenaAntigua = contrasenaAntigua;
    }
}