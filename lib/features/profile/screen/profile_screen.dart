import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:skill_swap/core/widgets/custom_scrollable_padding.dart';
import 'package:skill_swap/features/profile/widgets/custom_user_profile_header.dart';
import 'tab_bar_view/about_tab_bar_view.dart';
import 'tab_bar_view/portfolio_tab_bar_view.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> availableSkills = [
      'Programming',
      'Design',
      'Writing',
      'Marketing',
      'Photography',
      'Video Editing',
      'Music',
      'Teaching',
      'Cooking',
      'Gardening',
    ];

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
        body: ScrollableRefreshablePadding(
          onRefresh: () async {},
          child: Skeletonizer(
            enabled: false,
            child: SizedBox(
              // Give finite height to Column
              height: MediaQuery.of(context).size.height - kToolbarHeight,
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomUserProfileHeader(
                    profileImageUrl:
                        'https://media.licdn.com/dms/image/v2/D4D03AQFnlTDji6hFzw/profile-displayphoto-shrink_800_800/profile-displayphoto-shrink_800_800/0/1703435442674?e=1765411200&v=beta&t=9KAhsZ9MVLXNeH8CZp-79dZdxjTnqZsY69ljoiecrJI',
                    coverImageUrl:
                        'https://media.licdn.com/dms/image/v2/D4D16AQE8xmB0L5j7LA/profile-displaybackgroundimage-shrink_350_1400/profile-displaybackgroundimage-shrink_350_1400/0/1701923438567?e=1765411200&v=beta&t=BHc4-G5G5RYpZhM0asf6zry-v68eWwr2TbIMMOtSAb8',
                    userName: 'Nishan Pradhan',
                    userTitle: 'Flutter Developer | UI/UX Enthusiast',
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
                    // Expanded works now because Column has finite height
                    child: TabBarView(
                      children: [
                        // About Tab
                        SingleChildScrollView(
                          child: AboutTabBarView(
                            availableSkills: availableSkills,
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
          ),
        ),
      ),
    );
  }
}
