import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reciward_flutter_app/core/constants/pallete_colors.dart';
import 'package:reciward_flutter_app/features/aprendiz/profile/presentation/bloc/profile_bloc.dart';
import 'package:reciward_flutter_app/features/auth/presentation/bloc/auth_bloc.dart';

class HomePageCafeteria extends StatelessWidget {
  const HomePageCafeteria({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is SessionEndedState) {
          BlocProvider.of<AuthBloc>(context)
              .add(AuthLogoutRequested(accessToken: state.accessToken));
          Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
        }
      },
      builder: (context, state) {
        if (state is UserProfileState) {
          final user = state.user;
          return Scaffold(
            backgroundColor: Pallete.colorWhite,
            appBar: AppBar(
              centerTitle: true,
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    user!.name!,
                    style: const TextStyle(fontFamily: 'Ubuntu'),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.logout,
                      color: Pallete.color1,
                    ),
                    onPressed: () {
                      BlocProvider.of<ProfileBloc>(context)
                          .add(EndSession(accessToken: user.accces_token!));
                    },
                  )
                ],
              ),
            ),
            body: Container(
              color: Pallete.colorWhite,
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                children: <Widget>[
                  const Image(
                      image: AssetImage("assets/images/logo_reciward.jpg")),
                  Expanded(
                    child: CustomScrollView(
                      primary: false,
                      slivers: <Widget>[
                        SliverGrid.count(
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                          crossAxisCount: 2,
                          children: <Widget>[
                            TextButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.book_online_rounded),
                              label: const Text("Bonos"),
                              
                              style: const ButtonStyle(
                                alignment: Alignment.center,
                                fixedSize: MaterialStatePropertyAll(Size(20, 20))
                              ),
                              
                            ),
                            TextButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.checklist_rounded),
                              label: const Text("Validar Bonos"),
                              style: const ButtonStyle(
                                alignment: Alignment.center
                              ),
                            ),
                            TextButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.delivery_dining_rounded),
                              label: const Text("Validar Entrega"),
                              style: const ButtonStyle(
                                alignment: Alignment.center
                              ),
                            ),
                            const Icon(
                              Icons.blur_on
                              
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return Text("Fallo en el servidor");
      },
    );
  }
}
