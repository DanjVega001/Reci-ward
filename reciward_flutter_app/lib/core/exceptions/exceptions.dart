class Exception {
  final String errorMessage;

  Exception({required this.errorMessage});

  String getErrorMessage () => errorMessage;

}

class AuthException extends Exception {

  AuthException({required super.errorMessage});

}

class GlobalException  extends Exception {

  GlobalException({required super.errorMessage});

}

