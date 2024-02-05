import 'package:get_it/get_it.dart';
import 'package:reciward_flutter_app/features/aprendiz/profile/data/datasources/profile_service.dart';
import 'package:reciward_flutter_app/features/aprendiz/profile/data/repositories/profile_repository_impl.dart';
import 'package:reciward_flutter_app/features/aprendiz/profile/domain/usecases/update_user_usecase.dart';

class SetupProfileDependencies {
  static void setupProfileDependencies(GetIt getIt) {
    // Service class
    getIt.registerLazySingleton<ProfileService>(() => ProfileService());
    // Repository class
    getIt.registerLazySingleton<ProfileRepositoryImpl>(
        () => ProfileRepositoryImpl(service: getIt<ProfileService>()));
    // Usecases
    getIt.registerLazySingleton<UpdatedUserUsecase>(() =>
        UpdatedUserUsecase(userRepository: getIt<ProfileRepositoryImpl>()));
  }
}
