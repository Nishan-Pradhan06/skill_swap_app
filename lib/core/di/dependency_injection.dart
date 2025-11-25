import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:retry/retry.dart';
import 'package:skill_swap/features/auth/bloc/bloc/sign_out_bloc.dart';
import 'package:skill_swap/features/auth/bloc/sign_in/sign_in_bloc.dart';
import 'package:skill_swap/features/auth/bloc/sign_up/sign_up_bloc.dart';
import 'package:skill_swap/features/device_register_push_notification/bloc/device_register/device_register_bloc.dart';
import 'package:skill_swap/features/device_register_push_notification/repository/device_register_repository.dart';
import 'package:skill_swap/features/notifications/bloc/get_notifications/get_notification_bloc.dart';
import 'package:skill_swap/features/notifications/repository/notification_repository.dart';
import 'package:skill_swap/features/profile/bloc/get_profile/get_profile_bloc.dart';
import 'package:skill_swap/features/profile/bloc/profile_setup/profile_setup_bloc.dart';
import 'package:skill_swap/features/profile/repository/profile_repository.dart';

import '../../features/auth/repository/auth_repository.dart';
import '../../features/shared/on_boarding/cubit/on_boarding_cubit.dart';
import '../network/api_services.dart';
import '../network/dio_client.dart';
import '../services/once_cache_service.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  //###---------------GLOBAL BLOC--------------###
  sl.registerLazySingleton(() => OnceCacheService());
  sl.registerLazySingleton(() => OnBoardingCubit(onceService: sl()));
  sl.registerLazySingleton(() => SignInBloc(repo: sl()));
  sl.registerLazySingleton(() => SignUpBloc(repo: sl()));
  sl.registerLazySingleton(() => SignOutBloc(repo: sl()));
  sl.registerLazySingleton(() => GetNotificationBloc(repo: sl()));
  sl.registerLazySingleton(() => DeviceRegisterBloc(repo: sl()));

  //###---------------BLOC---------------------###

  sl.registerLazySingleton(() => GetProfileBloc(repo: sl()));
  sl.registerLazySingleton(() => ProfileSetupBloc(repo: sl()));

  //###---------------CUBIT--------------------###

  //###---------------REPOSITORY---------------###
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(apiService: sl()),
  );
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(apiService: sl()),
  );
  sl.registerLazySingleton<NotificationRepository>(
    () => NotificationRepositoryImpl(apiService: sl()),
  );
  sl.registerLazySingleton<DeviceRegisterForPushNotificationRepository>(
    () => DeviceRegisterForPushNotificationRepositoryImpl(apiService: sl()),
  );

  //###---------------EXTERNAL REPOSITORY SERVICES---------------###

  sl.registerLazySingleton<ApiService>(
    () => ApiService(sl<Dio>(), sl<RetryOptions>()),
  );
  sl.registerLazySingleton<RetryOptions>(
    () => const RetryOptions(maxAttempts: 3),
  );
  sl.registerLazySingleton<DioClient>(() => DioClient());
  sl.registerLazySingleton<Dio>(() => sl<DioClient>().dio);
}
