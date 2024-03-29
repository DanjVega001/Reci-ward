import 'package:get_it/get_it.dart';
import 'package:reciward_flutter_app/features/aprendiz/entrega/data/dataresources/entrega_service.dart';
import 'package:reciward_flutter_app/features/aprendiz/entrega/data/repositories/entrega_repository_impl.dart';

import 'package:reciward_flutter_app/features/aprendiz/entrega/domain/usecases/historial_entrega_usecase.dart';

import 'package:reciward_flutter_app/features/aprendiz/entrega/domain/usecases/get_entrega_cafeteria_usecase.dart';

import 'package:reciward_flutter_app/features/aprendiz/entrega/domain/usecases/save_entrega_usecase.dart';
import 'package:reciward_flutter_app/features/aprendiz/entrega/domain/usecases/validar_entrega_usecase.dart';

class SetupEntregaDependencies {
  static void setupEntregaDependencies(GetIt getIt) {
    // Service class
    getIt.registerLazySingleton<EntregaService>(() => EntregaService());
    // Repository class
    getIt.registerLazySingleton<EntregaRepositoryImpl>(
        () => EntregaRepositoryImpl(service: getIt<EntregaService>()));
    // Usecases
    getIt.registerLazySingleton<SaveEntregaUsecase>(
        () => SaveEntregaUsecase(repository: getIt<EntregaRepositoryImpl>()));


    getIt.registerLazySingleton<HistorialEntregaUsecase>(() =>
        HistorialEntregaUsecase(repository: getIt<EntregaRepositoryImpl>()));

    getIt.registerLazySingleton<GetEntregaCafeteriaUsecase>(() =>
        GetEntregaCafeteriaUsecase(repository: getIt<EntregaRepositoryImpl>()));



    getIt.registerLazySingleton<ValidarEntregaUsecase>(
        () => ValidarEntregaUsecase(repository: getIt<EntregaRepositoryImpl>()));




  }
}
