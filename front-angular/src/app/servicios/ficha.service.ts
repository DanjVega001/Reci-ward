import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class FichaService {
  //url = 'http://127.0.0.1:8000/api/auth/ficha/';
  url:string = 'https://reciward.api.adsocidm.com/api/auth/ficha';

  
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

  getFichas(access_token: any): Observable<any>{ 
    return this.http.get(this.url, this.obtenerOptions(access_token));
  }
  
  addFicha(ficha: any, access_token: any): Observable<any>{
    return this.http.post(this.url, ficha, this.obtenerOptions(access_token));
  }
  
  getFicha(id: any, access_token: any): Observable<any>{
    return this.http.get(this.url+"/"+id, this.obtenerOptions(access_token));
  }
  
  updateFicha(ficha: any, id: string, access_token: any): Observable<any>{
    return this.http.put(this.url+"/"+id, ficha, this.obtenerOptions(access_token));
  }
  
  deleteFicha(id: string, access_token: any): Observable<any>{
    return this.http.delete(this.url+"/"+id, this.obtenerOptions(access_token));
  }
}
