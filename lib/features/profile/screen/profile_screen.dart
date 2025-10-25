import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:skill_swap/core/widgets/custom_padding.dart';
import 'package:skill_swap/core/widgets/custom_scrollable_padding.dart';
import '../../../core/widgets/custom_appearance_mode_selector.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.exit_to_app_rounded),
          ),
        ],
      ),
      body: ScrollableRefreshablePadding(
        onRefresh: () async {},
        child: CustomPadding(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Skeletonizer(
                enabled: false,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'NISHAN PRADHAN',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    CircleAvatar(
                      minRadius: 45,
                      backgroundImage: NetworkImage(
                        'https://media.licdn.com/dms/image/v2/D4D03AQFnlTDji6hFzw/profile-displayphoto-shrink_400_400/profile-displayphoto-shrink_400_400/0/1703435442674?e=1762992000&v=beta&t=hPkwUus4-obeAXp7s1Wm_belXU6dQenEbQgJYpWgXFk',
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.person_2_rounded),
                title: const Text('Personal Details'),
                onTap: () {},
                splashColor: Colors.transparent,
                trailing: const Icon(Icons.arrow_right_rounded),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.security_rounded),
                title: const Text('Security & Privacy'),
                onTap: () {},
                splashColor: Colors.transparent,
                trailing: const Icon(Icons.arrow_right_rounded),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.help_outline_rounded),
                title: const Text('Support'),
                onTap: () {},
                splashColor: Colors.transparent,
                trailing: const Icon(Icons.arrow_right_rounded),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.balance_rounded),
                title: const Text('Legal'),
                onTap: () {},
                splashColor: Colors.transparent,
                trailing: const Icon(Icons.arrow_right_rounded),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.info_rounded),
                title: const Text('About Us'),
                onTap: () {},
                splashColor: Colors.transparent,
                trailing: const Icon(Icons.arrow_right_rounded),
              ),

              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.color_lens_rounded),
                title: const Text('App Appearance'),
                // trailing: const Icon(Icons.arrow_right_rounded),
              ),
              const SizedBox(height: 8),
              AppearanceModeSelector(),
            ],
          ),
        ),
      ),
    );
  }
}
