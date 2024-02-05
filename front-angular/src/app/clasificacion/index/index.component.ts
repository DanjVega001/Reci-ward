import { Component } from '@angular/core';
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
  styleUrl: './index.component.scss'
})
export class IndexComponent {

  listaClasificacion: Clasificacion[] = [];
  clave: string | null = null;

  constructor(private _router: Router, private ClasificacionService: ClasificacionService) { }

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
    this.ClasificacionService.getClasificaciones(this.clave).subscribe(
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
    this.ClasificacionService.deleteClasificacion(id, this.clave).subscribe(
      (      data: any) => {
        this.cargarClasificacion();
      },
      (      err: any) => {
        console.log(err);
      }
    );
  }

}

