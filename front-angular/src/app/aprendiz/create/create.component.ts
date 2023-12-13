import { Component } from '@angular/core';
import { FormBuilder, FormsModule, ReactiveFormsModule } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { AprendizService } from '../../servicios/aprendiz.service';
import { CommonModule } from '@angular/common';
import { FichaService } from '../../servicios/ficha.service';
import { Ficha } from '../../modelos/ficha.model';
import { Aprendiz } from '../../modelos/aprendiz.model';

@Component({
  selector: 'app-create',
  standalone: true,
  imports: [ReactiveFormsModule, CommonModule, FormsModule],
  providers: [AprendizService, FichaService],
  templateUrl: './create.component.html',
  styleUrl: './create.component.scss'
})
export class CreateComponent {

  id: string | null = null;
  clave: string | null = null;
  listaFichas: Ficha[] = []; 

  aprendizForm = this.fb.group({
    nombre: '',
    apellido: '',
    email: '',
    password: '',
    numeroDocumento: '',
    tipoDocumento: '',
    ficha: ''
  });

  constructor(private fb: FormBuilder, private aRouter: ActivatedRoute, 
    private aprendizService:AprendizService, private fichaService:FichaService,
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
      this.aprendizService.getAprendiz(this.id, localStorage.getItem('access_token'))
      .subscribe(data => { 
        
        this.aprendizForm.setValue({
          apellido: data.apellido,
          nombre: data.name,
          email: data.email,
          password: '',
          tipoDocumento: data.tipoDocumento,
          numeroDocumento: data.numeroDocumento,
          ficha: data.numeroFicha
        }); 
        
      }, err => { console.log(err) });   
    } else {
      console.log("id nulo");
      
    }
   
  }

  editarAprendiz(): void{
    const aprendiz: Aprendiz = {
      numeroDocumento : Number(this.aprendizForm.get('numeroDocumento')?.value!),
      tipoDocumento : this.aprendizForm.get('tipoDocumento')?.value,
      correo: this.aprendizForm.get('email')?.value,
      ficha_id: Number(this.aprendizForm.get('ficha')?.value),
      nombre: this.aprendizForm.get('nombre')?.value,
      apellido: this.aprendizForm.get('apellido')?.value,
    };
    console.log(aprendiz);
    
    if (this.id!==null) {
      this.aprendizService.updateAprendiz(aprendiz, this.id, this.clave).subscribe(
        data => {
          this._router.navigate(['/aprendiz/index']);
        },
        err => {
          console.log(err);
          this._router.navigate(['/aprendiz/index']);
        }
      );
    } 
  }
}
