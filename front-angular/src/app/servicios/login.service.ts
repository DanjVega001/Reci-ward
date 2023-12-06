import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class LoginService {

  url:string = 'http://127.0.0.1:8000/api/auth/';

  constructor(private http : HttpClient) { }

  login(email:any, password:any):Observable<any>{
    return this.http.post(this.url+"login", {email:email, password:password});
  }

}
