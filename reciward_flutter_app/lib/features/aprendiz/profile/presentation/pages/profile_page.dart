import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reciward_flutter_app/core/constants/pallete_colors.dart';
import 'package:reciward_flutter_app/core/widgets/snackbar_reciward.dart';
import 'package:reciward_flutter_app/features/aprendiz/profile/domain/entities/update_user_data_dto.dart';
import 'package:reciward_flutter_app/features/aprendiz/profile/presentation/bloc/profile_bloc.dart';
import 'package:reciward_flutter_app/features/aprendiz/profile/presentation/widgets/modal_change_password.dart';
import 'package:reciward_flutter_app/features/aprendiz/profile/presentation/widgets/update_user_form_field.dart';
import 'package:reciward_flutter_app/features/auth/domain/entities/aprendiz_entity.dart';
import 'package:reciward_flutter_app/features/auth/domain/entities/user_entity.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController apellidoController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool editar = true;
  bool updatePassword = false;

  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  String? _imagePath;

  Future getImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  void onChangePassword(String oldPassword, String newPassword,
      String confirmPassword, bool updatePassword) {
    if (oldPassword.trim().isEmpty ||
        newPassword.trim().isEmpty ||
        confirmPassword.trim().isEmpty) {
      return;
    }
    passwordController.text = newPassword;
    oldPasswordController.text = oldPassword;
    confirmPasswordController.text = confirmPassword;
    this.updatePassword = updatePassword;

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Perfil del usuario",
          style: TextStyle(fontFamily: 'Ubuntu'),
        ),
        centerTitle: true,
      ),
      body: Container(
        /*decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/your_background_image.png"),
            fit: BoxFit.cover,
          ),
        ),*/
        child: BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is UpdateUserSuccess) {
              UserEntity user = UserEntity(
                  email: state.userData.email!,
                  accces_token: state.accessToken,
                  name: state.userData.name,
                  aprendizEntity: AprendizEntity(
                      apellido: state.userData.apellido,
                      ficha: null,
                      avatar: state.userData.avatar,
                      descripcionPerfil: state.userData.descripcionPerfil));
              BlocProvider.of<ProfileBloc>(context)
                  .add(RecoverUserProfile(user: user));
              Navigator.pop(context);
              ScaffoldMessenger.of(context)
                  .showSnackBar(MySnackBar.showSnackBar(state.message, false));
            }
            if (state is UpdateUserFailed) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(MySnackBar.showSnackBar(state.error, false));
              BlocProvider.of<ProfileBloc>(context)
                  .add(RecoverUserProfile(user: state.user!));
            }
          },
          builder: (context, state) {
            return BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is UserProfileState) {
                  UserEntity user = state.user!;
                  emailController.text = user.email;
                  nameController.text = user.name!;
                  apellidoController.text = user.aprendizEntity!.apellido!;
                  descripcionController.text =
                      user.aprendizEntity!.descripcionPerfil ??
                          "Sin descripción";
                  _imagePath = user.aprendizEntity?.avatar;
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 80,
                                backgroundImage: _image == null
                                    ? _imagePath == null
                                        ? const AssetImage(
                                            'assets/manual_images/arrrr.png')
                                        : FileImage(File(_imagePath!))
                                            as ImageProvider<Object>
                                    : FileImage(File(_image!.path)),
                              ),
                              IconButton(
                                onPressed: editar ? null : getImage,
                                icon: const Icon(Icons.add_a_photo),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Divider(
                            height: 10,
                            color: Colors.black,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextButton.icon(
                            style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Pallete.color1),
                            ),
                            onPressed: () {
                              setState(() {
                                editar = !editar;
                              });
                            },
                            label: const Text(
                              "Editar datos",
                              style: TextStyle(
                                  color: Pallete.colorWhite,
                                  fontFamily: 'Ubuntu'),
                            ),
                            icon: const Icon(
                              Icons.edit,
                              color: Pallete.colorWhite,
                            ),
                          ),
                          UpdateUserFormField(
                            controller: emailController,
                            label: "Email",
                            type: TextInputType.emailAddress,
                            editar: editar,
                          ),
                          UpdateUserFormField(
                            controller: nameController,
                            label: "Nombre",
                            type: TextInputType.text,
                            editar: editar,
                          ),
                          UpdateUserFormField(
                            controller: apellidoController,
                            label: "Apellido",
                            type: TextInputType.text,
                            editar: editar,
                          ),
                          UpdateUserFormField(
                            controller: descripcionController,
                            label: "Descripión",
                            type: TextInputType.multiline,
                            editar: editar,
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            child: TextButton(
                              style: const ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Pallete.color1)),
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return ModalChangePassword(
                                      onChangePassword: onChangePassword,
                                      editar: editar,
                                    );
                                  },
                                );
                              },
                              child: const Text(
                                "Cambiar contraseña",
                                style: TextStyle(
                                    color: Pallete.colorWhite,
                                    fontFamily: 'Ubuntu'),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: TextButton.icon(
                              style: const ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Pallete.color1)),
                              onPressed: () {
                                BlocProvider.of<ProfileBloc>(context).add(
                                    UpdatedUser(
                                        userData: UpdatedUserData(
                                            apellido:
                                                apellidoController.text.trim(),
                                            descripcionPerfil:
                                                descripcionController.text
                                                    .trim(),
                                            email: emailController.text.trim(),
                                            name: nameController.text.trim(),
                                            oldPassword: oldPasswordController
                                                    .text
                                                    .trim()
                                                    .isEmpty
                                                ? null
                                                : oldPasswordController.text
                                                    .trim(),
                                            password: passwordController.text
                                                    .trim()
                                                    .isEmpty
                                                ? null
                                                : passwordController.text
                                                    .trim(),
                                            avatar: _image?.path ?? _imagePath),
                                        confirmPassword:
                                            confirmPasswordController.text
                                                .trim(),
                                        updatePassword: updatePassword,
                                        accessToken: user.accces_token!,
                                        user: user));
                              },
                              label: const Text(
                                "Guardar cambios",
                                style: TextStyle(
                                    color: Pallete.colorWhite,
                                    fontFamily: 'Ubuntu'),
                              ),
                              icon: const Icon(
                                Icons.save,
                                color: Pallete.colorWhite,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return Text("Problemas");
              },
            );
          },
        ),
      ),
    );
  }
}
