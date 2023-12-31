
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:reciward_flutter_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:reciward_flutter_app/features/auth/presentation/pages/home_page.dart';
import 'package:reciward_flutter_app/features/auth/presentation/pages/login_page.dart';
import 'package:reciward_flutter_app/features/auth/presentation/pages/signup_page.dart';
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
        '/home': (context) => const HomePage()
      },
      home: LoginPage(),
    ),
  ));
}



void configDependencies(){
  final getIt = GetIt.instance;
  SetupAuthDependencies.setupAuthDependencies(getIt);
  
}
