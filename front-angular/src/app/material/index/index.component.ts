import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { CommonModule } from '@angular/common';
import { Material } from '../../modelos/material.model';
import { MaterialService } from '../../servicios/material.service';
import { Clasificacion } from '../../modelos/clasificacion.model';
import { ClasificacionService } from '../../servicios/clasificacion.service';
@Component({
  selector: 'app-index',
  standalone: true,
  imports: [CommonModule],
  providers: [MaterialService,ClasificacionService],
  templateUrl: './index.component.html',
  styleUrl: './index.component.scss'
})
export class IndexComponent {
  listaMaterial : Material[] = [];
  listaClasificacion : Clasificacion[] = [];
  clave: string | null = null;
  noEliminar : boolean = false;


  constructor(private _router: Router, private MaterialService: MaterialService, private clasificacionService:ClasificacionService){}
  ngOnInit(): void {
    this.validarToken();
    this.cargarMateriales();
  }
  
  validarToken(): void {
    if (this.clave == null) {
      this.clave = localStorage.getItem('access_token');
    }
    if (!this.clave) {
      this._router.navigate(['/inicio/body']);
    }
  }
  
  cargarMateriales(): void {
    this.MaterialService.getMateriales(this.clave).subscribe(

      data => {
        console.log(data);
        this.listaMaterial = data;
      },
      err => {
        console.log(err);
      }
    );
  }
  
  editarMaterial(id: any): void {
    this._router.navigateByUrl('/material/edit/' + id);
  }
  
  eliminarMaterial(id: any): void {
    this.MaterialService.deleteMaterial(id, this.clave).subscribe(
      data => {
        this.noEliminar = false;
        this.cargarMateriales();
      },
      err => {
        if (err.status == 400) {
          this.noEliminar = true;
        }

        console.log(err);
      }
    );
  }
  
}
