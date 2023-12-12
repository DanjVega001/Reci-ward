import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class MaterialService {
  url = 'http://127.0.0.1:8000/api/auth/material/';

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
  getMateriales(access_token: any): Observable<any>{ 
    return this.http.get(this.url, this.obtenerOptions(access_token));
  }
  
  addMaterial(material: any, access_token: any): Observable<any>{
    return this.http.post(this.url, material, this.obtenerOptions(access_token));
  }
  
  getMaterial(id: any, access_token: any): Observable<any>{
    return this.http.get(this.url + id, this.obtenerOptions(access_token));
  }
  
  updateMaterial(material: any, id: string, access_token: any): Observable<any>{
    return this.http.put(this.url + id, material, this.obtenerOptions(access_token));
  }
  
  deleteMaterial(id: string, access_token: any): Observable<any>{
    return this.http.delete(this.url + id, this.obtenerOptions(access_token));
  }
  
}
