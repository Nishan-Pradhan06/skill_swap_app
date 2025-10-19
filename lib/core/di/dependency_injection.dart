import 'package:get_it/get_it.dart';

import '../../features/shared/on_boarding/cubit/on_boarding_cubit.dart';
import '../services/once_cache_service.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  //###---------------GLOBAL BLOC--------------###
  sl.registerLazySingleton(() => OnceCacheService());
  sl.registerLazySingleton(() => OnBoardingCubit(onceService: sl()));

  //###---------------BLOC---------------------###

  //###---------------CUBIT--------------------###

  //###---------------REPOSITORY---------------###
}
