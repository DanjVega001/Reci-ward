import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router } from '@angular/router';
import { Clasificacion } from '../../modelos/clasificacion.model'; // Asumiendo que tienes un modelo llamado 'clasificacion.model'
import { ClasificacionService } from '../../servicios/clasificacion.service'; // Asumiendo que tienes un servicio llamado 'clasificacion.service'

@Component({
  selector: 'app-index',
  standalone: true,
  imports: [CommonModule],
  providers: [ClasificacionService], // Cambiando el proveedor a ClasificacionService
  templateUrl: './index.component.html',
  styleUrls: ['./index.component.scss'] // Corrigiendo el nombre del atributo 'styleUrls'
})
export class IndexComponent implements OnInit {

  listaClasificacion: Clasificacion[] = []; // Cambiando el nombre de 'listaTip' a 'listaClasificacion'
  clave: string | null = null;

  constructor(private _router: Router, private clasificacionService: ClasificacionService) { }

  ngOnInit(): void {
    this.validarToken();
    this.cargarClasificacion(); // Cambiando el nombre del método a 'cargarClasificacion'
  }

  validarToken(): void {
    if (this.clave == null) {
      this.clave = localStorage.getItem('access_token');
    }
    if (!this.clave) {
      this._router.navigate(['/inicio/body']);
    }
  }

  cargarClasificacion(): void { // Cambiando el nombre del método a 'cargarClasificacion'
    this.clasificacionService.getClasificaciones(this.clave).subscribe(
      data => {
        console.log(data);
        this.listaClasificacion = data; // Cambiando la asignación de datos a 'listaClasificacion'
      },
      err => {
        console.log(err);
      }
    );
  }

  editarClasificacion(id: any): void { // Cambiando el nombre del método a 'editarClasificacion'
    this._router.navigateByUrl('/clasificacion/edit/' + id); // Cambiando la ruta a '/clasificacion/edit/'
  }

  eliminarClasificacion(id: any): void { // Cambiando el nombre del método a 'eliminarClasificacion'
    this.clasificacionService.deleteClasificacion(id, this.clave).subscribe(
      data => {
        this.cargarClasificacion(); // Cambiando el nombre del método a 'cargarClasificacion'
      },
      err => {
        console.log(err);
      }
    );
  }

}
