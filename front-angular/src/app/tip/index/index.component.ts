import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router } from '@angular/router';
import { Tip } from '../../modelos/tip.model';
import { TipService } from '../../servicios/tip.service';

@Component({
  selector: 'app-index',
  standalone: true,
  imports: [CommonModule],
  providers: [TipService],
  templateUrl: './index.component.html',
  styleUrl: './index.component.scss'
})
export class IndexComponent {

  listaTip: Tip[] = [];
  clave: string | null = null;

  constructor(private _router: Router, private TipService: TipService) { }

  ngOnInit(): void {
    this.validarToken();
    this.cargarTip();
  }

  validarToken(): void {
    if (this.clave == null) {
      this.clave = localStorage.getItem('access_token');
    }
    if (!this.clave) {
      this._router.navigate(['/inicio/body']);
    }
  }

  cargarTip(): void {
    this.TipService.getTips(this.clave).subscribe(
      data => {
        console.log(data);
        
        this.listaTip = data;
      },
      err => {
        console.log(err);
      }
    );
  }

  editarTip(id: any): void {
    this._router.navigateByUrl('/tip/edit/' + id);
  }

  eliminarTip(id: any): void {
    this.TipService.deleteTip(id, this.clave).subscribe(
      data => {
        this.cargarTip();
      },
      err => {
        console.log(err);
      }
    );
  }
}
