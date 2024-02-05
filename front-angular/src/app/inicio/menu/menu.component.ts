import { Component } from '@angular/core';
import { LoginService } from '../../servicios/login.service';
import { Router } from '@angular/router';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-menu',
  standalone: true,
  imports: [CommonModule],
  providers: [LoginService],
  templateUrl: './menu.component.html',
  styleUrl: './menu.component.scss'
})
export class MenuComponent {

  access_token: string | null = null;

  constructor(private authService: LoginService, private router: Router) {
  }

  ngOnInit(){
    this.getAccess_token();
    console.log("Acces_token = " + this.access_token);
  }

  getAccess_token(): void {
    this.access_token = localStorage.getItem('access_token');
  }

  logout() {
    this.authService.logout(localStorage.getItem('access_token')).subscribe(
      () => {
        this.access_token = null;
        this.router.navigate(['/']);
      },
      (error) => {
        console.error('Error during logout:', error);
      }
    );
  }
}
