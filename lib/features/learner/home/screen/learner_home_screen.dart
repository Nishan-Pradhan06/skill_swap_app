import 'package:flutter/material.dart';
import '../../../../core/widgets/custom_scrollable_padding.dart';
import '../widgets/custom_profile_header.dart';

class LearnerHomeScreen extends StatefulWidget {
  const LearnerHomeScreen({super.key});

  @override
  State<LearnerHomeScreen> createState() => _LearnerHomeScreenState();
}

class _LearnerHomeScreenState extends State<LearnerHomeScreen> {
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
      body: SafeArea(
        child: ScrollableRefreshablePadding(
          onRefresh: _handleRefresh,
          child: Column(
            spacing: 10,
            children: [
              CustomProfileHeader(isLoading: isLoading),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                height: 140,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Container(
                width: double.infinity,
                height: 10,
                color: Theme.of(context).colorScheme.surface,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
