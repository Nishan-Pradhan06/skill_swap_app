import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skill_swap/core/di/dependency_injection.dart';
import 'package:skill_swap/core/widgets/custom_toast.dart';
import 'package:skill_swap/features/profile/bloc/edit_profile/edit_profile_bloc.dart';
import 'package:skill_swap/features/profile/bloc/get_profile/get_profile_bloc.dart';
import 'package:skill_swap/core/widgets/custom_padding.dart';
import 'package:skill_swap/core/widgets/custom_text_form_field.dart';
import 'package:skill_swap/features/profile/model/profile_model.dart';
import 'package:skill_swap/core/theme/app_theme.dart';

class EditProfileScreen extends StatefulWidget {
  final ProfileDataModel profileData;
  const EditProfileScreen({super.key, required this.profileData});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _fullNameController;
  late TextEditingController _titleController;
  late TextEditingController _bioController;
  late TextEditingController _phoneController;
  late TextEditingController _locationController;

  File? _profileImage;
  File? _bannerImage;

  List<String> _skillsOffered = [];
  List<String> _skillsWanted = [];
  final TextEditingController _skillOfferController = TextEditingController();
  final TextEditingController _skillWantController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController(
      text: widget.profileData.fullName,
    );
    _titleController = TextEditingController(
      text: widget.profileData.profileTitle,
    );
    _bioController = TextEditingController(text: widget.profileData.bio);
    _phoneController = TextEditingController(
      text: widget.profileData.phoneNumber,
    );
    _locationController = TextEditingController(
      text: widget.profileData.locationProvince,
    );
    _skillsOffered = List.from(widget.profileData.skillYouOffer);
    _skillsWanted = List.from(widget.profileData.skillYouWantToLearn);
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _titleController.dispose();
    _bioController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    _skillOfferController.dispose();
    _skillWantController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(bool isProfile) async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      final croppedFile = await _cropImage(
        path: pickedFile.path,
        isProfile: isProfile,
      );

