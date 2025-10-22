import 'package:flutter/material.dart';
import 'package:skill_swap/core/widgets/custom_text_form_field.dart';

import '../../../core/helpers/validation_helpers.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/custom_button.dart';

class PhoneVerificationScreen extends StatelessWidget {
  final TextEditingController phoneNumberController;
  final void Function() onPressedSkip;
  final void Function() onPressedDone;
  const PhoneVerificationScreen({
    super.key,
    required this.phoneNumberController,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Phone Verification',
              style: Theme.of(
                context,
              ).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            Text(
              'You must provide phone number for identity verification.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 30),
            Row(
              spacing: 10,
              children: [
                Expanded(
                  child: CustomTextField(
                    hint: '+977',
                    readOnly: true,
                    enabled: false,
                    borderColor: Colors.transparent,
                    type: CustomTextFieldType.text,
                    controller: TextEditingController(text: '+977'),
                    // onChanged: (value) => description = value,
                    validator: InputValidator.validateName,
                    fillColor: darkTextTheme
                        ? const Color(0XFF272c29)
                        : AppTheme.surfaceLight,
                  ),
                ),
                Expanded(
                  flex: 4,

                  child: CustomTextField(
                    hint: 'Enter your phone Number',
                    borderColor: Colors.transparent,
                    type: CustomTextFieldType.text,
                    controller: phoneNumberController,
                    // onChanged: (value) => description = value,
                    validator: InputValidator.validateName,
                    fillColor: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0XFF272c29)
                        : AppTheme.surfaceLight,
                  ),
                ),
              ],
            ),
            const Text(
              '10 Characters Left',
              style: TextStyle(fontSize: 12, color: Colors.grey),
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
