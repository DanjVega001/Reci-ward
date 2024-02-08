import 'package:get_it/get_it.dart';
import 'package:reciward_flutter_app/features/aprendiz/tips/data/datasources/tip_service.dart';
import 'package:reciward_flutter_app/features/aprendiz/tips/data/repositories/tip_repository_impl.dart';
import 'package:reciward_flutter_app/features/aprendiz/tips/domain/usecase/get_tips_usecase.dart';

class SetupTipDependencies {
  static void setupTipDependencies(GetIt getIt) {
    //Service class
    getIt.registerLazySingleton<TipService>(() => TipService());
    //Implentatin reposotiry
    getIt.registerLazySingleton<TipRepositoryImpl>(
        () => TipRepositoryImpl(service: getIt<TipService>()));
    //Usecases
    getIt.registerLazySingleton<GetTipsUsecase>(
        () => GetTipsUsecase(tipRepository: getIt<TipRepositoryImpl>()));
  }
}
