import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:retry/retry.dart';
import 'package:skill_swap/features/auth/bloc/bloc/sign_out_bloc.dart';
import 'package:skill_swap/features/auth/bloc/sign_in/sign_in_bloc.dart';
import 'package:skill_swap/features/auth/bloc/sign_up/sign_up_bloc.dart';
import 'package:skill_swap/features/device_register_push_notification/bloc/device_register/device_register_bloc.dart';
import 'package:skill_swap/features/device_register_push_notification/repository/device_register_repository.dart';
import 'package:skill_swap/features/notifications/bloc/delete_notifications/delete_notification_bloc.dart';
import 'package:skill_swap/features/notifications/bloc/get_notification_count/get_notification_count_bloc.dart';
import 'package:skill_swap/features/notifications/bloc/get_notifications/get_notification_bloc.dart';
import 'package:skill_swap/features/notifications/bloc/read_notifications/read_notifications_bloc.dart';
import 'package:skill_swap/features/notifications/repository/notification_repository.dart';
import 'package:skill_swap/features/profile/bloc/get_profile/get_profile_bloc.dart';
import 'package:skill_swap/features/profile/bloc/profile_completion_check/profile_completion_check_bloc.dart';
import 'package:skill_swap/features/profile/bloc/profile_setup/profile_setup_bloc.dart';
import 'package:skill_swap/features/profile/bloc/switch_role/switch_role_bloc.dart';
import 'package:skill_swap/features/profile/repository/profile_repository.dart';
import 'package:skill_swap/features/reward/blocs/reward_bloc.dart';
import 'package:skill_swap/features/reward/repository/reward_repository.dart';
import 'package:skill_swap/features/skill_swap/blocs/availability_bloc.dart';
import 'package:skill_swap/features/skill_swap/blocs/booking_bloc.dart';
import 'package:skill_swap/features/skill_swap/blocs/get_skill_swap_posts_bloc.dart';
import 'package:skill_swap/features/skill_swap/blocs/manage_skill_post_bloc.dart';
import 'package:skill_swap/features/skill_swap/blocs/get_mentor_posts_bloc.dart';
import 'package:skill_swap/features/skill_swap/blocs/get_categories_bloc.dart';
import 'package:skill_swap/features/skill_swap/blocs/get_sessions_bloc.dart';
import 'package:skill_swap/features/skill_swap/blocs/handle_session_action_bloc.dart';
import 'package:skill_swap/features/skill_swap/repositories/skill_swap_repository.dart';

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
  sl.registerLazySingleton(() => ReadNotificationsBloc(repo: sl()));
  sl.registerLazySingleton(() => DeleteNotificationBloc(repo: sl()));
  sl.registerLazySingleton(() => GetNotificationCountBloc(repo: sl()));
  sl.registerLazySingleton(() => DeviceRegisterBloc(repo: sl()));
  sl.registerLazySingleton(() => SwitchRoleBloc(repo: sl()));

  //###---------------BLOC---------------------###

  sl.registerLazySingleton(() => GetProfileBloc(repo: sl()));
  sl.registerLazySingleton(() => ProfileSetupBloc(repo: sl()));
  sl.registerLazySingleton(() => ProfileCompletionCheckBloc(repo: sl()));

  //###---------------CUBIT--------------------###

  //###---------------REPOSITORY---------------###
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(apiService: sl()),
  );
  sl.registerLazySingleton<RewardRepository>(
    () => RewardRepositoryImpl(apiService: sl()),
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
  sl.registerLazySingleton<SkillSwapRepository>(
    () => SkillSwapRepositoryImpl(apiService: sl()),
  );

  //###---------------FEATURE BLOCS---------------------###
  sl.registerFactory(() => AvailabilityBloc(repository: sl()));
  sl.registerFactory(() => BookingBloc(repository: sl()));
  sl.registerFactory(() => GetSkillSwapPostsBloc(repository: sl()));
  sl.registerFactory(() => ManageSkillPostBloc(repository: sl()));
  sl.registerFactory(() => GetMentorPostsBloc(repository: sl()));
  sl.registerFactory(() => GetCategoriesBloc(repository: sl()));
  sl.registerFactory(() => GetSessionsBloc(repository: sl()));
  sl.registerFactory(() => HandleSessionActionBloc(repository: sl()));
  sl.registerFactory(() => RewardBloc(repository: sl()));

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
