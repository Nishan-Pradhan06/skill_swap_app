import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:skill_swap/core/widgets/custom_scrollable_padding.dart';
import 'package:skill_swap/features/profile/bloc/get_public_profile/get_public_profile_bloc.dart';
import 'package:skill_swap/features/profile/model/profile_model.dart';
import 'package:skill_swap/features/profile/widgets/custom_user_profile_header.dart';
import 'package:skill_swap/features/profile/screen/tab_bar_view/about_tab_bar_view.dart';
import 'package:skill_swap/features/profile/screen/tab_bar_view/portfolio_tab_bar_view.dart';
import '../../../core/widgets/custom_toast.dart';

class PublicProfileScreen extends StatelessWidget {
  const PublicProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      animationDuration: const Duration(milliseconds: 800),
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Public Profile'),
          scrolledUnderElevation: 0,
          elevation: 0,
          centerTitle: false,
        ),
        body: BlocBuilder<GetPublicProfileBloc, GetPublicProfileState>(
          builder: (context, state) {
            return state.when(
              initial: () => _buildSkeletonUI(context, isLoading: true),
              loading: () => _buildSkeletonUI(context, isLoading: true),
              failure: (failure) => Center(
                child: Text(
                  'Error: ${failure.message}',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
              loaded: (data) {
                return ScrollableRefreshablePadding(
                  onRefresh: () async {
                    context.read<GetPublicProfileBloc>().add(
                      GetPublicProfileEvent.getProfile(data.id!),
                    );
                    CustomToast.showSuccess("Profile refreshed");
                  },
                  child: _buildProfileContent(context, data, isLoading: false),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildSkeletonUI(BuildContext context, {required bool isLoading}) {
    return ScrollableRefreshablePadding(
      onRefresh: () async {},
      child: _buildProfileContent(context, null, isLoading: isLoading),
    );
  }

  Widget _buildProfileContent(
    BuildContext context,
    ProfileDataModel? data, {
    required bool isLoading,
  }) {
    return Skeletonizer(
      enabled: isLoading,
      child: SizedBox(
        height: MediaQuery.of(context).size.height - kToolbarHeight,
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomUserProfileHeader(
              profileImageUrl: data?.profileImage ?? '',
              coverImageUrl: data?.bannerImage ?? '',
              userName: data?.fullName ?? '',
              userTitle: data?.profileTitle ?? '',
            ),
            const SizedBox(height: 100),
            // TabBar
            TabBar(
              isScrollable: true,
              splashBorderRadius: const BorderRadius.all(Radius.circular(8)),
              tabAlignment: TabAlignment.start,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              labelPadding: const EdgeInsets.symmetric(horizontal: 15),
              dividerColor: Theme.of(context).colorScheme.surface,
              labelColor: Theme.of(context).colorScheme.primary,
              unselectedLabelColor: Colors.grey,
              tabs: const [
                Tab(text: 'About'),
                Tab(text: 'Portfolio'),
              ],
            ),
            // TabBarView
            Expanded(
              child: TabBarView(
                children: [
                  // About Tab
                  SingleChildScrollView(
                    child: AboutTabBarView(
                      availableSkills: data?.skillYouOffer ?? [],
                      certifications: data?.certifications ?? [],
                      aboutBio: data?.bio ?? 'No Bio',
                      workExperiences: data?.workingExpriences ?? [],
                    ),
                  ),
                  // Portfolio Tab
                  const PortfolioTabBarView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
