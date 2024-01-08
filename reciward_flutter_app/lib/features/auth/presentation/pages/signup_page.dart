import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reciward_flutter_app/core/constants/pallete_colors.dart';
import 'package:reciward_flutter_app/features/auth/domain/entities/aprendiz_entity.dart';
import 'package:reciward_flutter_app/features/auth/domain/entities/ficha_entity.dart';
import 'package:reciward_flutter_app/features/auth/domain/entities/user_entity.dart';
import 'package:reciward_flutter_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:reciward_flutter_app/features/auth/presentation/providers/ficha_provider.dart';
import 'package:reciward_flutter_app/features/auth/presentation/widgets/form_button.dart';
import 'package:reciward_flutter_app/features/auth/presentation/widgets/form_field.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController apellidoController = TextEditingController();
  final TextEditingController numeroDocumentoController =
      TextEditingController();
  late String selectedValueFicha;
  late String selectedValueTipoDoc;
  late List<String> itemsTipoDoc;

  @override
  void initState() {
    super.initState();
    itemsTipoDoc = ['Cedula de Ciudadania', 'Tarjeta de Identidad'];
    selectedValueTipoDoc = itemsTipoDoc.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup Reci-ward'),
        centerTitle: true,
        backgroundColor: Pallete.color1,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Pallete.color1,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
          if (state is AuthInitialLogin) {
            Navigator.popAndPushNamed(context, '/');
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                AuthFormField(
                    label: 'Nombre del aprendiz',
                    controller: nameController,
                    type: TextInputType.text),
                const SizedBox(
                  height: 10.0,
                ),
                AuthFormField(
                    label: 'Apellido del aprendiz',
                    controller: apellidoController,
                    type: TextInputType.text),
                const SizedBox(
                  height: 10.0,
                ),
                AuthFormField(
                    label: 'Email del aprendiz',
                    controller: emailController,
                    type: TextInputType.emailAddress),
                const SizedBox(
                  height: 10.0,
                ),
                AuthFormField(
                    label: 'Numero de documento del aprendiz',
                    controller: numeroDocumentoController,
                    type: TextInputType.number),
                const SizedBox(
                  height: 10.0,
                ),
                AuthFormField(
                  label: 'Password',
                  controller: passwordController,
                  type: TextInputType.text,
                  isPassword: true,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(212, 158, 158, 158)),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: DropdownButton<String>(
                    dropdownColor: Pallete.color2,
                    isExpanded: true,
                    value: selectedValueTipoDoc,
                    items: itemsTipoDoc.map<DropdownMenuItem<String>>((e) {
                      return DropdownMenuItem(
                        value: e,
                        child: Text(e, style: const TextStyle(color: Colors.white, fontSize: 16),),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValueTipoDoc = newValue!;
                      });
                    },
                    style: const TextStyle(color: Colors.white),
                    underline: Container(
                      height: 2,
                      color:
                          Pallete.color4, // Color de la línea debajo del botón
                    ),
                    // Icono a la derecha
                    elevation: 4,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                FutureBuilder(
                  future: context.read<FichaProvider>().getFichas(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('-Error al cargar datos: ${snapshot.error}');
                    } else if (!snapshot.hasData) {
                      return const Text('No hay datos disponibles');
                    } else {
                      final either = snapshot.data;
                      return either!.fold(
                        (dioException) {
                          return Text(
                              'Error al cargar datos: ${dioException.message}');
                        },
                        (fichas) {
                          if (fichas.isNotEmpty) {
                            selectedValueFicha =
                                '${fichas[0].id}. ${fichas[0].numeroFicha} - ${fichas[0].nombreFicha}';
                          }
                          return Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      const Color.fromARGB(212, 158, 158, 158)),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: DropdownButton<String>(
                              dropdownColor: Pallete.color2,
                              isExpanded: true,
                              value: selectedValueFicha,
                              items: fichas.map<DropdownMenuItem<String>>((e) {
                                return DropdownMenuItem(
                                  value:
                                      '${e.id}. ${e.numeroFicha} - ${e.nombreFicha}',
                                  child: Text(
                                      '${e.numeroFicha} - ${e.nombreFicha}',
                                      style: const TextStyle(color: Colors.white, fontSize: 16),
                                      ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                if (newValue != selectedValueFicha) {
                                  setState(() {
                                    selectedValueFicha = newValue!;                                    
                                  });
                                }
                              },
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 10.0,
                ),
                AuthFormButton(
                  text: 'Sign Up',
                  onPressed: () {
                    AprendizEntity aprendizEntity = AprendizEntity(
                        apellido: apellidoController.text.trim(),
                        numeroDocumento: int.tryParse(
                                numeroDocumentoController.text.trim()) ??
                            0,
                        tipoDocumento: selectedValueTipoDoc,
                        ficha: FichaEntity(
                            id: selectedValueFicha.substring(0, 1)));
                    UserEntity userEntity = UserEntity(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                        name: nameController.text.trim(),
                        aprendizEntity: aprendizEntity);

                    context
                        .read<AuthBloc>()
                        .add(AuthSignupRequested(userEntity: userEntity));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
