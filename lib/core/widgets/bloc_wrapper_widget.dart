import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/device_register_push_notification/bloc/device_register/device_register_bloc.dart';
import '../../features/notifications/bloc/delete_notifications/delete_notification_bloc.dart';
import '../../features/notifications/bloc/get_notification_count/get_notification_count_bloc.dart';
import '../../features/notifications/bloc/read_notifications/read_notifications_bloc.dart';

import '../../features/auth/bloc/bloc/sign_out_bloc.dart';
import '../../features/auth/bloc/sign_in/sign_in_bloc.dart';
import '../../features/auth/bloc/sign_up/sign_up_bloc.dart';
import '../../features/notifications/bloc/get_notifications/get_notification_bloc.dart';
import '../../features/profile/bloc/get_profile/get_profile_bloc.dart';
import '../../features/profile/bloc/profile_setup/profile_setup_bloc.dart';
import '../../features/profile/cubit/theme_appearance_cubit.dart';
import '../../features/shared/on_boarding/cubit/on_boarding_cubit.dart';
import '../di/dependency_injection.dart';
import '../services/once_cache_service.dart';

class BlocWrapperWidget extends StatelessWidget {
  final Widget child;
  const BlocWrapperWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<OnBoardingCubit>()),
        BlocProvider(
          create: (_) =>
              ThemeAppearanceCubit(onceCacheService: sl<OnceCacheService>()),
        ),
        BlocProvider(create: (_) => sl<SignInBloc>()),
        BlocProvider(create: (_) => sl<SignUpBloc>()),
        BlocProvider(create: (_) => sl<ProfileSetupBloc>()),
        BlocProvider(create: (_) => sl<GetProfileBloc>()),
        BlocProvider(create: (_) => sl<SignOutBloc>()),
        BlocProvider(create: (_) => sl<GetNotificationBloc>()),
        BlocProvider(create: (_) => sl<DeviceRegisterBloc>()),
        BlocProvider(create: (_) => sl<ReadNotificationsBloc>()),
        BlocProvider(create: (_) => sl<DeleteNotificationBloc>()),
        BlocProvider(create: (_) => sl<GetNotificationCountBloc>()),
      ],
      child: child,
    );
  }
}
