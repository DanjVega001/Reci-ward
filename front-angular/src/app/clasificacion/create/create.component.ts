import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { CommonModule } from '@angular/common';
import { ClasificacionService } from '../../servicios/clasificacion.service'; // Asumiendo que tienes un servicio llamado 'clasificacion.service'
import { Clasificacion } from '../../modelos/clasificacion.model'; // Asumiendo que tienes un modelo llamado 'clasificacion.model'

@Component({
  selector: 'app-create',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule, FormsModule],
  providers: [ClasificacionService], // Cambiando el proveedor a ClasificacionService
  templateUrl: './create.component.html',
  styleUrls: ['./create.component.scss'] // Corrigiendo el nombre del atributo 'styleUrls'
})
export class CreateComponent implements OnInit {
  id: string | null = null;
  clave: string | null = null;
  listaClasificaciones: Clasificacion[] = []; // Cambiando el nombre de 'listaTips' a 'listaClasificaciones'

  ClasificacionForm: FormGroup = this.fb.group({
    id: [''],
    nombre_clasificacion: ['', Validators.required], // Agregando validador requerido
    descripcion: [''],
  });

  constructor(
    private fb: FormBuilder,
    private aRouter: ActivatedRoute,
    private clasificacionService: ClasificacionService,
    private _router: Router
  ) {
    this.id = this.aRouter.snapshot.paramMap.get('id');
  }

  ngOnInit(): void {
    this.validarToken();
    this.cargarClasificaciones(); // Cambiando el nombre del método a 'cargarClasificaciones'
    this.verEditar();
  }

  validarToken(): void {
    if (this.clave == null) {
      this.clave = localStorage.getItem('access_token');
    }
    if (!this.clave) {
      this._router.navigate(['/inicio/body']);
    }
  }

  cargarClasificaciones(): void { // Cambiando el nombre del método a 'cargarClasificaciones'
    this.clasificacionService.getClasificaciones(this.clave).subscribe(
      data => {
        this.listaClasificaciones = data; // Cambiando la asignación de datos a 'listaClasificaciones'
      },
      err => {
        console.log(err);
      }
    );
  }

  verEditar(): void {
    if (this.id) {
      this.clasificacionService.getClasificacion(this.id, localStorage.getItem('access_token'))
        .subscribe(
          data => {
            this.ClasificacionForm.setValue({
              id: data.id,
              nombre_clasificacion: data.nombre_clasificacion,
              descripcion: data.descripcion,
            });
          },
          err => {
            console.log(err);
          }
        );
    } else {
      console.log("id nulo");
    }
  }
}
