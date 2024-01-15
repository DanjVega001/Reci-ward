import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_links/uni_links.dart';
import 'package:reciward_flutter_app/core/constants/pallete_colors.dart';
import 'package:reciward_flutter_app/features/auth/domain/entities/user_entity.dart';
import 'package:reciward_flutter_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:reciward_flutter_app/features/auth/presentation/widgets/form_button.dart';
import 'package:reciward_flutter_app/features/auth/presentation/widgets/form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  String deepLink = "No se ha recibido ningún enlace profundo.";
  StreamController<String> deepLinkController = StreamController<String>();
  bool isResetPassword = false;


  @override
  void initState() {
    super.initState();
    initUniLinks();
  }

  Future<void> initUniLinks() async {
    String? initialLink;
    try {
      initialLink = await getInitialLink();
    } on PlatformException {
      // Manejar errores de plataforma
    }

    handleLink(initialLink);
    listenToLinks();
  }

  void listenToLinks() {
    // Escuchar eventos de enlaces profundos
    linkStream.listen((link) {
      handleLink(link);
    });
  }

  void handleLink(String? link) {
    deepLinkController.add(link ?? "No se ha recibido ningún enlace profundo.");
    if (link != null) {
      final argument =
        ModalRoute.of(context)?.settings.arguments;
      if (argument == null) {
        isResetPassword=true;
      } else {
        isResetPassword=false;
      }
      
      Uri uri = Uri.parse(link);
      String? token = uri.queryParameters['token'];
      if (uri.path == '/password-reset/' && token != null && isResetPassword) {
        Navigator.pushReplacementNamed(context, '/reset-password',
            arguments: token);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login Reciward',
        ),
        automaticallyImplyLeading: false,
        foregroundColor: Colors.white,
        centerTitle: true,
        backgroundColor: Pallete.color1,
      ),
      backgroundColor: Pallete.color1,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
          if (state is AuthenticatedState) {
            Navigator.pushNamed(context, '/home');
          }
          if (state is AuthInitialLogin && state.message!=null) {
             ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message!)));
          }
        },
        builder: (context, state) {
          if (state is AuthLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView(
              children: <Widget>[
                AuthFormField(
                  label: 'Email',
                  controller: emailController,
                  type: TextInputType.emailAddress,
                ),
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
                AuthFormButton(
                  onPressed: () {
                    BlocProvider.of<AuthBloc>(context).add(AuthLoginRequested(
                        userEntity: UserEntity(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim())));
                  },
                  text: 'Login',
                ),
                const SizedBox(
                  height: 10.0,
                ),
                AuthFormButton(
                  onPressed: () {
                    Navigator.popAndPushNamed(context, '/signup');
                  },
                  text: 'Sign up',
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/send-mail');
                  },
                  style: const ButtonStyle(foregroundColor: MaterialStatePropertyAll(Colors.white)),
                  child: const Text(
                    "¿Olvidaste tu contraseña?",   
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
