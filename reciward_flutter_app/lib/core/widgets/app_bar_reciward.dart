import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reciward_flutter_app/core/constants/pallete_colors.dart';
import 'package:reciward_flutter_app/features/aprendiz/profile/presentation/bloc/profile_bloc.dart';

class AppBarReciward extends StatelessWidget implements PreferredSizeWidget {
  const AppBarReciward({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final user =
        (BlocProvider.of<ProfileBloc>(context).state as UserProfileState).user;

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
            "${user.name} ${user.aprendizEntity?.apellido}",
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
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
