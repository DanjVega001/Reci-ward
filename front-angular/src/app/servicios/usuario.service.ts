import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Admin } from '../modelos/admin.model';
import { Cafeteria } from '../modelos/cafeteria.model';

@Injectable({
  providedIn: 'root'
})
export class UsuarioService {

  //url = 'http://127.0.0.1:8000/api/auth/';
  url:string = 'https://reciward.api.adsocidm.com/api/auth';


  obtenerOptions(access_token:any):Object{
    const headers = new HttpHeaders({
      'Content-type' : 'application/json',
      'Authorization' : 'Bearer ' + access_token
    });
    return {
      'headers': headers
    }
  }

  constructor(private http: HttpClient) { }

  getAdmins(access_token:any):Observable<any> {
    return this.http.get(this.url+"/"+'admin', this.obtenerOptions(access_token));
  }

  getCafeterias(access_token:any):Observable<any> {
    return this.http.get(this.url+"/"+'cafeteria', this.obtenerOptions(access_token));
  }

  addAdmin(access_token:any, admin:Admin):Observable<any> {
    return this.http.post(this.url+"/"+'admin', admin, this.obtenerOptions(access_token));
  }

  addCafeteria(access_token:any, cafeteria:Cafeteria):Observable<any> {
    return this.http.post(this.url+'cafeteria', cafeteria, this.obtenerOptions(access_token));
  }

  getAdmin(access_token:any, id:any):Observable<any> {
    return this.http.get(this.url+"/"+'admin/'+id, this.obtenerOptions(access_token));
  }

  getCafeteria(access_token:any, id:any):Observable<any> {
    return this.http.get(this.url+"/"+'cafeteria/'+id, this.obtenerOptions(access_token));
  }

  updateAdmin(access_token:any, id:any, admin:Admin):Observable<any> { 
    return this.http.put(this.url+'admin/'+id, admin, this.obtenerOptions(access_token));
  }

  updateCafeteria(access_token:any, id:any, cafeteria:Cafeteria):Observable<any> { 
    return this.http.put(this.url+"/"+'cafeteria/'+id, cafeteria, this.obtenerOptions(access_token));
  }

  deleteAdmin(access_token:any, id:any):Observable<any> {
    return this.http.delete(this.url+"/"+'admin/'+id, this.obtenerOptions(access_token));
  }

  deleteCafeteria(access_token:any, id:any):Observable<any> {
    return this.http.delete(this.url+"/"+'cafeteria/'+id, this.obtenerOptions(access_token));
  }

}
