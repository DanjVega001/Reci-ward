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

  constructor(private _router: Router, private aprendizService: AprendizService){}

  ngOnInit():void{
    
    this.cargarAprendices();
  }

  cargarAprendices(){
    this.aprendizService.getAprendices(localStorage.getItem('access_token')).subscribe(
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
    this.aprendizService.deleteAprendiz(id, localStorage.getItem('access_token')).subscribe(
      data => {
        this.cargarAprendices();
      }, err => {
        console.log(err);   
      }
    );
  }
}
