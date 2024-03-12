import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class AdminService {

  //url = 'http://127.0.0.1:8000/api/auth/';
  url:string = 'http://reciward.api.adsocidm.com/api/auth';


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

  getEntregas(documento:any, access_token:any):Observable<any>{ 
    return this.http.get(this.url+"/"+'entrega/historial-admin/'+documento,
      this.obtenerOptions(access_token));
  }

  getBonos(documento:any, access_token:any):Observable<any>{
    return this.http.get(this.url+"/"+'aprendiz-bono/admin/'+documento,
      this.obtenerOptions(access_token));
  }

  getDetallesEntrega(id:any, access_token:any):Observable<any>{
    return this.http.get(this.url+"/"+'material-entrega/admin/'+id, 
      this.obtenerOptions(access_token));
  }
}
