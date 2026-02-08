import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:skill_swap/core/widgets/custom_padding.dart';
import 'package:skill_swap/features/profile/bloc/get_profile/get_profile_bloc.dart';
import 'package:skill_swap/features/profile/model/profile_model.dart';
import 'package:skill_swap/router/app_routes_names.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/name_splitter.dart';
import '../../../../core/utils/image_url_utils.dart';

class CustomProfileHeader extends StatelessWidget {
  final bool isLoading;
  final String? currentRole;

  const CustomProfileHeader({
    super.key,
    this.isLoading = false,
    this.currentRole,
  });

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
    return _buildProfileMethodConent(context, null, isLoading: isLoading);
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
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: ClipOval(
                      child: (data?.profileImage?.isNotEmpty ?? false)
                          ? CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: ImageUrlUtils.getImageUrl(
                                data!.profileImage!,
                              ),
                              errorWidget: (context, url, error) {
                                return Image.asset(
                                  'assets/images/default_profile.png',
                                  fit: BoxFit.cover,
                                );
                              },
                            )
                          : Image.asset(
                              'assets/images/default_profile.png',
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      NameSplitter.split(data?.fullName ?? ''),
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      currentRole ??
                          ((data?.roles.isNotEmpty ?? false)
                              ? data!.roles.first
                              : 'LEARNER'),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                context.pushNamed(AppRoutesName.dailyRewardScreenRoute);
              },
              child: Container(
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
                        (data?.points ?? 0).toString(),
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
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
            ),
          ],
        ),
      ),
    );
  }
}
