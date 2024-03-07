import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reciward_flutter_app/features/aprendiz/bono/domain/entities/bono_entity.dart';
import 'package:reciward_flutter_app/features/aprendiz/bono/presentation/bloc/bono_bloc.dart';
import 'package:reciward_flutter_app/features/aprendiz/profile/presentation/bloc/profile_bloc.dart';
import 'package:reciward_flutter_app/features/auth/domain/entities/user_entity.dart';

class EditarBonoPageCafeteria extends StatefulWidget {
  @override
  _BonoFormState createState() => _BonoFormState();
}

class _BonoFormState extends State<EditarBonoPageCafeteria> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _valorBonoController = TextEditingController();
  TextEditingController _puntosRequeridosController = TextEditingController();



  @override
  void dispose() {
    _valorBonoController.dispose();
    _puntosRequeridosController.dispose();
    super.dispose();
  }


 

  @override
  Widget build(BuildContext context) {
    final bono = (ModalRoute.of(context)!.settings.arguments as Map);
    _valorBonoController.text = "${bono["valorBono"]}";
    _puntosRequeridosController.text = "${bono["puntosRequeridos"]}";

    print(bono["id"]);
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario de Bono'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _valorBonoController,
                decoration: InputDecoration(
                  labelText: 'Valor del bono',
                ),
               keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _puntosRequeridosController,
               keyboardType: TextInputType.number,
                
                decoration: InputDecoration(
                  labelText: 'Puntos requeridos',
                ),
            
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    UserEntity user = (BlocProvider.of<ProfileBloc>(context).state as UserProfileState).user!;
                    BlocProvider.of<BonoBloc>(context).add(UpdateBonoEvent(accessToken: user.accces_token!, bonoEntity: BonoEntity(
                      puntosRequeridos: int.parse(_puntosRequeridosController.text.trim()),
                      valorBono: int.parse(_valorBonoController.text.trim()),
                      id: "${bono["id"]}"
                    )));
                    BlocProvider.of<BonoBloc>(context).add(GetBonosEvent(accessToken: user.accces_token!, rol: user.rol!));
                    Navigator.pop(context);
                  },
                  child: Text('Guardar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
