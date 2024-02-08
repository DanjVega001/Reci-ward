/*import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router } from '@angular/router';
import { Clasificacion } from '../../modelos/clasificacion.model'; 
import { ClasificacionService } from '../../servicios/clasificacion.service'; 

@Component({
  selector: 'app-index',
  standalone: true,
  imports: [CommonModule],
  providers: [ClasificacionService], 
  templateUrl: './index.component.html',
  styleUrls: ['./index.component.scss'] 
})
export class IndexComponent implements OnInit {

  listaClasificacion: Clasificacion[] = []; 
  clave: string | null = null;

  constructor(private _router: Router, private clasificacionService: ClasificacionService) { }

  ngOnInit(): void {
    this.validarToken();
    this.cargarClasificacion(); 
  }

  validarToken(): void {
    if (this.clave == null) {
      this.clave = localStorage.getItem('access_token');
    }
    if (!this.clave) {
      this._router.navigate(['/inicio/body']);
    }
  }

  cargarClasificacion(): void {
    this.clasificacionService.getClasificaciones(this.clave).subscribe(
      data => {
        console.log(data);
        this.listaClasificacion = data; 
      },
      err => {
        console.log(err);
      }
    );
  }

  editarClasificacion(id: any): void { 
    this._router.navigateByUrl('/clasificacion/edit/' + id); 
  }

  eliminarClasificacion(id: any): void { 
    this.clasificacionService.deleteClasificacion(id, this.clave).subscribe(
      data => {
        this.cargarClasificacion(); 
      },
      err => {
        console.log(err);
      }
    );
  }

}*/
