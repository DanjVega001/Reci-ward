import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class LoginService {

  //url:string = 'http://127.0.0.1:8000/api/auth/';
  url:string = 'http://reciward.api.adsocidm.com/api/auth';


  constructor(private http : HttpClient) { }

  obtenerOptions(access_token:any):Object{
    const headers = new HttpHeaders({
      'Content-type' : 'application/json',
      'Authorization' : 'Bearer ' + access_token
    });
    return {
      'headers': headers
    }
  }

  login(email:any, password:any):Observable<any>{
    return this.http.post(this.url+"/"+"login", {email:email, password:password});
  }

  logout(access_token:any): Observable<any> {
    localStorage.removeItem('access_token');
    return this.http.get(`${this.url}/logout`, this.obtenerOptions(access_token));
  }

}
