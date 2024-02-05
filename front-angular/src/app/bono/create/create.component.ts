import { Component } from '@angular/core';
import { FormBuilder, FormsModule, ReactiveFormsModule } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { CommonModule } from '@angular/common';
import { BonoService } from '../../servicios/bono.service';
import { Bono } from '../../modelos/bono.model';

@Component({
  selector: 'app-create',
  standalone: true,
  imports: [ReactiveFormsModule, CommonModule, FormsModule],
  providers: [BonoService],
  templateUrl: './create.component.html',
  styleUrl: './create.component.scss'
})
export class CreateComponent {
  id: string | null = null;
  clave: string | null = null;

  bonoForm = this.fb.group({
    valorBono : '',
    puntosRequeridos: '',
  });

  constructor(private fb: FormBuilder, private aRouter: ActivatedRoute,private BonoService: BonoService, private _router:Router ){
    this.id = this.aRouter.snapshot.paramMap.get('id');
  }
  ngOnInit():void {
    this.validarToken();
    this.verEditar();
  }

  validarToken(): void {
    if (this.clave==null) {
      this.clave = localStorage.getItem('access_token');
    } 
    if (!this.clave) {      
      this._router.navigate(['/inicio/body']);
    }
  }

  verEditar(): void {
    if (this.id) {
      this.BonoService.getBono(this.id, localStorage.getItem('access_token'))
      .subscribe(data => { 
        
        this.bonoForm.setValue({
          valorBono: data.valorBono,
          puntosRequeridos: data.puntosRequeridos,
        }); 
        
      }, err => { console.log(err) });   
    } else {
      console.log("id nulo");
    }
  }

  agregarBono(): void {
    const bono: Bono = {
      valorBono: Number (this.bonoForm.get('valorBono')?.value),
      puntosRequeridos: Number(this.bonoForm.get('puntosRequeridos')?.value),
    };
    console.log(bono);
  
    if (this.id !== null) {
      this.BonoService.updateBono(bono, this.id, this.clave).subscribe(
        data => {
          this._router.navigate(['/bono/index']);
        },
        err => {
          console.log(err);
          this._router.navigate(['/bono/index']);
        }
      );
    } else {
      this.BonoService.addBono(bono, this.clave).subscribe(
        data => {
          console.log(data);
          this._router.navigate(['/bono/index']);
        },
        err => {
          console.log(err);
          this._router.navigate(['/bono/index']);
        }
      );
    }
  }
  


}
