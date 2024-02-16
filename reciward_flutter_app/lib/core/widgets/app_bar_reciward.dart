import 'dart:io';

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
          final user = state.user;
          final imagePath = user?.aprendizEntity?.avatar;
          //print(Directory);

          return AppBar(
            backgroundColor: Pallete.colorWhite,
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 25,
                  backgroundImage: imagePath == null
                      ? const AssetImage('assets/images/img_ambiente.jpg')
                      : FileImage(File(imagePath)) as ImageProvider<Object>,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "${user?.name} ${user?.aprendizEntity?.apellido}",
                  style: const TextStyle(fontFamily: 'Ubuntu'),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.edit,
                    color: Pallete.color1,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/profile');
                  },
                ),
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
