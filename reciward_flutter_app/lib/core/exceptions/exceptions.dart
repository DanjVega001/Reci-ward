class Exception {
  final String errorMessage;

  Exception({required this.errorMessage});

  String getErrorMessage () => errorMessage;

}

class AuthException extends Exception {

  AuthException({required String errorMessage}) : super(errorMessage: errorMessage);

}

class GlobalException  extends Exception {

  GlobalException({required String errorMessage}) : super(errorMessage: errorMessage);

}

