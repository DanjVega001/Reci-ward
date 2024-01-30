import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router } from '@angular/router';
import { UsuarioService } from '../../servicios/usuario.service';
import { Cafeteria } from '../../modelos/cafeteria.model';
import { Admin } from '../../modelos/admin.model';
import { finalize } from 'rxjs';

@Component({
  selector: 'app-index',
  standalone: true,
  imports: [CommonModule],
  providers: [UsuarioService],
  templateUrl: './index.component.html',
  styleUrl: './index.component.scss'
})
export class IndexComponent {

  clave: string | null = null;
  listaCafeterias : Cafeteria[] = [];
  listaAdmins : Admin[] = [];

  noEliminarCafeteria: boolean = false;
  noEliminarAdmin: boolean = false;

  constructor(private usuarioService : UsuarioService, private _router : Router){
  }

  ngOnInit(){
    this.validarToken();
    this.cargarAdmins();
    this.cargarCafeterias();
  }

  validarToken(): void {
    if (this.clave == null) {
      this.clave = localStorage.getItem('access_token');
    }
    if (!this.clave) {
      this._router.navigate(['/inicio/body']);
    }
  }

  cargarCafeterias():void{
    this.usuarioService.getCafeterias(this.clave).subscribe(
      data => {
        this.listaCafeterias = data
      }, err => { console.log(err); }
    )
  }

  cargarAdmins():void{
    this.usuarioService.getAdmins(this.clave).subscribe(
      data => {
        this.listaAdmins = data
      }, err => { console.log(err); }
    )
  }

  editarCafeteria(id:any):void{
    this._router.navigateByUrl('/usuario/cafeteria/edit/'+id);
  }

  editarAdmin(id:any):void{
    this._router.navigateByUrl('/usuario/admin/edit/'+id);
  }

  eliminarCafeteria(id:any):void {
    this.usuarioService.deleteCafeteria(this.clave, id).subscribe(
      data => { 
        this.noEliminarCafeteria = false;
        this.cargarCafeterias();
      }, err => { 
        if (err.status) {
          this.noEliminarCafeteria = true;
        }
        console.log(err); 
      }
    )
  }

  eliminarAdmin(id:any):void {
    var user_id = localStorage.getItem('user_id');
    if (user_id != id) {
      this.usuarioService.deleteAdmin(this.clave, id).subscribe(
        data => {
          this.noEliminarAdmin = false;
          this.cargarAdmins();
        }, err => { 

          console.log(err); 
        }
      )
    }
    else {
      this.noEliminarAdmin = true;      

      console.log("No se puede elmimar");
      
    }
    
  }
}
