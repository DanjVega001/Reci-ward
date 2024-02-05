import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ClasificacionService {
  url = 'http://127.0.0.1:8000/api/auth/clasificacion/';
  
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
  getClasificaciones(access_token: any): Observable<any>{ 
    return this.http.get(this.url, this.obtenerOptions(access_token));
  }

  getClasificacion(id: any, access_token: any): Observable<any>{
    return this.http.get(this.url + id, this.obtenerOptions(access_token));
  }
}
