import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:skill_swap/core/di/dependency_injection.dart';
import 'package:skill_swap/core/widgets/custom_scrollable_padding.dart';
import 'package:skill_swap/features/profile/bloc/get_profile/get_profile_bloc.dart';
import 'package:skill_swap/features/profile/model/profile_model.dart';
import 'package:skill_swap/features/profile/widgets/custom_user_profile_header.dart';
import 'tab_bar_view/about_tab_bar_view.dart';
import 'tab_bar_view/portfolio_tab_bar_view.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      animationDuration: Duration(milliseconds: 800),
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          scrolledUnderElevation: 0,
          elevation: 0,
          centerTitle: false,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
          ],
        ),
        body: BlocBuilder<GetProfileBloc, GetProfileState>(
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
                    sl<GetProfileBloc>().add(GetProfileEvent.getProfile());
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
      onRefresh: () async {
        sl<GetProfileBloc>().add(GetProfileEvent.getProfile());
      },
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
            SizedBox(height: 100),
            // TabBar
            TabBar(
              isScrollable: true,
              splashBorderRadius: BorderRadius.all(Radius.circular(8)),
              tabAlignment: TabAlignment.start,
              padding: EdgeInsets.symmetric(horizontal: 10),
              labelPadding: EdgeInsets.symmetric(horizontal: 15),
              dividerColor: Theme.of(context).colorScheme.surface,
              labelColor: Theme.of(context).colorScheme.primary,
              unselectedLabelColor: Colors.grey,
              tabs: [
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
                      workExperiences:data?.workingExpriences?? [

                      ],
                    ),
                  ),
                  // Portfolio Tab
                  PortfolioTabBarView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
