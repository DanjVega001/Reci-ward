import 'package:get_it/get_it.dart';
import 'package:reciward_flutter_app/features/aprendiz/puntos/data/datasources/punto_service.dart';
import 'package:reciward_flutter_app/features/aprendiz/puntos/data/repository/punto_repository_impl.dart';
import 'package:reciward_flutter_app/features/aprendiz/puntos/domain/usecases/get_puntos_usecase.dart';

class SetupPuntosDependencies {

  static void setupPuntosDependencies(GetIt getIt) {
    // Service class
    getIt.registerLazySingleton<PuntoService>(() => PuntoService());
    // Repository class
    getIt.registerLazySingleton<PuntoRepositoryImpl>(
        () => PuntoRepositoryImpl(service: getIt<PuntoService>()));
    // Usecases
    getIt.registerLazySingleton<GetPuntosUsecase>(
        () => GetPuntosUsecase(repository: getIt<PuntoRepositoryImpl>()));
  }
}