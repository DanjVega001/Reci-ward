import { Component } from '@angular/core';
import { FormBuilder, ReactiveFormsModule } from '@angular/forms';
import { LoginService } from '../../servicios/login.service';
import { Login } from '../../modelos/login.model';
import { Router } from '@angular/router';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-body',
  standalone: true,
  imports: [ReactiveFormsModule, CommonModule],
  providers: [LoginService],
  templateUrl: './body.component.html',
  styleUrls: ['./body.component.scss']
})
export class BodyComponent {


  loginForm=this.fb.group({
    email:'',
    password:''
  });

  constructor(private fb: FormBuilder, private loginService:LoginService,
    private _router:Router){}

  login(){
    this.loginService.login(this.loginForm.get('email')?.value,
      this.loginForm.get('password')?.value).subscribe(
        data => {
          if (data!==null) {
            localStorage.setItem('access_token', data?.access_token);
            
            localStorage.setItem('user_id', data?.id);
            this._router.navigate(['/aprendiz/index'], {replaceUrl : true});

          }
        }, err => {
          console.log(err);
        })
  }
}