      if (croppedFile != null) {
        setState(() {
          if (isProfile) {
            _profileImage = File(croppedFile.path);
          } else {
            _bannerImage = File(croppedFile.path);
          }
        });
      }
    }
  }

  Future<CroppedFile?> _cropImage({
    required String path,
    required bool isProfile,
  }) async {
    return await ImageCropper().cropImage(
      sourcePath: path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: isProfile ? 'Crop Profile Image' : 'Crop Banner Image',
          toolbarColor: Theme.of(context).primaryColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: isProfile
              ? CropAspectRatioPreset.square
              : CropAspectRatioPreset.ratio16x9,
          lockAspectRatio: true,
          aspectRatioPresets: isProfile
              ? [CropAspectRatioPreset.square]
              : [
                  CropAspectRatioPreset.ratio16x9,
                  CropAspectRatioPreset.ratio3x2,
                  CropAspectRatioPreset.original,
                ],
        ),
        IOSUiSettings(
          title: isProfile ? 'Crop Profile Image' : 'Crop Banner Image',
          cropStyle: isProfile ? CropStyle.circle : CropStyle.rectangle,
          aspectRatioPresets: isProfile
              ? [CropAspectRatioPreset.square]
              : [
                  CropAspectRatioPreset.ratio16x9,
                  CropAspectRatioPreset.ratio3x2,
                  CropAspectRatioPreset.original,
                ],
        ),
      ],
    );
  }

  void _addSkill(List<String> list, TextEditingController controller) {
    if (controller.text.isNotEmpty) {
      setState(() {
        list.add(controller.text);
        controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<EditProfileBloc>(),
      child: BlocConsumer<EditProfileBloc, EditProfileState>(
        listener: (context, state) {
          state.whenOrNull(
            success: (message) {
              CustomToast.showSuccess(message);

              sl<GetProfileBloc>().add(const GetProfileEvent.getProfile());
              context.pop();
            },
            failure: (message) {
              CustomToast.showError(message);
            },
          );
        },
        builder: (context, state) {
          final isLoading = state.maybeWhen(
            loading: () => true,
            orElse: () => false,
          );

          return Scaffold(
            appBar: AppBar(
              title: const Text('Edit Profile'),
              scrolledUnderElevation: 0,
              centerTitle: false,
              actions: [
                if (isLoading)
                  const Center(child: CircularProgressIndicator())
                else
                  IconButton(
                    onPressed: () {
                      final data = {
                        'full_name': _fullNameController.text,
                        'profile_title': _titleController.text,
                        'bio': _bioController.text,
                        'phone_number': _phoneController.text,
                        'location_province': _locationController.text,
                        'skill_you_offer': jsonEncode(_skillsOffered),
                        'skill_you_want_to_learn': jsonEncode(_skillsWanted),
                      };
                      context.read<EditProfileBloc>().add(
                        EditProfileEvent.submit(
                          data: data,
                          profileImagePath: _profileImage?.path,
                          bannerImagePath: _bannerImage?.path,
                        ),
                      );
                    },
                    icon: const Icon(Icons.save),
                  ),
              ],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Banner & Profile Image
                  Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          image: _bannerImage != null
                              ? DecorationImage(
                                  image: FileImage(_bannerImage!),
                                  fit: BoxFit.cover,
                                )
                              : widget.profileData.bannerImage != null &&
                                    widget.profileData.bannerImage!.isNotEmpty
                              ? DecorationImage(
                                  image: NetworkImage(
                                    widget.profileData.bannerImage!,
                                  ),
                                  fit: BoxFit.cover,
                                )
                              : const DecorationImage(
                                  image: AssetImage('assets/images/banner.png'),
                                  fit: BoxFit.cover,
                                ),
                        ),
                        child:
                            _bannerImage == null &&
                                (widget.profileData.bannerImage == null ||
                                    widget.profileData.bannerImage!.isEmpty)
                            ? const Center(
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                ),
                              )
                            : null,
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
                              onPressed: () => _pickImage(false),
                              icon: Icon(Icons.mode_edit_rounded, size: 14),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.white,
                              backgroundImage: _profileImage != null
                                  ? FileImage(_profileImage!)
                                  : widget.profileData.profileImage != null &&
                                        widget
                                            .profileData
                                            .profileImage!
                                            .isNotEmpty
                                  ? NetworkImage(
                                      widget.profileData.profileImage!,
                                    )
                                  : const AssetImage(
                                          'assets/images/default_profile.png',
                                        )
                                        as ImageProvider,
                              child:
                                  _profileImage == null &&
                                      (widget.profileData.profileImage ==
                                              null ||
                                          widget
                                              .profileData
                                              .profileImage!
                                              .isEmpty)
                                  ? null
                                  : null,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                height: 26,
                                width: 26,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () => _pickImage(true),
                                  icon: Icon(Icons.mode_edit_rounded, size: 14),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Form Fields
                  // Form Fields
                  CustomTextField(
                    label: 'Full Name',
                    controller: _fullNameController,
                    borderColor: Colors.transparent,
                    fillColor: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0XFF272c29)
                        : AppTheme.surfaceLight,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    label: 'Profile Title',
                    controller: _titleController,
                    borderColor: Colors.transparent,
                    fillColor: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0XFF272c29)
                        : AppTheme.surfaceLight,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    label: 'Bio',
                    controller: _bioController,
                    maxLines: 3,
                    borderColor: Colors.transparent,
                    fillColor: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0XFF272c29)
                        : AppTheme.surfaceLight,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    label: 'Phone Number',
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    borderColor: Colors.transparent,
                    fillColor: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0XFF272c29)
                        : AppTheme.surfaceLight,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    label: 'Location (Province)',
                    controller: _locationController,
                    borderColor: Colors.transparent,
                    fillColor: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0XFF272c29)
                        : AppTheme.surfaceLight,
                  ),
                  const SizedBox(height: 20),

                  // Skills Offered
                  Text(
                    'Skills You Offer',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          controller: _skillOfferController,
                          hint: 'Add a skill',
                          borderColor: Colors.transparent,
                          fillColor:
                              Theme.of(context).brightness == Brightness.dark
                              ? const Color(0XFF272c29)
                              : AppTheme.surfaceLight,
                        ),
                      ),
                      IconButton(
                        onPressed: () =>
                            _addSkill(_skillsOffered, _skillOfferController),
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _skillsOffered
                        .map(
                          (skill) => FilterChip(
                            padding: EdgeInsets.all(0),
                            labelPadding: EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 0,
                            ),
                            label: Text(
                              skill,
                              style: TextTheme.of(context).bodySmall?.copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onSelected: (selected) {},
                            side: BorderSide(
                              color: Theme.of(
                                context,
                              ).colorScheme.primary.withValues(alpha: 0.6),
                            ),
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.primary.withValues(alpha: 0.6),
                            deleteIcon: Icon(
                              Icons.cancel,
                              size: 18,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                            onDeleted: () {
                              setState(() {
                                _skillsOffered.remove(skill);
                              });
                            },
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 20),

                  // Skills Wanted
                  Text(
                    'Skills You Want To Learn',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          controller: _skillWantController,
                          hint: 'Add a skill',
                          borderColor: Colors.transparent,
                          fillColor:
                              Theme.of(context).brightness == Brightness.dark
                              ? const Color(0XFF272c29)
                              : AppTheme.surfaceLight,
                        ),
                      ),
                      IconButton(
                        onPressed: () =>
                            _addSkill(_skillsWanted, _skillWantController),
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _skillsWanted
                        .map(
                          (skill) => FilterChip(
                            padding: EdgeInsets.all(0),
                            labelPadding: EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 0,
                            ),
                            label: Text(
                              skill,
                              style: TextTheme.of(context).bodySmall?.copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onSelected: (selected) {},
                            side: BorderSide(
                              color: Theme.of(
                                context,
                              ).colorScheme.primary.withValues(alpha: 0.6),
                            ),
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.primary.withValues(alpha: 0.6),
                            deleteIcon: Icon(
                              Icons.cancel,
                              size: 18,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                            onDeleted: () {
                              setState(() {
                                _skillsWanted.remove(skill);
                              });
                            },
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
