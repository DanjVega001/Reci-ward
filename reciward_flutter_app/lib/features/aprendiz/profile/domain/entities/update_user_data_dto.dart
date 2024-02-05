class UpdatedUserData {
  final String? name;
  final String? email;
  final String? password;
  final String? oldPassword;
  final String? descripcionPerfil;
  final String? avatar;
  final String? apellido;

  UpdatedUserData(
      {required this.name,
      required this.email,
      required this.password,
      required this.descripcionPerfil,
      required this.avatar,
      required this.apellido,
      required this.oldPassword,
      });

  Map<String, dynamic> toJson(){
    return {
      "name" : name,
      "correo" : email,
      "contrasena" : password,
      "contrasenaAntigua": oldPassword,
      "avatar" : avatar,
      "descripcionPerfil" : descripcionPerfil,
      "apellido" : apellido,
    };
  }
}
