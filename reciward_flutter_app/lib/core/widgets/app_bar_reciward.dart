import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reciward_flutter_app/core/constants/pallete_colors.dart';
import 'package:reciward_flutter_app/features/aprendiz/profile/presentation/bloc/profile_bloc.dart';
import 'package:reciward_flutter_app/features/auth/presentation/bloc/auth_bloc.dart';

class AppBarReciward extends StatelessWidget implements PreferredSizeWidget {
  const AppBarReciward({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is SessionEndedState) {
          //state.killUser();
          BlocProvider.of<AuthBloc>(context)
              .add(AuthLogoutRequested(accessToken: state.accessToken));
          /*ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message!)));*/
          Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
        }
      },
      builder: (context, state) {
        if (state is UserProfileState) {
          /*
          final user =
              (BlocProvider.of<ProfileBloc>(context).state as UserProfileState)
                  .user;*/
          final user = state.user;
          return AppBar(
            backgroundColor: Pallete.colorGrey,
            automaticallyImplyLeading: false,
            title: Row(
              children: <Widget>[
                const CircleAvatar(
                  child: Icon(Icons.person),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "${user?.name} ${user?.aprendizEntity?.apellido}",
                ),
                IconButton(
                  icon: const Icon(
                    Icons.edit,
                    color: Pallete.color1,
                  ),
                  onPressed: () {
                    // POR CREAR RUTA
                    Navigator.pushNamed(context, '/profile');
                  },
                ),
                const SizedBox(width: 107),
                IconButton(
                  icon: const Icon(
                    Icons.logout,
                    color: Pallete.color1,
                  ),
                  onPressed: () {
                    /*BlocProvider.of<AuthBloc>(context).add(
                        AuthLogoutRequested(accessToken: user!.accces_token!));*/
                    BlocProvider.of<ProfileBloc>(context)
                        .add(EndSession(accessToken: user!.accces_token!));
                  },
                )
              ],
            ),
          );
        } else {
          return const Text("Errorr---");
        }
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
