import { Component } from '@angular/core';
import { FormBuilder, FormsModule, ReactiveFormsModule } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { CommonModule } from '@angular/common';
import { FichaService } from '../../servicios/ficha.service';
import { Ficha } from '../../modelos/ficha.model';

@Component({
  selector: 'app-create',
  standalone: true,
  imports: [ReactiveFormsModule, CommonModule, FormsModule],
  providers: [FichaService],
  templateUrl: './create.component.html',
  styleUrl: './create.component.scss'
})
export class CreateComponent {
  id: string | null = null;
  clave: string | null = null;
  listaFichas: Ficha[] = [];

  fichaForm = this.fb.group({
    codigoFicha: [''], 
    nombreFicha: [''],
    fechaCreacion: [null], 
    fechaFin: [null],
  });
  

 constructor(private  fb: FormBuilder, private aRouter: ActivatedRoute,private fichaService:FichaService,
  private _router:Router){
    this.id = this.aRouter.snapshot.paramMap.get('id');
  }
  ngOnInit():void {
    this.validarToken();
    this.cargarFichas();
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

  cargarFichas():void{
    this.fichaService.getFichas(this.clave).subscribe(
      data =>{
        this.listaFichas = data;
      }, err=> {console.log(err);});
  }

  verEditar(): void {
    if (this.id) {
      this.fichaService.getFicha(this.id, localStorage.getItem('access_token'))
      .subscribe(data => { 
        
        this.fichaForm.setValue({
          codigoFicha: data.codigoFicha,
          nombreFicha: data.nombreFicha,
          fechaCreacion: data.fechaCreacion,
          fechaFin: data.fechaFin,
        }); 
        
      }, err => { console.log(err) });   
    } else {
      console.log("id nulo");
    }
  }

  agregarFicha(): void {
    const ficha: Ficha = {
      codigoFicha: Number (this.fichaForm.get('codigoFicha')?.value),
      nombreFicha: this.fichaForm.get('nombreFicha')?.value,
      fechaCreacion: this.fichaForm.get('fechaCreacion')?.value,
      fechaFin: this.fichaForm.get('fechaFin')?.value,
      admin_id: Number (localStorage.getItem('user_id')),
    };
    console.log(ficha);
  
    if (this.id !== null) {
      this.fichaService.updateFicha(ficha, this.id, this.clave).subscribe(
        data => {
          this._router.navigate(['/ficha/index']);
        },
        err => {
          console.log(err);
          this._router.navigate(['/ficha/index']);
        }
      );
    } else {
      this.fichaService.addFicha(ficha, this.clave).subscribe(
        data => {
          console.log(data);
          this._router.navigate(['/ficha/index']);
        },
        err => {
          console.log(err);
          this._router.navigate(['/ficha/index']);
        }
      );
    }
}
}
