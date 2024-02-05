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
  clave: string | null = null;

  noEliminar : boolean = false;
  constructor(private _router: Router, private bonoService: BonoService){}

  ngOnInit(): void {
    this.validarToken();
    this.cargarBonos();
  }

  validarToken(): void {
    if (this.clave==null) {
      this.clave = localStorage.getItem('access_token');
    } 
    if (!this.clave) {      
      this._router.navigate(['/inicio/body']);
    }
  }

  cargarBonos(): void {
    this.bonoService.getBonos(this.clave).subscribe(
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
    this.bonoService.deleteBono(id, this.clave).subscribe(
      data => {     
        this.noEliminar = false;
        this.cargarBonos();
      }, 
      err => {
        if (err.status == 400) {
          this.noEliminar = true;
        }
        console.log(err);   
      }
    );
  }
}

