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
                        'https://media.licdn.com/dms/image/v2/D4D16AQE8xmB0L5j7LA/profile-displaybackgroundimage-shrink_350_1400/profile-displaybackgroundimage-shrink_350_1400/0/1701923438567?e=1762992000&v=beta&t=7G4pAW71dyKnd8JDYopx_EFr-X8HO1cTMq3VPX31po8',
                    coverImageUrl:
                        'https://scontent.fbdp2-1.fna.fbcdn.net/v/t39.30808-6/357720692_1633633700482790_3750526617895490452_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=6ee11a&_nc_eui2=AeHWAq9_r27J3XQrlPQ-b_JUEyGQJfikjFsTIZAl-KSMWwbH_DyL0jlSK7OS8xPX9HAgOLME2YwNnxveoY-R8waL&_nc_ohc=jTaUJfge-bcQ7kNvwEImS61&_nc_oc=Adk0WAWO0epSZa-eY1J9Jb_G4hcLn0I2jvTO7trHCqUtD0x4qZpIrSOHg0pclDc_C7JdLjnVtaCT40ll49cajZha&_nc_zt=23&_nc_ht=scontent.fbdp2-1.fna&_nc_gid=SiEn8qgUaybLk1TnaPlm7A&oh=00_AfcnfwUHNF1WmrTukeM4nGSZHGmqFQLP9xiUNKfpgpuQRg&oe=690BE537',
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
