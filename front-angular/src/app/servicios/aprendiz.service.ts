import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Aprendiz } from '../modelos/aprendiz.model';

@Injectable({
  providedIn: 'root'
})
export class AprendizService {

  url = 'http://127.0.0.1:8000/api/auth/aprendiz/';
  
  obtenerOptions(access_token:any):Object{
    const headers = new HttpHeaders({
      'Content-type' : 'application/json',
      'Authorization' : 'Bearer ' + access_token
    });
    return {
      'headers': headers
    }
  }

  constructor(private http:HttpClient) { }

  getAprendices(access_token:any): Observable<any>{ 
    return this.http.get(this.url, this.obtenerOptions(access_token));
  }

  addAprendiz(aprendiz: Aprendiz, access_token:any): Observable<any>{
    return this.http.post(this.url, aprendiz, this.obtenerOptions(access_token));
  }

  getAprendiz(id:any, access_token:any):Observable<any>{
    return this.http.get(this.url+id, this.obtenerOptions(access_token));
  }

  updateAprendiz(aprendiz:Aprendiz, id:string, access_token:any): Observable<any>{
    return this.http.put(this.url+id, aprendiz, this.obtenerOptions(access_token));
  }
  
  deleteAprendiz(id:string, access_token:any):Observable<any>{
    return this.http.delete(this.url+id, this.obtenerOptions(access_token));
  }

  
}
