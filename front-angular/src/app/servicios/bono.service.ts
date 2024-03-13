import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Bono } from '../modelos/bono.model';

@Injectable({
    providedIn: 'root'
  })
  export class BonoService {
    //url = 'http://127.0.0.1:8000/api/auth/bono-admin/';
    url:string = 'https://reciward.api.adsocidm.com/api/auth/bono-admin';

    
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

getBonos(access_token: any): Observable<any> {
    return this.http.get(this.url, this.obtenerOptions(access_token));
  }
  
  addBono(bono: Bono, access_token: any): Observable<any> {
    return this.http.post(this.url, bono, this.obtenerOptions(access_token));
  }
  
  getBono(id: any, access_token: any): Observable<any> {
    return this.http.get(this.url+"/"+id, this.obtenerOptions(access_token));
  }
  
  updateBono(bono: Bono, id: string, access_token: any): Observable<any> {
    return this.http.put(this.url+"/"+id, bono, this.obtenerOptions(access_token));
  }
  
  deleteBono(id: string, access_token: any): Observable<any> {
    return this.http.delete(this.url+"/"+id, this.obtenerOptions(access_token));
  }
  
}
