import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_swap/core/helpers/validation_helpers.dart';
import 'package:skill_swap/core/theme/app_theme.dart';
import 'package:skill_swap/core/widgets/custom_button.dart';
import 'package:skill_swap/core/widgets/custom_padding.dart';
import 'package:skill_swap/core/widgets/custom_text_form_field.dart';
import 'package:skill_swap/features/profile/bloc/get_profile/get_profile_bloc.dart';

class PersonalDetailsScreen extends StatefulWidget {
  const PersonalDetailsScreen({super.key});

  @override
  State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  bool _isEditing = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _saveChanges() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      setState(() {
        _isLoading = false;
        _isEditing = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Personal details updated successfully'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  void _cancelEdit() {
    setState(() {
      _isEditing = false;
      // Reset to original values
      _emailController.text = 'user@example.com';
      _phoneController.text = '+977 9812345678';
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Details'),
        actions: [
          if (!_isEditing)
            IconButton(
              icon: const Icon(Icons.edit_rounded),
              onPressed: () => setState(() => _isEditing = true),
              tooltip: 'Edit',
            ),
        ],
      ),
      body: BlocBuilder<GetProfileBloc, GetProfileState>(
        builder: (context, state) {
          return state.when(
            initial: () => SizedBox(),
            loading: () => CircularProgressIndicator(),
            failure: (failure) => Center(
              child: Text(
                'Error: ${failure.message}',
                style: const TextStyle(color: Colors.red),
              ),
            ),
            loaded: (data) {
              if (!_isEditing) {
                _emailController.text = data.email;
                _phoneController.text = data.phoneNumber;
              }
              return Form(
                key: _formKey,
                child: CustomPadding(
                  child: Column(
                    spacing: 10,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        spacing: 10,
                        children: [
                          // Email Field'
                          CustomTextField(
                            label: 'Email Address',
                            enabled: _isEditing,
                            borderColor: Colors.transparent,
                            controller: _emailController,
                            type: CustomTextFieldType.email,
                            validator: InputValidator.validateEmail,
                            leading: Icon(Icons.email_rounded, size: 20),
                            fillColor:
                                Theme.of(context).brightness == Brightness.dark
                                ? const Color(0XFF272c29)
                                : AppTheme.surfaceLight,
                          ),
                          CustomTextField(
                            label: 'Phone Number',
                            enabled: _isEditing,
                            borderColor: Colors.transparent,
                            controller: _phoneController,
                            type: CustomTextFieldType.phone,
                            validator: InputValidator.validatePhone,
                            leading: Icon(Icons.phone_rounded, size: 20),
                            fillColor:
                                Theme.of(context).brightness == Brightness.dark
                                ? const Color(0XFF272c29)
                                : AppTheme.surfaceLight,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          // Action Buttons
                          if (_isEditing) ...[
                            Row(
                              spacing: 10,
                              children: [
                                Expanded(
                                  child: CustomButton(
                                    onPressed: _isLoading
                                        ? () {}
                                        : _saveChanges,
                                    isLoading: _isLoading,
                                    text: 'Save Changes',
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Expanded(
                                  child: CustomOutlineButton(
                                    text: 'Cancel',
                                    isLoading: _isLoading,
                                    onPressed: _isLoading ? () {} : _cancelEdit,
                                  ),
                                ),
                              ],
                            ),
                          ],

                          const SizedBox(height: 24),
                          // Info Card
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.tertiary.withValues(
                                  alpha: 0.1,
                                ),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: theme.colorScheme.tertiary.withValues(
                                    alpha: 0.3,
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.info_outline_rounded,
                                    color: theme.colorScheme.tertiary,
                                    size: 24,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      'Your personal information is encrypted and securely stored. We will never share your details with third parties.',
                                      style: theme.textTheme.bodySmall
                                          ?.copyWith(
                                            color: theme.colorScheme.onSurface,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 50),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
