import 'package:flutter/material.dart';

import '../../../core/widgets/custom_padding.dart';
import '../../learner/home/widgets/custom_profile_header.dart';

class MentorHomeScreen extends StatefulWidget {
  const MentorHomeScreen({super.key});

  @override
  State<MentorHomeScreen> createState() => _MentorHomeScreenState();
}

class _MentorHomeScreenState extends State<MentorHomeScreen> {
    bool isLoading = false;

  Future<void> _handleRefresh() async {
    setState(() {
      isLoading = true;
    });

    // Simulate API call or actual data fetching
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(child: RefreshIndicator(
          onRefresh: _handleRefresh,

        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomPadding(
                horizontal: 0,
                child: CustomProfileHeader(isLoading: isLoading),
              ),
             
            ],
          ),
      ),
      ) ,
    );
  }
}