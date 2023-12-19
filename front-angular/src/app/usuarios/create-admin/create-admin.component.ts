import { Component } from '@angular/core';
import { FormBuilder, FormsModule, ReactiveFormsModule } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { CommonModule } from '@angular/common';
import { UsuarioService } from '../../servicios/usuario.service';
import { Admin } from '../../modelos/admin.model';

@Component({
  selector: 'app-create-admin',
  standalone: true,
  imports: [ReactiveFormsModule, CommonModule, FormsModule],
  providers:[UsuarioService],
  templateUrl: './create-admin.component.html',
  styleUrl: './create-admin.component.scss'
})
export class CreateAdminComponent {

  id: string | null = null;
  clave: string | null = null;
  listaAdmins: Admin[] = [];

  adminForm = this.fb.group({
    id: [''],
    nombreAdmin: [''], 
    correoAdmin: [''], 
    contrasenaAdmin: [''],
    contrasenaAntigua: [''],
    isChecked : false,
    contrasenaAdmin2: [''],
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
      this.usuarioService.getAdmin(this.clave, this.id).subscribe(
        data => {
          this.adminForm.setValue({
            nombreAdmin: data.nombreAdmin,
            contrasenaAdmin: '',
            correoAdmin: data.correoAdmin,
            id: "",
            contrasenaAntigua : '',
            isChecked : false,
            contrasenaAdmin2:'',
          });
        }
      )
    } else {
      console.log("id nulo");
    }
  }

  agregarAdmin(): void {

    this.msjError = null;
    var admin: Admin = {
      nombreAdmin: this.adminForm.get('nombreAdmin')?.value,
      correoAdmin: this.adminForm.get('correoAdmin')?.value,
    };
    


    if (this.id !== null) {
      console.log(admin);
      admin.contrasenaAdmin = this.adminForm.get('contrasenaAdmin')?.value;
      admin.contrasenaAntigua = this.adminForm.get('contrasenaAntigua')?.value
      this.usuarioService.updateAdmin(this.clave, this.id, admin).subscribe(
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
      console.log(admin);
      admin.contrasenaAdmin = this.adminForm.get('contrasenaAdmin2')?.value;

      this.usuarioService.addAdmin(this.clave, admin).subscribe(
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
