import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skill_swap/core/widgets/custom_padding.dart';
import 'package:skill_swap/features/profile/screen/basic_info_screen.dart';
import 'package:skill_swap/features/profile/screen/phone_verification_screen.dart';
import 'package:skill_swap/features/profile/screen/profile_info_screen.dart';
import 'package:skill_swap/features/profile/screen/skill_wanted_screen.dart';
import 'package:skill_swap/features/profile/screen/skilled_offered_screen.dart';
import 'package:skill_swap/router/app_routes_names.dart';

class ProfileSetupFlow extends StatefulWidget {
  const ProfileSetupFlow({super.key});

  @override
  State<ProfileSetupFlow> createState() => _ProfileSetupFlowState();
}

class _ProfileSetupFlowState extends State<ProfileSetupFlow> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalPages = 5;

  // Store user data
  String? profilePicture;
  String profileTitle = '';
  String description = '';
  String phoneNumber = '';
  String name = '';
  String bio = '';
  String location = '';
  List<String> skillsOffered = [];
  List<String> skillsWanted = [];

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

  final _profileTitleController = TextEditingController();
  final _profileDesController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _skillOfferedController = TextEditingController();

  void _nextPage() {
    if (_currentPage < _totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _skipPage() {
    _nextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Progress Indicator
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: List.generate(
                  _totalPages,
                  (index) => Expanded(
                    child: Container(
                      height: 4,
                      margin: EdgeInsets.only(
                        right: index < _totalPages - 1 ? 8 : 0,
                      ),
                      decoration: BoxDecoration(
                        color: index <= _currentPage
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey[400],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Page Content
            Expanded(
              child: CustomPadding(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  children: [
                    ProfileInfoScreen(
                      profileTitleController: _profileTitleController,
                      profileDesController: _profileDesController,
                      onPressedSkip: () => _skipPage(),
                      onPressedDone: () => _nextPage(),
                    ),
                    PhoneVerificationScreen(
                      phoneNumberController: _phoneNumberController,
                      onPressedDone: _nextPage,
                      onPressedSkip: _skipPage,
                    ),
                    BasicInfoScreen(
                      profileTitleController: _phoneNumberController,
                      profileDesController: _phoneNumberController,
                      onPressedSkip: _skipPage,
                      onPressedDone: _nextPage,
                    ),
                    SkilledOfferedScreen(
                      skillOfferedController: _skillOfferedController,
                      children: availableSkills.map((skill) {
                        final isSelected = skillsOffered.contains(skill);
                        return FilterChip(
                          label: Text(skill),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                skillsOffered.add(skill);
                              } else {
                                skillsOffered.remove(skill);
                              }
                            });
                          },
                          side: BorderSide(
                            color: Theme.of(
                              context,
                            ).colorScheme.primary.withValues(alpha: 0.6),
                          ),
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.background,
                          selectedColor: Theme.of(
                            context,
                          ).colorScheme.primary.withValues(alpha: 0.6),
                          checkmarkColor: Theme.of(context).colorScheme.primary,
                        );
                      }).toList(),
                      onPressedSkip: () => _skipPage(),
                      onPressedDone: () => _nextPage(),
                    ),

                    SkilledWantedScreen(
                      skillOfferedController: _skillOfferedController,
                      children: availableSkills.map((skill) {
                        final isSelected = skillsOffered.contains(skill);
                        return FilterChip(
                          label: Text(skill),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                skillsOffered.add(skill);
                              } else {
                                skillsOffered.remove(skill);
                              }
                            });
                          },
                          side: BorderSide(
                            color: Theme.of(
                              context,
                            ).colorScheme.primary.withValues(alpha: 0.6),
                          ),
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.background,
                          selectedColor: Theme.of(
                            context,
                          ).colorScheme.primary.withValues(alpha: 0.6),
                          checkmarkColor: Theme.of(context).colorScheme.primary,
                        );
                      }).toList(),
                      onPressedSkip: () => _previousPage(),
                      onPressedDone: () {
                        context.goNamed(AppRoutesName.learnerBottomNavBar);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
