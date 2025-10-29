import 'package:flutter/material.dart';
import 'package:skill_swap/core/widgets/custom_padding.dart';
import 'package:skill_swap/core/widgets/custom_text_form_field.dart';
import '../../../../core/theme/app_theme.dart';
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
    final darkTextTheme = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: ScrollableRefreshablePadding(
          onRefresh: _handleRefresh,
          child: Column(
            spacing: 10,
            children: [
              CustomProfileHeader(isLoading: isLoading),
              CustomPadding(
                vertical: 0,
                child: CustomTextField(
                  hint: 'Search',
                  borderColor: Colors.transparent,
                  borderRadius: 18,
                  type: CustomTextFieldType.search,
                  fillColor: darkTextTheme
                      ? const Color(0XFF272c29)
                      : AppTheme.surfaceLight,
                ),
              ),
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
