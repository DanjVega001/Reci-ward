/*import { Component } from '@angular/core';
import { FormBuilder, FormsModule, ReactiveFormsModule } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { CommonModule } from '@angular/common';
import { ClasificacionService } from '../../servicios/clasificacion.service';
import { Clasificacion } from '../../modelos/clasificacion.model';

@Component({
  selector: 'app-create',
  standalone: true,
  imports: [ReactiveFormsModule, CommonModule, FormsModule],
  providers: [ClasificacionService],
  templateUrl: './create.component.html',
  styleUrl: './create.component.scss'
})
export class CreateComponent {
  id: string | null = null;
  clave: string | null = null;
  listaClasificacion: Clasificacion[] = [];

  ClasificacionForm = this.fb.group({
    id: [''],
    nombre_clasificaciones: [''],
  });

  constructor(private fb: FormBuilder, private aRouter: ActivatedRoute, private clasificacionService: ClasificacionService,
    private _router: Router) {
    this.id = this.aRouter.snapshot.paramMap.get('id');
  }
  ngOnInit(): void {
    this.validarToken();
    this.cargarClasificacion();
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

  cargarClafisicaciones(): void {
    this.clasificacionService.getClasificaciones(this.clave).subscribe(
      data => {
        this.listaClasificacion = data;
      }, err => { console.log(err); });
  }

  verEditar(): void {
    if (this.id) {
      this.clasificacionService.getClasificaciones(this.id, localStorage.getItem('access_token'))
        .subscribe(data => {
          this.ClasificacionForm.setValue({
            id: data.id,
            nombre_clasificaciones: data.nombre_clasificaciones,
          });

        }, err => { console.log(err) });
    } else {
      console.log("id nulo");
    }
  }

  agregarClasificacion(): void {
    const clasificacion: Clasificacion = {
      nombre_clasificaciones: this.ClasificacionForm.get('nombre_tips')?.value,
      descripcion: this.ClasificacionForm.get('descripcion')?.value,
      admin_id: Number(localStorage.getItem('user_id')),
    };
    console.log(clasificacion);

    if (this.id !== null) {
      this.clasificacionService.updateclasificacion(clasificacion, this.id, this.clave).subscribe(
        data => {
          this._router.navigate(['/clasificacion/index']);
        },
        err => {
          console.log(err);
          this._router.navigate(['/clasificacion/index']);
        }
      );
    } else {
      console.log(clasificacion);

      this.clasificacionService.addClasificacion(clasificacion, this.clave).subscribe(
        data => {
          console.log(data);
          this._router.navigate(['/clasificacion/index']);
        },
        err => {
          console.log(err);
          this._router.navigate(['/clasificacion/index']);
        }
      );
    }
  }

}*/
