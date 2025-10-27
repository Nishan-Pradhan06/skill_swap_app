import 'package:flutter/material.dart';
import 'package:skill_swap/core/widgets/custom_button.dart';
import 'package:skill_swap/core/widgets/custom_text_form_field.dart';

import '../../../../core/helpers/validation_helpers.dart';
import '../../../../core/theme/app_theme.dart';

class ProfileInfoScreen extends StatelessWidget {
  final TextEditingController profileTitleController;
  final TextEditingController profileDesController;
  final void Function() onPressedSkip;
  final void Function() onPressedDone;

  const ProfileInfoScreen({
    super.key,
    required this.profileDesController,
    required this.profileTitleController,
    required this.onPressedDone,
    required this.onPressedSkip,
  });

  @override
  Widget build(BuildContext context) {
    final darkTextTheme = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Add Profile Information',
              style: Theme.of(
                context,
              ).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              'Join us to connect, create, and grow: sign up now and take the first step to success!',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 16,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: darkTextTheme
                          ? const Color(0XFF272c29)
                          : AppTheme.surfaceLight,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      size: 50,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),

            Center(
              child: Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: Text(
                  'Upload Profile Picture',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: darkTextTheme
                        ? AppTheme.backgroundDark
                        : AppTheme.backgroundLight,
                  ),
                ),
              ),
            ),

            CustomTextField(
              label: 'Profile Title *',
              hint: 'Enter your profile title',
              borderColor: Colors.transparent,
              type: CustomTextFieldType.text,
              controller: profileTitleController,
              // onChanged: (value) => profileTitle = value,
              validator: InputValidator.validateName,
              fillColor: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0XFF272c29)
                  : AppTheme.surfaceLight,
            ),
            CustomTextField(
              label: 'Description',
              hint: 'Enter your profile description',
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
