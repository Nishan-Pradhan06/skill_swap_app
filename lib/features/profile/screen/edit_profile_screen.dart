import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skill_swap/core/di/dependency_injection.dart';
import 'package:skill_swap/features/profile/bloc/edit_profile/edit_profile_bloc.dart';
import 'package:skill_swap/features/profile/bloc/get_profile/get_profile_bloc.dart';
import 'package:skill_swap/features/profile/model/profile_model.dart';

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
      setState(() {
        if (isProfile) {
          _profileImage = File(pickedFile.path);
        } else {
          _bannerImage = File(pickedFile.path);
        }
      });
    }
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
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(message)));
              // Refresh profile data
              sl<GetProfileBloc>().add(const GetProfileEvent.getProfile());
              context.pop();
            },
            failure: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message), backgroundColor: Colors.red),
              );
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
                      GestureDetector(
                        onTap: () => _pickImage(false),
                        child: Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            image: _bannerImage != null
                                ? DecorationImage(
                                    image: FileImage(_bannerImage!),
                                    fit: BoxFit.cover,
                                  )
                                : widget.profileData.bannerImage != null
                                ? DecorationImage(
                                    image: NetworkImage(
                                      widget.profileData.bannerImage!,
                                    ),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child:
                              _bannerImage == null &&
                                  widget.profileData.bannerImage == null
                              ? const Center(child: Icon(Icons.camera_alt))
                              : null,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () => _pickImage(true),
                          child: CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.white,
                            backgroundImage: _profileImage != null
                                ? FileImage(_profileImage!)
                                : widget.profileData.profileImage != null
                                ? NetworkImage(widget.profileData.profileImage!)
                                : null as ImageProvider?,
                            child:
                                _profileImage == null &&
                                    widget.profileData.profileImage == null
                                ? const Icon(Icons.person)
                                : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Form Fields
                  TextFormField(
                    controller: _fullNameController,
                    decoration: const InputDecoration(labelText: 'Full Name'),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Profile Title',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _bioController,
                    decoration: const InputDecoration(labelText: 'Bio'),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _locationController,
                    decoration: const InputDecoration(
                      labelText: 'Location (Province)',
                    ),
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
                        child: TextField(
                          controller: _skillOfferController,
                          decoration: const InputDecoration(
                            hintText: 'Add a skill',
                          ),
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
                    children: _skillsOffered
                        .map(
                          (skill) => Chip(
                            label: Text(skill),
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
                        child: TextField(
                          controller: _skillWantController,
                          decoration: const InputDecoration(
                            hintText: 'Add a skill',
                          ),
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
                    children: _skillsWanted
                        .map(
                          (skill) => Chip(
                            label: Text(skill),
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
