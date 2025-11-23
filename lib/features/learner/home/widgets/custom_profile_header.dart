import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:skill_swap/core/widgets/custom_padding.dart';
import 'package:skill_swap/features/profile/bloc/get_profile/get_profile_bloc.dart';
import 'package:skill_swap/features/profile/model/profile_model.dart';
import 'package:skill_swap/router/app_routes_names.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/custom_scrollable_padding.dart';

class CustomProfileHeader extends StatelessWidget {
  final bool isLoading;

  const CustomProfileHeader({super.key, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetProfileBloc, GetProfileState>(
      builder: (context, state) {
        return state.when(
          initial: () => _buildProfileSkeletonUI(context, isLoading: true),
          loading: () => _buildProfileSkeletonUI(context, isLoading: true),
          failure: (failure) => Center(
            child: Text(
              'Error: ${failure.message}',
              style: const TextStyle(color: Colors.red),
            ),
          ),
          loaded: (data) {
            return _buildProfileMethodConent(
              context,
              data,
              isLoading: isLoading,
            );
          },
        );
      },
    );
  }

  Widget _buildProfileSkeletonUI(
    BuildContext context, {
    required bool isLoading,
  }) {
    return ScrollableRefreshablePadding(
      onRefresh: () async {
        sl<GetProfileBloc>().add(GetProfileEvent.getProfile());
      },
      child: _buildProfileMethodConent(context, null, isLoading: isLoading),
    );
  }

  Widget _buildProfileMethodConent(
    BuildContext context,
    ProfileDataModel? data, {
    required bool isLoading,
  }) {
    return Skeletonizer(
      enabled: isLoading,
      child: CustomPadding(
        vertical: 0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                GestureDetector(
                  onTap: () {
                    context.pushNamed(AppRoutesName.profileScreenRoute);
                  },
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(data?.profileImage ?? ''),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data?.fullName ?? '',
                      style: TextTheme.of(context).bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text('Learner', style: TextTheme.of(context).bodySmall),
                  ],
                ),
              ],
            ),
            Container(
              height: 40,
              width: 65,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Row(
                  spacing: 4,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '120',
                      style: TextTheme.of(context).bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: AppTheme.backgroundLight,
                      ),
                    ),
                    Image.asset('assets/images/coin.png', height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
