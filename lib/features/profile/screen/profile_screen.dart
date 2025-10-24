import 'package:flutter/material.dart';
import 'package:skill_swap/core/widgets/custom_padding.dart';
import '../../../core/widgets/custom_scrollable_padding.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.exit_to_app_rounded)),
        ],
      ),
      body: ScrollableRefreshablePadding(
        onRefresh: () async {},
        child: CustomPadding(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nishan Pradhan',
                style: TextTheme.of(context).headlineSmall,
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.person_2_rounded),
                title: Text('Personal Details'),
                onTap: () {},
                splashColor: Colors.transparent,
                trailing: Icon(Icons.arrow_right_rounded),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.color_lens_rounded),
                title: Text('App Appearance'),
                trailing: Icon(Icons.arrow_right_rounded),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
