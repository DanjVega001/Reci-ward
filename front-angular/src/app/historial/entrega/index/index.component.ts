import { Component } from '@angular/core';
import { Entrega } from '../../../modelos/entrega.model';
import { Router } from '@angular/router';
import { AdminService } from '../../../servicios/admin.service';
import { FormBuilder, FormsModule, ReactiveFormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-index',
  standalone: true,
  imports:[ReactiveFormsModule, CommonModule, FormsModule],
  providers:[AdminService],
  templateUrl: './index.component.html',
  styleUrl: './index.component.scss'
})
export class IndexComponent {
  listaEntregas:Entrega[] = [];
  clave: string | null = null;
  datosAprendiz = {
    documento: 0,
    nombre: '',
    apellido: ''
  };
  entregasMostradas:boolean | null = false;

  busqueda = this.fb.group({
    documento : ''
  });

  constructor(private adminService:AdminService, private _router:Router, private fb:FormBuilder){}

  ngOnInit() {
    this.validarToken();
  }

  validarToken():void{
    if (this.clave==null) {
      this.clave = localStorage.getItem('access_token');
    } 
    if (!this.clave) {      
      this._router.navigate(['/inicio/body']);
    }
  }

  limpiarPagina():void{
    this.entregasMostradas = false;
  }

  cargarEntregas():void{
    this.limpiarPagina();
    this.adminService.getEntregas(this.busqueda.get('documento')?.value, this.clave)
      .subscribe(
        data => {
          this.datosAprendiz.apellido = data.apellido;
          this.datosAprendiz.documento = data.documento;
          this.datosAprendiz.nombre = data.nombre;
          this.listaEntregas = data.entregas
          this.entregasMostradas = true;
        }, err => { console.log(err); });
  }

  verMas(id:any):void{
    this._router.navigateByUrl('/historial/entrega/detalles/'+id);
  }
}
