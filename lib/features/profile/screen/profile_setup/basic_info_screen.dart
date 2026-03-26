import 'package:flutter/material.dart';

import '../../../../core/helpers/validation_helpers.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';

class BasicInfoScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController fullNameController;
  final TextEditingController bioController;
  final TextEditingController provincesController;
  final List<String> provinces;
  final void Function() onPressedPrevious;
  final void Function() onPressedDone;

  const BasicInfoScreen({
    super.key,
    required this.formKey,
    required this.fullNameController,
    required this.bioController,
    required this.provincesController,
    required this.provinces,
    required this.onPressedDone,
    required this.onPressedPrevious,
  });

  @override
  Widget build(BuildContext context) {
    final darkTextTheme = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Basic Information',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              Text(
                'Complete your profile with basic details',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),

              CustomTextField(
                label: 'Full Name *',
                hint: 'Enter your full name',
                borderColor: Colors.transparent,
                type: CustomTextFieldType.text,
                controller: fullNameController,
                validator: InputValidator.validateName,
                fillColor: darkTextTheme
                    ? const Color(0XFF272c29)
                    : AppTheme.surfaceLight,
              ),
              CustomTextField(
                label: 'Bio *',
                hint: 'Tell us about yourself',
                borderColor: Colors.transparent,
                type: CustomTextFieldType.text,
                controller: bioController,
                maxLines: 5,
                validator: InputValidator.validateDescription,
                fillColor: Theme.of(context).brightness == Brightness.dark
                    ? const Color(0XFF272c29)
                    : AppTheme.surfaceLight,
              ),
              CustomTextField(
                label: 'Location *',
                type: CustomTextFieldType.dropdown,
                dropdownItems: provinces,
                hint: 'Select your location',
                borderColor: Colors.transparent,
                controller: provincesController,
                onDropdownChanged: (value) {
                  provincesController.text = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your location';
                  }
                  return null;
                },
                fillColor: darkTextTheme
                    ? const Color(0XFF272c29)
                    : AppTheme.surfaceLight,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: MediaQuery.sizeOf(context).height / 18,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 10,
          children: [
            Expanded(
              child: CustomOutlineButton(
                text: 'Previous',
                onPressed: onPressedPrevious,
              ),
            ),
            Expanded(
              child: CustomButton(text: 'Done', onPressed: onPressedDone),
            ),
          ],
        ),
      ),
    );
  }
}
