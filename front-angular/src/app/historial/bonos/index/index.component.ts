import { Component } from '@angular/core';
import { FormBuilder, FormsModule, ReactiveFormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { Router } from '@angular/router';
import { AdminService } from '../../../servicios/admin.service';
import { Aprendiz_Bono } from '../../../modelos/aprendiz_bono.model';

@Component({
  selector: 'app-index',
  standalone: true,
  imports: [CommonModule, FormsModule, ReactiveFormsModule],
  providers: [AdminService],
  templateUrl: './index.component.html',
  styleUrl: './index.component.scss'
})
export class IndexComponent {
  error = false;
  infoErro = '';
  bonosAprendiz : Aprendiz_Bono[] = [];
  bonosMostrados : boolean = false;
  clave: string | null = null;
  dataAprendiz = {
    nombreAprendiz : '',
    apellidoAprendiz : '',
    documento : 0,
    codigoFicha : 0
  };

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

  cargarBonos():void{
    this.bonosMostrados = false;
    this.adminService.getBonos(this.busqueda.get('documento')?.value, this.clave)
    .subscribe(
      data => {
        this.dataAprendiz.apellidoAprendiz = data.apellidoAprendiz;
        this.dataAprendiz.documento = data.documento;
        this.dataAprendiz.nombreAprendiz = data.nombreAprendiz;
        this.dataAprendiz.codigoFicha = data.codigoFicha;
        this.bonosAprendiz = data.bonos;
        this.bonosMostrados = true;
        this.error = false;
      }, err => {         
        this.infoErro = err.error.message;
        this.error = true;
        console.log(err);
        
      }
    )
  }


}
