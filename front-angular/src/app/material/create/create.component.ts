import { Component } from '@angular/core';
import { FormBuilder, FormsModule, ReactiveFormsModule, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { CommonModule } from '@angular/common';
import { Material } from '../../modelos/material.model';
import { MaterialService } from '../../servicios/material.service';


@Component({
  selector: 'app-create',
  standalone: true,
  imports: [ReactiveFormsModule, CommonModule, FormsModule],
  providers: [MaterialService],
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

  });

  constructor(private fb: FormBuilder, private aRouter: ActivatedRoute,
    private materialService: MaterialService, private _router: Router,) {
    this.id = this.aRouter.snapshot.paramMap.get('id');
  }

  ngOnInit():void {
    this.validarToken();
    this.verEditar();
  }

  validarToken(): void {
    console.log(localStorage.getItem('access_token'));
    
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

    };
    console.log(material);
    console.log(this.id);
    

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
      console.log(this.clave);
      
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

