import { Component } from '@angular/core';
import { FormBuilder, FormsModule, ReactiveFormsModule } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { CommonModule } from '@angular/common';
import { TipService } from '../../servicios/tip.service';
import { Tip } from '../../modelos/tip.model';

@Component({
  selector: 'app-create',
  standalone: true,
  imports: [ReactiveFormsModule, CommonModule, FormsModule],
  providers: [TipService],
  templateUrl: './create.component.html',
  styleUrl: './create.component.scss'
})
export class CreateComponent {
  id: string | null = null;
  clave: string | null = null;
  listaTips: Tip[] = [];

  TipForm = this.fb.group({
    id: [''],
    nombre_tips: [''],
    descripcion: [''],
  });

  constructor(private fb: FormBuilder, private aRouter: ActivatedRoute, private tipService: TipService,
    private _router: Router) {
    this.id = this.aRouter.snapshot.paramMap.get('id');
  }
  ngOnInit(): void {
    this.validarToken();
    this.cargarTips();
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

  cargarTips(): void {
    this.tipService.getTips(this.clave).subscribe(
      data => {
        this.listaTips = data;
      }, err => { console.log(err); });
  }

  verEditar(): void {
    if (this.id) {
      this.tipService.getTip(this.id, localStorage.getItem('access_token'))
        .subscribe(data => {
          this.TipForm.setValue({
            id: data.id,
            nombre_tips: data.nombre_tips,
            descripcion: data.descripcion,
          });

        }, err => { console.log(err) });
    } else {
      console.log("id nulo");
    }
  }

  agregarTip(): void {
    const tip: Tip = {
      nombre_tips: this.TipForm.get('nombre_tips')?.value,
      descripcion: this.TipForm.get('descripcion')?.value,
      admin_id: Number(localStorage.getItem('user_id')),
    };
    console.log(tip);

    if (this.id !== null) {
      this.tipService.updateTip(tip, this.id, this.clave).subscribe(
        data => {
          this._router.navigate(['/tip/index']);
        },
        err => {
          console.log(err);
          this._router.navigate(['/tip/index']);
        }
      );
    } else {
      console.log(tip);

      this.tipService.addTip(tip, this.clave).subscribe(
        data => {
          console.log(data);
          this._router.navigate(['/tip/index']);
        },
        err => {
          console.log(err);
          this._router.navigate(['/tip/index']);
        }
      );
    }
  }

}
