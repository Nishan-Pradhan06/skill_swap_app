import 'package:flutter/material.dart';
import 'package:skill_swap/core/widgets/custom_text_form_field.dart';

import '../../../core/helpers/validation_helpers.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/custom_button.dart';

class SkilledWantedScreen extends StatelessWidget {
  final List<Widget> children;
  final void Function() onPressedSkip;
  final void Function() onPressedDone;
  final TextEditingController skillOfferedController;

  const SkilledWantedScreen({
    super.key,
    required this.children,
    required this.onPressedDone,
    required this.onPressedSkip,
    required this.skillOfferedController,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Skills You Want to Learn',
              style: Theme.of(
                context,
              ).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              'Select the skills you want to learn from the community',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 16,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            CustomTextField(
              hint: 'Add custom skill',
              borderColor: Colors.transparent,
              type: CustomTextFieldType.text,
              controller: skillOfferedController,
              trailing: IconButton(
                icon: Icon(
                  Icons.add_circle,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () {},
              ),
              // onChanged: (value) => profileTitle = value,
              validator: InputValidator.validateName,
              fillColor: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0XFF272c29)
                  : AppTheme.surfaceLight,
            ),
            Wrap(spacing: 8, runSpacing: 8, children: children),
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
                text: 'Previous',
                onPressed: onPressedSkip,
              ),
            ),
            Expanded(
              child: CustomButton(text: 'Completed', onPressed: onPressedDone),
            ),
          ],
        ),
      ),
    );
  }
}
