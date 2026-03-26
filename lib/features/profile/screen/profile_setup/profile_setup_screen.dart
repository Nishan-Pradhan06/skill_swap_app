import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skill_swap/core/di/dependency_injection.dart';
import 'package:skill_swap/core/widgets/custom_padding.dart';
import 'package:skill_swap/features/profile/bloc/profile_setup/profile_setup_bloc.dart';
import 'package:skill_swap/features/profile/model/profile_setup_model.dart';
import 'package:skill_swap/features/profile/screen/profile_setup/basic_info_screen.dart';
import 'package:skill_swap/features/profile/screen/profile_setup/phone_verification_screen.dart';
import 'package:skill_swap/features/profile/screen/profile_setup/profile_info_screen.dart';
import 'package:skill_swap/features/profile/screen/profile_setup/skill_wanted_screen.dart';
import 'package:skill_swap/features/profile/screen/profile_setup/skilled_offered_screen.dart';
import 'package:skill_swap/router/app_routes_names.dart';

import '../../../../core/widgets/custom_toast.dart';

class ProfileSetupFlow extends StatefulWidget {
  const ProfileSetupFlow({super.key});

  @override
  State<ProfileSetupFlow> createState() => _ProfileSetupFlowState();
}

class _ProfileSetupFlowState extends State<ProfileSetupFlow> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalPages = 5;

  final _profileTitleController = TextEditingController();
  final _profileDesController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _bioController = TextEditingController();
  final _provincesController = TextEditingController();
  final _skillOfferedController = TextEditingController();

  // Form keys for validation
  final _profileInfoFormKey = GlobalKey<FormState>();
  final _phoneFormKey = GlobalKey<FormState>();
  final _basicInfoFormKey = GlobalKey<FormState>();

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

  final List<String> provinces = [
    'Koshi Province',
    'Madhesh Province',
    'Bagmati Province',
    'Gandaki Province',
    'Lumbini Province',
    'Karnali Province',
    'Sudurpashchim Province',
  ];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProfileSetupBloc, ProfileSetupState>(
        listener: (context, state) {
          state.whenOrNull(
            loading: () {
              // LoadingDi
            },
            failure: (failure) {
              CustomToast.showError(failure.message);
            },
            loaded: (data) async {
              context.goNamed(AppRoutesName.learnerBottomNavBar);
              CustomToast.showSuccess("Profile setup complete");
            },
          );
        },
        builder: (context, state) {
          return SafeArea(
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
                          formKey: _profileInfoFormKey,
                          profileTitleController: _profileTitleController,
                          profileDesController: _profileDesController,
                          onPressedDone: () {
                            if (_profileInfoFormKey.currentState!.validate()) {
                              _nextPage();
                            }
                          },
                        ),
                        PhoneVerificationScreen(
                          formKey: _phoneFormKey,
                          phoneNumberController: _phoneNumberController,
                          onPressedDone: () {
                            if (_phoneFormKey.currentState!.validate()) {
                              _nextPage();
                            }
                          },
                          onPressedPrevious: _previousPage,
                        ),
                        BasicInfoScreen(
                          formKey: _basicInfoFormKey,
                          fullNameController: _fullNameController,
                          bioController: _bioController,
                          provinces: provinces,
                          provincesController: _provincesController,
                          onPressedPrevious: _previousPage,
                          onPressedDone: () {
                            if (_basicInfoFormKey.currentState!.validate()) {
                              _nextPage();
                            }
                          },
                        ),
                        SkilledOfferedScreen(
                          skillOfferedController: _skillOfferedController,
                          onPressedPrevious: _previousPage,
                          onPressedDone: () {
                            if (skillsOffered.isEmpty) {
                              CustomToast.showError(
                                "Please select at least one skill you offer",
                              );
                              return;
                            }
                            _nextPage();
                          },
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
                              ).colorScheme.surface,
                              selectedColor: Theme.of(
                                context,
                              ).colorScheme.primary.withValues(alpha: 0.6),
                              checkmarkColor: Theme.of(
                                context,
                              ).colorScheme.primary,
                            );
                          }).toList(),
                        ),

                        SkilledWantedScreen(
                          skillOfferedController: _skillOfferedController,
                          onPressedPrevious: _previousPage,
                          onPressedDone: () async {
                            if (skillsWanted.isEmpty) {
                              CustomToast.showError(
                                "Please select at least one skill you want to learn",
                              );
                              return;
                            }
                            sl<ProfileSetupBloc>().add(
                              ProfileSetupEvent.userProfileSetUp(
                                UserProfileSetUpModel(
                                  profileTitle: _profileTitleController.text,
                                  profileDescription:
                                      _profileDesController.text,
                                  phoneNumber: _phoneNumberController.text,
                                  fullName: _fullNameController.text,
                                  bio: _bioController.text,
                                  locationProvince: _provincesController.text,

                                  skillYouOffer: skillsOffered,
                                  skillYouWantToLearn: skillsWanted,
                                ),
                              ),
                            );
                            // Removed local cache call - backend now tracks completion
                          },
                          children: availableSkills.map((skill) {
                            final isSelected = skillsWanted.contains(skill);
                            return FilterChip(
                              label: Text(skill),
                              selected: isSelected,
                              onSelected: (selected) {
                                setState(() {
                                  if (selected) {
                                    skillsWanted.add(skill);
                                  } else {
                                    skillsWanted.remove(skill);
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
                              ).colorScheme.surface,
                              selectedColor: Theme.of(
                                context,
                              ).colorScheme.primary.withValues(alpha: 0.6),
                              checkmarkColor: Theme.of(
                                context,
                              ).colorScheme.primary,
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
