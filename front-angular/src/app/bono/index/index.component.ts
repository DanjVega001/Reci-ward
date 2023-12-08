import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { CommonModule } from '@angular/common';
import { Bono } from '../../modelos/bono.model';
import { BonoService } from '../../servicios/bono.service';

@Component({
  selector: 'app-index',
  standalone: true,
  imports: [CommonModule],
  providers: [BonoService],
  templateUrl: './index.component.html',
  styleUrl: './index.component.scss'
})
export class IndexComponent {
  listaBonos: Bono[] = [];

  constructor(private _router: Router, private bonoService: BonoService){}

  ngOnInit(): void {
    this.cargarBonos();
  }

  cargarBonos(): void {
    this.bonoService.getBonos(localStorage.getItem('access_token')).subscribe(
      data => {
        this.listaBonos = data;
      }, 
      err => {
        console.log(err);
      });
  }

  editarBono(id: any): void {
    this._router.navigateByUrl('/bono/edit/' + id);
  }

  eliminarBono(id: any): void {
    this.bonoService.deleteBono(id, localStorage.getItem('access_token')).subscribe(
      data => {
        this.cargarBonos();
      }, 
      err => {
        console.log(err);   
      }
    );
  }
}

