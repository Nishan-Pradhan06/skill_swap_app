import 'package:flutter/material.dart';

import '../../../../core/helpers/validation_helpers.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';

class BasicInfoScreen extends StatelessWidget {
  final TextEditingController profileTitleController;
  final TextEditingController profileDesController;
  final void Function() onPressedSkip;
  final void Function() onPressedDone;

  const BasicInfoScreen({
    super.key,
    required this.profileDesController,
    required this.profileTitleController,
    required this.onPressedDone,
    required this.onPressedSkip,
  });

  @override
  Widget build(BuildContext context) {
    final darkTextTheme = Theme.of(context).brightness == Brightness.dark;
    final List<String> provinces = [
      'Koshi Province',
      'Madhesh Province',
      'Bagmati Province',
      'Gandaki Province',
      'Lumbini Province',
      'Karnali Province',
      'Sudurpashchim Province',
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Basic Information',
              style: Theme.of(
                context,
              ).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
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
              controller: profileTitleController,
              // onChanged: (value) => profileTitle = value,
              validator: InputValidator.validateName,
              fillColor: darkTextTheme
                  ? const Color(0XFF272c29)
                  : AppTheme.surfaceLight,
            ),
            CustomTextField(
              label: 'Bio',
              hint: 'Tell us about yourself',
              borderColor: Colors.transparent,
              type: CustomTextFieldType.text,
              controller: profileDesController,
              maxLines: 5,
              // onChanged: (value) => description = value,
              validator: InputValidator.validateName,
              fillColor: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0XFF272c29)
                  : AppTheme.surfaceLight,
            ),
            CustomTextField(
              label: 'Location',
              type: CustomTextFieldType.dropdown,

              // onDropdownChanged: provinces,
              dropdownItems: provinces,
              hint: 'Enter your location',
              borderColor: Colors.transparent,
              // type: CustomTextFieldType.text,
              controller: profileDesController,
              // maxLines: 5,
              // onChanged: (value) => description = value,
              
              validator: InputValidator.validateName,
              fillColor: darkTextTheme
                  ? const Color(0XFF272c29)
                  : AppTheme.surfaceLight,
            ),
          ],
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
                text: 'Skip',
                onPressed: onPressedSkip,
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
