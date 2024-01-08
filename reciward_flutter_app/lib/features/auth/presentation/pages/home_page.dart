import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reciward_flutter_app/features/auth/presentation/bloc/auth_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = (BlocProvider.of<AuthBloc>(context).state as AuthenticatedState).user;

    return Container(
      child: Text('Welcom to the Reci-ward, ${user.name} ${user.aprendizEntity?.apellido}!'),
    );
  }
}