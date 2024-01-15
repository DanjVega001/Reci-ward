import 'package:get_it/get_it.dart';
import 'package:reciward_flutter_app/features/auth/data/datasources/auth_service.dart';
import 'package:reciward_flutter_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:reciward_flutter_app/features/auth/domain/usecases/get_fichas_usecase.dart';
import 'package:reciward_flutter_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:reciward_flutter_app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:reciward_flutter_app/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:reciward_flutter_app/features/auth/domain/usecases/send_mail_reset_password_usecase.dart';
import 'package:reciward_flutter_app/features/auth/domain/usecases/signup_usecase.dart';
import 'package:reciward_flutter_app/features/auth/domain/usecases/update_user_usecase.dart';

class SetupAuthDependencies {
  static void setupAuthDependencies(GetIt getIt) {
    // Service class
    getIt.registerLazySingleton<AuthService>(() => AuthService());
    // Repository class
    getIt.registerLazySingleton<AuthRepositoryImpl>(
        () => AuthRepositoryImpl(service: getIt<AuthService>()));
    // Usecases
    getIt.registerLazySingleton<LoginUseCase>(
        () => LoginUseCase(userRepository: getIt<AuthRepositoryImpl>()));
    getIt.registerLazySingleton<LogoutUseCase>(
        () => LogoutUseCase(userRepository: getIt<AuthRepositoryImpl>()));
    getIt.registerLazySingleton<SignupUseCase>(
        () => SignupUseCase(userRepository: getIt<AuthRepositoryImpl>()));
    getIt.registerLazySingleton<GetFichasUseCase>(
      () => GetFichasUseCase(userRepository: getIt<AuthRepositoryImpl>()));
    getIt.registerLazySingleton<UpdatedUserUsecase>(
      () => UpdatedUserUsecase(userRepository: getIt<AuthRepositoryImpl>()));
    getIt.registerLazySingleton<SendMailResetPasswordUseCase>(
      () => SendMailResetPasswordUseCase(userRepository: getIt<AuthRepositoryImpl>()));
    getIt.registerLazySingleton<ResetPasswordUsecase>(
      () => ResetPasswordUsecase(userRepository: getIt<AuthRepositoryImpl>()));
  }
}
