import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class TipService {
  url = 'http://127.0.0.1:8000/api/auth/tip/';

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

  getTips(access_token: any): Observable<any>{ 
    return this.http.get(this.url, this.obtenerOptions(access_token));
  }
  
  addTip(tip: any, access_token: any): Observable<any>{
    return this.http.post(this.url, tip, this.obtenerOptions(access_token));
  }
  
  getTip(id: any, access_token: any): Observable<any>{
    return this.http.get(this.url + id, this.obtenerOptions(access_token));
  }
  
  updateTip(tip: any, id: string, access_token: any): Observable<any>{
    return this.http.put(this.url + id, tip, this.obtenerOptions(access_token));
  }
  
  deleteTip(id: string, access_token: any): Observable<any>{
    return this.http.delete(this.url + id, this.obtenerOptions(access_token));
  }
  
}

