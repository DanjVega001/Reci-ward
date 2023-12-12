import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { Ficha } from '../../modelos/ficha.model';
import { CommonModule } from '@angular/common';
import { FichaService } from '../../servicios/ficha.service';


@Component({
  selector: 'app-index',
  standalone: true,
  imports: [CommonModule],
  providers: [FichaService],
  templateUrl: './index.component.html',
  styleUrl: './index.component.scss'
})
export class IndexComponent {

  listaFicha : Ficha[] = [];
  clave: string | null = null;

  constructor(private _router: Router, private fichaService: FichaService){}

  ngOnInit(): void {
    this.validarToken();
    this.cargarFichas();
  }
  
  validarToken(): void {
    if (this.clave == null) {
      this.clave = localStorage.getItem('access_token');
    }
    if (!this.clave) {
      this._router.navigate(['/inicio/body']);
    }
  }
  
  cargarFichas(): void {
    this.fichaService.getFichas(this.clave).subscribe(
      data => {
        this.listaFicha = data;
      },
      err => {
        console.log(err);
      }
    );
  }
  
  editarFicha(id: any): void {
    this._router.navigateByUrl('/ficha/edit/' + id);
  }
  
  eliminarFicha(id: any): void {
    this.fichaService.deleteFicha(id, this.clave).subscribe(
      data => {
        this.cargarFichas();
      },
      err => {
        console.log(err);
      }
    );
  }
  
}
