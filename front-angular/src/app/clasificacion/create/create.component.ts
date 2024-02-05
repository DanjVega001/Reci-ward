import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, FormsModule, ReactiveFormsModule, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { CommonModule } from '@angular/common';
import { ClasificacionService } from '../../servicios/clasificacion.service';
import { Clasificacion } from '../../modelos/clasificacion.model';

@Component({
  selector: 'app-create',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule, FormsModule],
  providers: [ClasificacionService],
  templateUrl: './create.component.html',
  styleUrls: ['./create.component.scss']
})
export class CreateComponent implements OnInit {
  id: string | null = null;
  clave: string | null = null;
  listaClasificaciones: Clasificacion[] = [];

  ClasificacionForm: FormGroup = this.fb.group({
    id: [''],
    nombreClasificacion: ['', Validators.required],
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
    this.agregarClasificacion(); // Cambiando el nombre del método a 'cargarClasificaciones'
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

  agregarClasificacion(): void { // Cambiando el nombre del método a 'cargarClasificaciones'
    this.clasificacionService.getClasificaciones(this.clave).subscribe(
      data => {
        this.listaClasificaciones = data;
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
              nombreClasificacion: data.nombreClasificacion,
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
