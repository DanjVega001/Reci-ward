import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reciward_flutter_app/core/constants/pallete_colors.dart';
import 'package:reciward_flutter_app/features/aprendiz/bono/presentation/bloc/bono_bloc.dart';
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
                  Card(
                    color: Pallete.color1,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Instrucciones de uso',
                            style: TextStyle(
                                color: Pallete.colorWhite,
                                fontSize: 21.0,
                                fontFamily: 'Ubuntu'),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            'Guía de uso y recomendaciones para la aplicación',
                            style: TextStyle(
                                color: Pallete.colorWhite,
                                fontSize: 15,
                                fontFamily: 'Ubuntu'),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextButton(
                            style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Pallete.colorGrey2),
                            ),
                            onPressed: () { 
                              String accces_token=(BlocProvider.of<ProfileBloc>(context).state as UserProfileState).user!.accces_token!;
                              BlocProvider.of<BonoBloc>(context).add(GetBonosEvent(accessToken: accces_token));
                              Navigator.pushNamed(context, "/manualCafeteria");
                            },
                            child: const Text(
                              'Explorar',
                              style: TextStyle(
                                  color: Pallete.color1,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: 'Ubuntu'),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  const Text(
                    "Menú",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Ubuntu',    
                    ),
                  ),
                  Expanded(
                    child: CustomScrollView(
                      primary: false,
                      slivers: <Widget>[
                        SliverGrid.count(
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                          crossAxisCount: 3,
                          children: <Widget>[
                            TextButton.icon(
                              onPressed: () {
                                Navigator.pushNamed(context, "/bono-cafeteria");
                              },
                              icon: const Icon(Icons.book_online_rounded),
                              label: const Text("Bonos"),
                              style: const ButtonStyle(
                                alignment: Alignment.centerLeft,
                                iconSize: MaterialStatePropertyAll(30),
                                foregroundColor:
                                    MaterialStatePropertyAll(Pallete.color1),
                                textStyle: MaterialStatePropertyAll(TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600)),
                              ),
                            ),
                        
                            TextButton.icon(
                              onPressed: () {
                                Navigator.pushNamed(context, "/validar-bono");
                              },
                              icon: const Icon(Icons.checklist_rounded),
                              label: const Text("Validar Bonos"),
                              style: const ButtonStyle(
                                alignment: Alignment.center,
                                iconSize: MaterialStatePropertyAll(30),
                                textStyle: MaterialStatePropertyAll(TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600)),
                                foregroundColor:
                                    MaterialStatePropertyAll(Color.fromARGB(255, 83, 177, 117)),
                              ),
                            ),
                            TextButton.icon(
                              onPressed: () {
                                Navigator.pushNamed(context, "/validar-entrega");
                              },
                              icon: const Icon(Icons.delivery_dining_rounded),
                              label: const Text("Validar Entrega"),
                              style: const ButtonStyle(
                                alignment: Alignment.centerRight,
                                iconSize: MaterialStatePropertyAll(30),
                                textStyle: MaterialStatePropertyAll(TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600)),
                                foregroundColor:
                                    MaterialStatePropertyAll(Color.fromARGB(255, 83, 177, 117)),
                              ),
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
