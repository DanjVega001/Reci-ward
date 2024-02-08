import { Component } from '@angular/core';
import { FormBuilder, FormsModule, ReactiveFormsModule, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { CommonModule } from '@angular/common';
import { Material } from '../../modelos/material.model';
import { MaterialService } from '../../servicios/material.service';
import { ClasificacionService } from '../../servicios/clasificacion.service';
import { Clasificacion } from '../../modelos/clasificacion.model';

@Component({
  selector: 'app-create',
  standalone: true,
  imports: [ReactiveFormsModule, CommonModule, FormsModule],
  providers: [MaterialService,ClasificacionService],
  templateUrl: './create.component.html',
  styleUrl: './create.component.scss'
})
export class CreateComponent {
  id: string | null = null;
  clave: string | null = null;
  listaFichas: Material[] = [];
  

  materialForm = this.fb.group({
    nombreMaterial: ['', Validators.required], 
    numeroPuntos: ['', Validators.required], 
    clasificacion: ['', Validators.required], 
  });
  
  constructor(private fb: FormBuilder, private aRouter: ActivatedRoute,
    private materialService: MaterialService, private _router: Router,private clasificacionService: ClasificacionService ) {
    this.id = this.aRouter.snapshot.paramMap.get('id');
  }
  listarClasificacion:Clasificacion[]=[]
  cargarClasificacion (): void {
    this.clasificacionService.getClasificaciones(this.clave).subscribe(
      data => {
        this.listarClasificacion = data;
      },
      err => {
        console.log(err);
      }
    );
  };
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


  verEditar(): void {
    if (this.id) {
      this.materialService.getMaterial(this.id, localStorage.getItem('access_token'))
        .subscribe(data => {
          
          this.materialForm.setValue({
            nombreMaterial: data[0].nombreMaterial,
            numeroPuntos: data[0].numeroPuntos,
            clasificacion: data[0].clasificacion,
          });
          

        }, err => { console.log(err) });
    } else {
      console.log("id nulo");
    }
  }
  agregarMaterial(): void {
    const material: Material = {
      nombreMaterial: this.materialForm.get('nombreMaterial')?.value,
      numeroPuntos: Number(this.materialForm.get('numeroPuntos')?.value),
      clasificacion_id: Number(this.materialForm.get('clasificacion')?.value),
    };
    console.log(material);
  
    if (this.id !== null) {
      this.materialService.updateMaterial(material, this.id, this.clave).subscribe(
        data => {
          this._router.navigate(['/material/index']);
        },
        err => {
          console.log(err);
          this._router.navigate(['/material/index']);
        }
      );
    } else {
      this.materialService.addMaterial(material, this.clave).subscribe(
        data => {
          console.log(data);
          this._router.navigate(['/material/index']);
        },
        err => {
          console.log(err);
          this._router.navigate(['/material/index']);
        }
      );

    }
    
}





}

