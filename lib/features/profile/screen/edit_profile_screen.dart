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
import 'package:skill_swap/features/profile/model/certification_model.dart';
import 'package:skill_swap/features/profile/model/working_exprience_model.dart';
import 'package:skill_swap/features/profile/widgets/certificate_container_widget.dart';
import 'package:skill_swap/features/profile/widgets/working_exp_widget.dart';
import '../../../core/utils/image_url_utils.dart';

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
  List<CertificationModel> _certifications = [];
  List<WorkingExprienceModel> _experiences = [];
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
    _certifications = List.from(widget.profileData.certifications);
    _experiences = List.from(widget.profileData.workingExpriences);
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
                        'certifications': jsonEncode(
                          _certifications.map((e) => e.toMap()).toList(),
                        ),
                        'work_experience': jsonEncode(
                          _experiences.map((e) => e.toMap()).toList(),
                        ),
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
                                    ImageUrlUtils.getImageUrl(
                                      widget.profileData.bannerImage,
                                    ),
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
                                      ImageUrlUtils.getImageUrl(
                                        widget.profileData.profileImage,
                                      ),
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
                  const SizedBox(height: 20),

                  // Certifications
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Certifications',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      IconButton(
                        onPressed: _showAddCertificationDialog,
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                  if (_certifications.isNotEmpty)
                    SizedBox(
                      height: 200,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _certifications.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 10),
                        itemBuilder: (context, index) {
                          final cert = _certifications[index];
                          return Stack(
                            children: [
                              ContainerWithImageWidget(
                                certificateImageUrl: cert.image,
                                certificateTitle: cert.title,
                              ),
                              Positioned(
                                top: 5,
                                right: 5,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _certifications.removeAt(index);
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.red.withValues(alpha: 0.8),
                                      shape: BoxShape.circle,
                                    ),
                                    padding: const EdgeInsets.all(4),
                                    child: const Icon(
                                      Icons.close,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    )
                  else
                    const Text('No certifications added.'),

                  const SizedBox(height: 20),

                  // Working Experience
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Working Experience',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      IconButton(
                        onPressed: _showAddExperienceDialog,
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                  if (_experiences.isNotEmpty)
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _experiences.length,
                      itemBuilder: (context, index) {
                        final exp = _experiences[index];
                        return Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: WorkingExprienceList(
                                imageUrl: exp.image,
                                title: exp.title,
                                companyName: exp.companyName,
                                location: exp.location,
                                experience: exp.experience,
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _experiences.removeAt(index);
                                  });
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    )
                  else
                    const Text('No working experience added.'),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<String?> _pickNestedImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return null;

    final croppedFile = await _cropImage(path: image.path, isProfile: false);
    return croppedFile?.path;
  }

  void _showAddCertificationDialog() {
    final titleController = TextEditingController();
    String? pickedImagePath;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Add Certification'),
          content: SizedBox(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(
                  label: 'Title',
                  controller: titleController,
                  borderColor: Colors.transparent,
                  fillColor: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0XFF272c29)
                      : AppTheme.surfaceLight,
                ),
                const SizedBox(height: 10),
                if (pickedImagePath != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      File(pickedImagePath!),
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  )
                else
                  const Text('No image selected'),
                TextButton.icon(
                  onPressed: () async {
                    final path = await _pickNestedImage();
                    if (path != null) {
                      setDialogState(() {
                        pickedImagePath = path;
                      });
                    }
                  },
                  icon: const Icon(Icons.image),
                  label: const Text('Pick Image'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (titleController.text.isNotEmpty &&
                    pickedImagePath != null) {
                  setState(() {
                    _certifications.add(
                      CertificationModel(
                        title: titleController.text,
                        image: pickedImagePath!,
                      ),
                    );
                  });
                  Navigator.pop(context);
                } else if (pickedImagePath == null) {
                  CustomToast.showError('Please pick an image');
                }
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddExperienceDialog() {
    final titleController = TextEditingController();
    final companyController = TextEditingController();
    final locationController = TextEditingController();
    final experienceController = TextEditingController();
    String? pickedImagePath;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Add Experience'),
          content: SizedBox(
            width: 400,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextField(
                    label: 'Job Title',
                    controller: titleController,
                    borderColor: Colors.transparent,
                    fillColor: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0XFF272c29)
                        : AppTheme.surfaceLight,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    label: 'Company Name',
                    controller: companyController,
                    borderColor: Colors.transparent,
                    fillColor: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0XFF272c29)
                        : AppTheme.surfaceLight,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    label: 'Location',
                    controller: locationController,
                    borderColor: Colors.transparent,
                    fillColor: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0XFF272c29)
                        : AppTheme.surfaceLight,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    label: 'Experience (e.g., 2 years)',
                    controller: experienceController,
                    borderColor: Colors.transparent,
                    fillColor: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0XFF272c29)
                        : AppTheme.surfaceLight,
                  ),
                  const SizedBox(height: 10),
                  if (pickedImagePath != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        File(pickedImagePath!),
                        height: 60,
                        width: 60,
                        fit: BoxFit.cover,
                      ),
                    )
                  else
                    const Text('No Logo selected'),
                  TextButton.icon(
                    onPressed: () async {
                      final path = await _pickNestedImage();
                      if (path != null) {
                        setDialogState(() {
                          pickedImagePath = path;
                        });
                      }
                    },
                    icon: const Icon(Icons.image),
                    label: const Text('Pick Company Logo'),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (titleController.text.isNotEmpty &&
                    companyController.text.isNotEmpty &&
                    pickedImagePath != null) {
                  setState(() {
                    _experiences.add(
                      WorkingExprienceModel(
                        title: titleController.text,
                        companyName: companyController.text,
                        location: locationController.text,
                        experience: experienceController.text,
                        image: pickedImagePath!,
                      ),
                    );
                  });
                  Navigator.pop(context);
                } else if (pickedImagePath == null) {
                  CustomToast.showError('Please pick a company logo');
                }
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
