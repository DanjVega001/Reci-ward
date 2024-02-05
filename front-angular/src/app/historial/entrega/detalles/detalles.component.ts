import { Component } from '@angular/core';
import { Entrega } from '../../../modelos/entrega.model';
import { AdminService } from '../../../servicios/admin.service';
import { ActivatedRoute, Router } from '@angular/router';
import { Material } from '../../../modelos/material.model';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-detalles',
  standalone: true,
  imports: [CommonModule],
  providers: [AdminService],
  templateUrl: './detalles.component.html',
  styleUrl: './detalles.component.scss'
})
export class DetallesComponent {

  clave: string | null = null;

  // USAR EL MODELO MATERIALES CUANDO ESTE CREADO
  listaMateriales:Material[]=[];

  datosAprendiz = {
    idAprendiz : 0,
    documentoAprendiz: 0,
    nombre: '',
    apellido: ''
  };
  datosEntrega : Entrega = {
    canjeada: false,
    id: 0,
    cantidadMaterial: 0,
    puntosAcumulados: 0
  }
  id:string | null = null;

  constructor(private adminService: AdminService, private _router:Router,
    private aRouter: ActivatedRoute){
      this.id=this.aRouter.snapshot.paramMap.get('id');
  }

  ngOnInit() {
    this.validarToken();
    this.cargarMateriales();
  }

  validarToken():void{
    if (this.clave==null) {
      this.clave = localStorage.getItem('access_token');
    } 
    if (!this.clave) {      
      this._router.navigate(['/inicio/body']);
    } 
    if (!this.id) {
      this._router.navigate(['/historial/entrega/index']);
    }
  }

  cargarMateriales():void{
    
    this.adminService.getDetallesEntrega(this.id, this.clave).subscribe(
      data => {
        this.datosAprendiz = data.aprendiz;
        this.datosEntrega = data.entrega;
        this.listaMateriales = data.materiales;
      }, 
      err => { 
        console.log(err);
        this._router.navigate(['/historial/entrega/index']);
      }
    )
  }
}
