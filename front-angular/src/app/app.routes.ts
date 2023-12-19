import { Routes } from '@angular/router';
import { BodyComponent } from './inicio/body/body.component';
import { IndexComponent as IndexFicha } from './ficha/index/index.component';
import { CreateComponent as CreateFicha } from './ficha/create/create.component';
import { IndexComponent as IndexAprendiz } from './aprendiz/index/index.component';
import { CreateComponent as CreateAprendiz} from './aprendiz/create/create.component';
import { IndexComponent as IndexBono } from './bono/index/index.component';
import { CreateComponent as CreateBono } from './bono/create/create.component';
import { IndexComponent as IndexMaterial } from './material/index/index.component';
import { CreateComponent as CreateMaterial } from './material/create/create.component';
import { IndexComponent as IndexTip} from './tip/index/index.component';
import { CreateComponent as CreateTip } from './tip/create/create.component';
import { IndexComponent as IndexHistorialEntrega } from './historial/entrega/index/index.component';
import { IndexComponent as IndexHistorialBono } from './historial/bonos/index/index.component';
import { DetallesComponent } from './historial/entrega/detalles/detalles.component';
import { IndexComponent as IndexUsuario } from './usuarios/index/index.component';
import { CreateAdminComponent } from './usuarios/create-admin/create-admin.component';
import { CreateCafeteriaComponent } from './usuarios/create-cafeteria/create-cafeteria.component';


export const routes: Routes = [
    { path: '', redirectTo: 'inicio/body', pathMatch: 'full' },
    { path: 'inicio/body', component: BodyComponent },

    { path: 'ficha/index', component: IndexFicha},
    { path: 'ficha/create', component: CreateFicha},
    { path: 'ficha/edit/:id', component: CreateFicha},


    { path: 'aprendiz/index', component: IndexAprendiz},
    { path: 'aprendiz/edit/:id', component: CreateAprendiz },

    { path: 'bono/index', component: IndexBono},
    { path: 'bono/create', component: CreateBono},
    { path: 'bono/edit/:id', component: CreateBono },

    { path: 'material/index', component: IndexMaterial},
    { path: 'material/create', component: CreateMaterial},
    {path: 'material/edit/:id', component: CreateMaterial},

    { path: 'tip/index', component: IndexTip},
    { path: 'tip/create', component: CreateTip},
    { path: 'tip/edit/:id', component: CreateTip},

    { path: 'historial/entrega/index', component: IndexHistorialEntrega},
    { path: 'historial/bonos/index', component: IndexHistorialBono},
   
    { path: 'historial/entrega/detalles/:id', component: DetallesComponent},

    { path: 'usuario/index', component: IndexUsuario },
    
    { path: 'usuario/admin/create', component: CreateAdminComponent },
    { path: 'usuario/admin/edit/:id', component: CreateAdminComponent },

    { path: 'usuario/cafeteria/create', component: CreateCafeteriaComponent },
    { path: 'usuario/cafeteria/edit/:id', component: CreateCafeteriaComponent },    
];
