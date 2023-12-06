import { Component } from '@angular/core';
import { Aprendiz } from '../../modelos/aprendiz.model';
import { Router } from '@angular/router';
import { AprendizService } from '../../servicios/aprendiz.service';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-index',
  standalone: true,
  imports: [CommonModule],
  providers: [AprendizService],
  templateUrl: './index.component.html',
  styleUrl: './index.component.scss'
})
export class IndexComponent {
  listaAprendices : Aprendiz[] = [];
  clave: string | null = null;

  constructor(private _router: Router, private aprendizService: AprendizService){}

  ngOnInit():void{
    this.validarToken();
    this.cargarAprendices();
  }

  validarToken(): void {
    if (this.clave==null) {
      this.clave = localStorage.getItem('access_token');
    } 
    if (!this.clave) {      
      this._router.navigate(['/inicio/body']);
    }
  }

  cargarAprendices(){
    this.aprendizService.getAprendices(this.clave).subscribe(
      data => {
        this.listaAprendices = data;
      }, 
      err => {
        console.log(err);
      });
  }

  editarAprendiz(id:any):void{
    this._router.navigateByUrl('/aprendiz/edit/'+id);
  }

  eliminarAprendiz(id:any):void{
    this.aprendizService.deleteAprendiz(id, this.clave).subscribe(
      data => {
        this.cargarAprendices();
      }, err => {
        console.log(err);   
      }
    );
  }
}
