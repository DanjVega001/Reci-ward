import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:reciward_flutter_app/features/aprendiz/bono/presentation/bloc/bono_bloc.dart';
import 'package:reciward_flutter_app/features/aprendiz/bono/presentation/pages/home_bono_page.dart';
import 'package:reciward_flutter_app/features/aprendiz/bono/util/setup_bono_dependencies.dart';
import 'package:reciward_flutter_app/features/aprendiz/entrega/presentation/bloc/entrega_bloc.dart';
import 'package:reciward_flutter_app/features/aprendiz/entrega/presentation/pages/home_entrega_page.dart';
import 'package:reciward_flutter_app/features/aprendiz/entrega/util/setup_entrega_dependencies.dart';
import 'package:reciward_flutter_app/features/aprendiz/profile/presentation/bloc/profile_bloc.dart';
import 'package:reciward_flutter_app/features/aprendiz/profile/presentation/pages/profile_page.dart';
import 'package:reciward_flutter_app/features/aprendiz/profile/util/setup_profile_dependencies.dart';
import 'package:reciward_flutter_app/features/aprendiz/puntos/presentation/bloc/punto_bloc.dart';
import 'package:reciward_flutter_app/features/aprendiz/puntos/util/setup_puntos_dependencies.dart';
import 'package:reciward_flutter_app/features/aprendiz/tips/presentation/bloc/tip_bloc.dart';
import 'package:reciward_flutter_app/features/aprendiz/tips/util/setup_tip_dependencies.dart';
import 'package:reciward_flutter_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:reciward_flutter_app/core/pages/home_page.dart';
import 'package:reciward_flutter_app/features/auth/presentation/pages/auth_pages/login_page.dart';
import 'package:reciward_flutter_app/features/auth/presentation/pages/auth_pages/reset_password_page.dart';
import 'package:reciward_flutter_app/features/auth/presentation/pages/auth_pages/send_mail_reset_password_page.dart';
import 'package:reciward_flutter_app/features/auth/presentation/pages/auth_pages/signup_page.dart';
import 'package:reciward_flutter_app/features/auth/presentation/providers/ficha_provider.dart';
import 'package:reciward_flutter_app/features/auth/util/setup_auth_dependencies.dart';
import 'package:reciward_flutter_app/features/material/presentation/bloc/material_bloc.dart';
import 'package:reciward_flutter_app/features/material/util/setup_material_dependencies.dart';

void main() {
  configDependencies();
  Provider.debugCheckInvalidValueType = null;
  runApp(MultiBlocProvider(
    providers: [
      Provider(create: (context) => FichaProvider()),
      BlocProvider(create: (context) => AuthBloc()),
      BlocProvider(create: (context) => ProfileBloc()),
      BlocProvider(create: (context) => TipBloc()),
      BlocProvider(create: (context) => MaterialBloc()),
      BlocProvider(create: (context) => EntregaBloc()),
      BlocProvider(create: (context) => PuntoBloc()),
      BlocProvider(create: (context) => BonoBloc())
    ],
    child: MaterialApp(
      routes: {
        '/signup': (context) => const SignupPage(),
        '/home': (context) => HomePage(),
        '/entrega': (context) => HomeEntregaPage(),
        '/bono': (context) => const HomeBonoPage(),
        '/send-mail': (context) => const SendMailResetPasswordPage(),
        '/reset-password': (context) => const ResetPasswordPage(),
        '/profile': (context) => const ProfilePage()
      },
      home: const LoginPage(),
    ),
  ));
}

void configDependencies() {
  final getIt = GetIt.instance;
  SetupAuthDependencies.setupAuthDependencies(getIt);
  SetupProfileDependencies.setupProfileDependencies(getIt);
  SetupTipDependencies.setupTipDependencies(getIt);
  SetupMaterialDependencies.setupMaterialDependencies(getIt);
  SetupEntregaDependencies.setupEntregaDependencies(getIt);
  SetupPuntosDependencies.setupPuntosDependencies(getIt);
  SetupBonoDependencies.setupBonoDependencies(getIt);
}
