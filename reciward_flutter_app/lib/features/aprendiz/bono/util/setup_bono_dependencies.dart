import 'package:get_it/get_it.dart';
import 'package:reciward_flutter_app/features/aprendiz/bono/data/dataresources/bono_service.dart';
import 'package:reciward_flutter_app/features/aprendiz/bono/data/repositories/bono_repository_impl.dart';
import 'package:reciward_flutter_app/features/aprendiz/bono/domain/usecases/get_bono_cafeteria_usecase.dart';
import 'package:reciward_flutter_app/features/aprendiz/bono/domain/usecases/get_bonos_historial.dart';
import 'package:reciward_flutter_app/features/aprendiz/bono/domain/usecases/get_bonos_usecase.dart';
import 'package:reciward_flutter_app/features/aprendiz/bono/domain/usecases/save_bono_aprendiz_usecase.dart';
import 'package:reciward_flutter_app/features/aprendiz/bono/domain/usecases/update_bono_cafeteria_usecase.dart';
import 'package:reciward_flutter_app/features/aprendiz/bono/domain/usecases/validar_bono_usecase.dart';

class SetupBonoDependencies {
  static void setupBonoDependencies(GetIt getIt){
    // Service class
    getIt.registerLazySingleton<BonoService>(() => BonoService());
    // Repository class
    getIt.registerLazySingleton<BonoRepositoryImpl>(
        () => BonoRepositoryImpl(service: getIt<BonoService>()));
    // Usecases
    getIt.registerLazySingleton<GetBonosUsecase>(
        () => GetBonosUsecase(repository: getIt<BonoRepositoryImpl>()));
    getIt.registerLazySingleton<SaveBonoAprendizUsecase>(
        () => SaveBonoAprendizUsecase(repository: getIt<BonoRepositoryImpl>()));
    getIt.registerLazySingleton<GetBonosHistorialUsecase>(
        () => GetBonosHistorialUsecase(repository: getIt<BonoRepositoryImpl>()));
    getIt.registerLazySingleton<GetBonoCafeteriaUsecase>(
        () => GetBonoCafeteriaUsecase(repository: getIt<BonoRepositoryImpl>()));
    getIt.registerLazySingleton<ValidarBonoUsecase>(
        () => ValidarBonoUsecase(repository: getIt<BonoRepositoryImpl>()));
    getIt.registerLazySingleton<UpdateBonoCafeteriaUsecase>(
        () => UpdateBonoCafeteriaUsecase(repository: getIt<BonoRepositoryImpl>()));
  }
}