/*import { Component, OnInit } from '@angular/core';
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

  ClasificacionForm = this.fb.group({
    id: [''],
    nombreClasificacion: [''],
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

  cargarClasificacion(): void { 
    this.clasificacionService.getClasificaciones(this.clave).subscribe(
      data => {
        this.listaClasificaciones = data;
      },err => {console.log(err);
      }
    );
  }

  verEditar(): void {
  if (this.id) {
    this.clasificacionService.getClasificacion(this.id, localStorage.getItem('access_token'))
      .subscribe(data => {
        this.ClasificacionForm.patchValue({
          id: data.id,
          nombreClasificacion: data.nombreClasificacion,
          descripcion: data.descripcion,
        });
      }, err => {
        console.log(err);
      });
  } else {
    console.log("id nulo");
  }
<<<<<<< HEAD
}

agregarClasificacion(): void{
  const clasificacion: Clasificacion = {
    nombreClasificacion: this.ClasificacionForm.get('nombreClasificacion')?.value,
    descripcion: this.ClasificacionForm.get('descripcion')?.value,
    admin_id: Number(localStorage.getItem('user_id')),
  };
  console.log(clasificacion);

  if (this.id !== null) {
    this.clasificacionService.updateClasificacion(clasificacion, this.id, this.clave).subscribe(
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
}
=======
}*/
>>>>>>> 0946b573a5de5db8ebf17eb367e7d4cfc735b613
