import 'package:get_it/get_it.dart';
import 'package:reciward_flutter_app/features/material/data/datasources/material_service.dart';
import 'package:reciward_flutter_app/features/material/data/repositories/material_repository_impl.dart';
import 'package:reciward_flutter_app/features/material/domain/usecases/get_materiales_usecase.dart';

class SetupMaterialDependencies {
  static void setupMaterialDependencies(GetIt getIt) {
    // Service class
    getIt.registerLazySingleton<MaterialService>(() => MaterialService());
    // Repository class
    getIt.registerLazySingleton<MaterialRepositoryImpl>(
        () => MaterialRepositoryImpl(service: getIt<MaterialService>()));
    // Usecases
    getIt.registerLazySingleton<GetMaterialesUsecase>(
        () => GetMaterialesUsecase(materialRepository: getIt<MaterialRepositoryImpl>()));
  }
}
