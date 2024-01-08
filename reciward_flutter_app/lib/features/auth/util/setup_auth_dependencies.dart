import 'package:get_it/get_it.dart';
import 'package:reciward_flutter_app/features/auth/data/datasources/auth_service.dart';
import 'package:reciward_flutter_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:reciward_flutter_app/features/auth/domain/usecases/get_fichas_usecase.dart';
import 'package:reciward_flutter_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:reciward_flutter_app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:reciward_flutter_app/features/auth/domain/usecases/signup_usecase.dart';

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
  }
}
