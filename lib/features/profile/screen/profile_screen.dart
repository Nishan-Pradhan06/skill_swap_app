import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:skill_swap/core/widgets/custom_container.dart';
import 'package:skill_swap/core/widgets/custom_scrollable_padding.dart';
import '../../../core/widgets/custom_padding.dart';

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
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CustomContainer(
                        padding: EdgeInsetsGeometry.all(0),
                        clipRRectBorderRadius: BorderRadius.circular(0),
                        useIntrinsicHeight: true,
                        borderRadius: BorderRadius.circular(0),
                        child: Image.network(
                          'https://media.licdn.com/dms/image/v2/D4D16AQE8xmB0L5j7LA/profile-displaybackgroundimage-shrink_350_1400/profile-displaybackgroundimage-shrink_350_1400/0/1701923438567?e=1762992000&v=beta&t=7G4pAW71dyKnd8JDYopx_EFr-X8HO1cTMq3VPX31po8',
                          fit: BoxFit.cover,
                        ),
                      ),
                      CustomPadding(
                        horizontal: 12,
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            padding: EdgeInsets.zero,
                            margin: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.mode_edit_rounded, size: 14),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -100,
                        left: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// Profile Picture
                            CircleAvatar(
                              radius: 55,
                              backgroundColor: Theme.of(
                                context,
                              ).colorScheme.background,
                              child: const CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(
                                  'https://scontent.fbdp2-1.fna.fbcdn.net/v/t51.82787-15/515764552_18129396769445947_5870609763188483489_n.webp?stp=dst-jpg_tt6&_nc_cat=106&ccb=1-7&_nc_sid=127cfc&_nc_ohc=NS9Hwig0IJYQ7kNvwFq101n&_nc_oc=AdmtjSPbdYlvcRU5kWOkVUlOY85crmHdEyDeL9iM2Hyd3OepQbMDH1b-NYNW4L7TDVXzPHUlRtGb7W-H4TL1hSp9&_nc_zt=23&_nc_ht=scontent.fbdp2-1.fna&_nc_gid=z_tg5bRSC2vLyWbXwGU1sw&oh=00_AfcMEvMxi89cLkJoU7lEWDle9JjyxhhlO0Kj5XMlnhkaOw&oe=6903FEAD',
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Nishan Pradhan',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Flutter Developer | UI/UX Enthusiast',
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(color: Colors.grey[700]),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 20,
                            children: [
                              CustomPadding(
                                child: Text(
                                  'I\'m a Flutter developer and tech enthusiast passionate about creating fast, responsive, and elegant mobile apps. My journey began with hands-on practice and internships, and I continue learning new tools while sharing insights and engaging with the tech community on LinkedIn.',
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height: 10,
                                color: Theme.of(context).colorScheme.surface,
                              ),
                              Text(
                                'Skill & Expertise',
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),

                        // Portfolio Tab
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SingleChildScrollView(
                            child: Text(
                              'Portfolio projects will be displayed here soon. 🚀',
                            ),
                          ),
                        ),
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
