import { Component } from '@angular/core';
import { FormBuilder, FormsModule, ReactiveFormsModule } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { CommonModule } from '@angular/common';
import { UsuarioService } from '../../servicios/usuario.service';
import { Cafeteria } from '../../modelos/cafeteria.model';


@Component({
  selector: 'app-create-cafeteria',
  standalone: true,
  imports: [ReactiveFormsModule, CommonModule, FormsModule],
  providers:[UsuarioService],
  templateUrl: './create-cafeteria.component.html',
  styleUrl: './create-cafeteria.component.scss'
})
export class CreateCafeteriaComponent {

  id: string | null = null;
  clave: string | null = null;
  listaCafeteria: Cafeteria[] = [];

  cafeteriaForm = this.fb.group({
    id: [''],
    nombreCafeteria: [''], 
    correoCafeteria: [''], 
    contrasenaCafeteria: [''],
    contrasenaAntigua: [''],
    isChecked : false,
    contrasenaCafeteria2: [''],
  });

  msjError:string|null|undefined = null;
  
  

  constructor(private fb: FormBuilder, private aRouter: ActivatedRoute, private usuarioService: UsuarioService,
    private _router: Router) {
    this.id = this.aRouter.snapshot.paramMap.get('id');
  }
  ngOnInit(): void {
    this.validarToken();
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
      this.usuarioService.getCafeteria(this.clave, this.id).subscribe(
        data => {
          this.cafeteriaForm.setValue({
            nombreCafeteria: data.nombreCafeteria,
            contrasenaCafeteria: '',
            correoCafeteria: data.correoCafeteria,
            id: "",
            contrasenaAntigua : '',
            isChecked : false,
            contrasenaCafeteria2:'',
          });
        }
      )
    } else {
      console.log("id nulo");
    }
  }

  agregarAdmin(): void {

    this.msjError = null;
    var cafeteria: Cafeteria = {
      nombreCafeteria: this.cafeteriaForm.get('nombreCafeteria')?.value,
      correoCafeteria: this.cafeteriaForm.get('correoCafeteria')?.value,
    };
    


    if (this.id !== null) {
      console.log(cafeteria);
      cafeteria.contrasenaCafeteria = this.cafeteriaForm.get('contrasenaCafeteria')?.value;
      cafeteria.contrasenaAntigua = this.cafeteriaForm.get('contrasenaAntigua')?.value
      this.usuarioService.updateCafeteria(this.clave, this.id, cafeteria).subscribe(
        data => {
          console.log(data);
          
          this._router.navigate(['/usuario/index']);
        },
        err => {
          console.log(err);
          
          this.msjError = err.error.error;
        }
      );
    } else {
      console.log(cafeteria);
      cafeteria.contrasenaCafeteria = this.cafeteriaForm.get('contrasenaCafeteria2')?.value;

      this.usuarioService.addCafeteria(this.clave, cafeteria).subscribe(
        data => {
          console.log(data);
          this._router.navigate(['/usuario/index']);
        },
        err => {
          console.log(err);
          this._router.navigate(['/usuario/index']);
        }
      );
    }
  }

}
