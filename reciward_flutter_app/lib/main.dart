
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:reciward_flutter_app/features/aprendiz/bono/presentation/pages/home_bono_page.dart';
import 'package:reciward_flutter_app/features/aprendiz/entrega/presentation/pages/home_entrega_page.dart';
import 'package:reciward_flutter_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:reciward_flutter_app/core/pages/home_page.dart';
import 'package:reciward_flutter_app/features/auth/presentation/pages/auth_pages/login_page.dart';
import 'package:reciward_flutter_app/features/auth/presentation/pages/auth_pages/reset_password_page.dart';
import 'package:reciward_flutter_app/features/auth/presentation/pages/auth_pages/send_mail_reset_password_page.dart';
import 'package:reciward_flutter_app/features/auth/presentation/pages/auth_pages/signup_page.dart';
import 'package:reciward_flutter_app/features/auth/presentation/providers/ficha_provider.dart';
import 'package:reciward_flutter_app/features/auth/util/setup_auth_dependencies.dart';


void main() {
  configDependencies();
  Provider.debugCheckInvalidValueType = null;
  runApp(MultiBlocProvider(
    providers: [
      Provider(create: (context) => FichaProvider()),
      BlocProvider(create: (context) => AuthBloc())
    ],
    child: MaterialApp(
      routes: {
        '/signup': (context) => const SignupPage(),
        '/home': (context) => HomePage(),
        '/entrega': (context) => const HomeEntregaPage(),
        '/bono': (context) => const HomeBonoPage(),
        '/send-mail': (context) => const SendMailResetPasswordPage(),
        '/reset-password': (context) => const ResetPasswordPage()
      },
      home: const LoginPage(),
    ),
  ));
}



void configDependencies(){
  final getIt = GetIt.instance;
  SetupAuthDependencies.setupAuthDependencies(getIt);
  
}
