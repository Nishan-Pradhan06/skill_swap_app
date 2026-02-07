import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:skill_swap/core/widgets/custom_padding.dart';
import 'package:skill_swap/core/widgets/custom_text_form_field.dart';
import 'package:skill_swap/core/widgets/custom_toast.dart';
import 'package:skill_swap/features/skill_swap/blocs/get_categories_bloc.dart';
import 'package:skill_swap/features/skill_swap/blocs/manage_skill_post_bloc.dart';
import 'package:skill_swap/core/di/dependency_injection.dart';
import 'package:skill_swap/features/skill_swap/repositories/skill_swap_repository.dart';
import 'package:skill_swap/features/skill_swap/models/skill_swap_post_model.dart';

class SkillPostFormScreen extends StatefulWidget {
  final SkillSwapPostModel? post;
  const SkillPostFormScreen({super.key, this.post});

  @override
  State<SkillPostFormScreen> createState() => _SkillPostFormScreenState();
}

class _SkillPostFormScreenState extends State<SkillPostFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _skillToLearnController;
  late TextEditingController _pointsCostController;
  late TextEditingController _durationController;

  PostCategoryModel? _selectedCategory;
  bool _setAvailability = false;
  DateTime? _startDate;
  TimeOfDay? _startTime;
  DateTime? _endDate;
  TimeOfDay? _endTime;

  @override
  void initState() {
    super.initState();
    final p = widget.post;
    _titleController = TextEditingController(text: p?.title ?? '');
    _descriptionController = TextEditingController(text: p?.description ?? '');
    _skillToLearnController = TextEditingController(
      text: p?.skillToLearn ?? '',
    );
    _pointsCostController = TextEditingController(
      text: (p?.pointsCost ?? 0).toString(),
    );
    _durationController = TextEditingController(text: '60');
    _selectedCategory = p?.category;

    if (p != null && p.teachDate != null) {
      _setAvailability = true;
      _startDate = DateTime.tryParse(p.teachDate!);
      if (p.teachTime != null) {
        final timeParts = p.teachTime!.split(':');
        if (timeParts.length >= 2) {
          _startTime = TimeOfDay(
            hour: int.parse(timeParts[0]),
            minute: int.parse(timeParts[1]),
          );
        }
      }

      if (p.teachEndDate != null) {
        _endDate = DateTime.tryParse(p.teachEndDate!);
      }
      if (p.teachEndTime != null) {
        final timeParts = p.teachEndTime!.split(':');
        if (timeParts.length >= 2) {
          _endTime = TimeOfDay(
            hour: int.parse(timeParts[0]),
            minute: int.parse(timeParts[1]),
          );
        }
      }
      _durationController.text = p.durationMinutes.toString();
    }

    context.read<GetCategoriesBloc>().add(
      const GetCategoriesEvent.getCategories(),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _skillToLearnController.dispose();
    _pointsCostController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  Future<void> _selectTime(BuildContext context, bool isStart) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startTime = picked;
        } else {
          _endTime = picked;
        }
      });
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedCategory == null) {
      CustomToast.showError("Please select a category");
      return;
    }

    Map<String, dynamic>? availabilityData;
    if (_setAvailability) {
      if (_startDate == null ||
          _startTime == null ||
          _endDate == null ||
          _endTime == null) {
        CustomToast.showError("Please complete availability settings");
        return;
      }

      final startDateTime = DateTime(
        _startDate!.year,
        _startDate!.month,
        _startDate!.day,
        _startTime!.hour,
        _startTime!.minute,
      );
      final endDateTime = DateTime(
        _endDate!.year,
        _endDate!.month,
        _endDate!.day,
        _endTime!.hour,
        _endTime!.minute,
      );

      if (endDateTime.isBefore(startDateTime)) {
        CustomToast.showError("End time must be after start time");
        return;
      }

      availabilityData = {
        "start_time": startDateTime.toIso8601String(),
        "end_time": endDateTime.toIso8601String(),
        "duration_minutes": int.tryParse(_durationController.text) ?? 60,
      };
    }

    if (widget.post == null) {
      context.read<ManageSkillPostBloc>().add(
        ManageSkillPostEvent.create(
          title: _titleController.text,
          description: _descriptionController.text,
          categoryId: _selectedCategory!.id,
          skillToLearn: _skillToLearnController.text,
          pointsCost: int.tryParse(_pointsCostController.text) ?? 0,
          availability: availabilityData,
        ),
      );
    } else {
      context.read<ManageSkillPostBloc>().add(
        ManageSkillPostEvent.update(
          postId: widget.post!.id,
          title: _titleController.text,
          description: _descriptionController.text,
          categoryId: _selectedCategory!.id,
          skillToLearn: _skillToLearnController.text,
          pointsCost: int.tryParse(_pointsCostController.text) ?? 0,
          availability: availabilityData,
        ),
      );
    }
  }

  Future<void> _showAddCategoryDialog(BuildContext context) async {
    final TextEditingController categoryController = TextEditingController();
    await showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text("Add New Category"),
          content: TextField(
            controller: categoryController,
            decoration: const InputDecoration(
              labelText: "Category Name",
              border: OutlineInputBorder(),
              hintText: "e.g. Programming, Music",
            ),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                final name = categoryController.text.trim();
                if (name.isEmpty) {
                  CustomToast.showError("Category name required");
                  return;
                }

                Navigator.pop(dialogContext);

                try {
                  final result = await sl<SkillSwapRepository>().addCategory(
                    name: name,
                  );
                  result.fold(
                    (failure) => CustomToast.showError(failure.message),
                    (success) {
                      CustomToast.showSuccess(
                        "Category '$name' added successfully",
                      );
                      if (mounted) {
                        context.read<GetCategoriesBloc>().add(
                          const GetCategoriesEvent.getCategories(),
                        );
                      }
                    },
                  );
                } catch (e) {
                  CustomToast.showError(e.toString());
                }
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ManageSkillPostBloc, ManageSkillPostState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (message) {
            CustomToast.showSuccess(message);
            Navigator.pop(context, true);
          },
          failure: (message) => CustomToast.showError(message),
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.post == null ? "Create Skill Post" : "Edit Skill Post",
          ),
          scrolledUnderElevation: 0,
        ),
        body: SingleChildScrollView(
          child: CustomPadding(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    label: "Title",
                    hint: "Enter skill post title",
                    controller: _titleController,
                    validator: (v) =>
                        v?.isEmpty ?? true ? "Title required" : null,
                    fillColor: Colors.transparent,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    label: "Description",
                    hint: "Describe what you'll teach",
                    controller: _descriptionController,
                    maxLines: 3,
                    validator: (v) =>
                        v?.isEmpty ?? true ? "Description required" : null,
                    fillColor: Colors.transparent,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "What category best describes your skill?",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            "This helps learners find your post more easily",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          IconButton(
                            onPressed: () {
                              _showAddCategoryDialog(context);
                            },
                            icon: const Icon(Icons.add_circle_outline),
                            tooltip: "Add new category",
                          ),
                          IconButton(
                            onPressed: () => context
                                .read<GetCategoriesBloc>()
                                .add(const GetCategoriesEvent.getCategories()),
                            icon: const Icon(Icons.refresh, size: 20),
                            tooltip: "Refresh categories",
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  BlocBuilder<GetCategoriesBloc, GetCategoriesState>(
                    builder: (context, state) {
                      final theme = Theme.of(context);
                      return state.maybeWhen(
                        loaded: (cats) {
                          if (cats.isEmpty) {
                            return Column(
                              children: [
                                const Text("No categories found in database."),
                                TextButton.icon(
                                  onPressed: () =>
                                      context.read<GetCategoriesBloc>().add(
                                        const GetCategoriesEvent.getCategories(),
                                      ),
                                  icon: const Icon(Icons.refresh),
                                  label: const Text("Retry Fetching"),
                                ),
                              ],
                            );
                          }
                          return Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: cats.map((c) {
                              final isSelected = _selectedCategory?.id == c.id;
                              return ChoiceChip(
                                label: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                    vertical: 2,
                                  ),
                                  child: Text(c.name),
                                ),
                                selected: isSelected,
                                onSelected: (selected) {
                                  if (selected) {
                                    setState(() => _selectedCategory = c);
                                  }
                                },
                                selectedColor: theme.colorScheme.primary,
                                side: BorderSide(
                                  color: isSelected
                                      ? theme.colorScheme.primary
                                      : Colors.grey.withOpacity(0.5),
                                  width: 1,
                                ),
                                labelStyle: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : theme.textTheme.bodyLarge?.color,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                                elevation: isSelected ? 2 : 0,
                                pressElevation: 4,
                                backgroundColor: theme.colorScheme.surface,
                              );
                            }).toList(),
                          );
                        },
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        orElse: () => const Text(
                          "Failed to load categories. Please tap to retry.",
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    label: "Skill you will learn",
                    hint: "e.g. Python Programming",
                    controller: _skillToLearnController,
                    validator: (v) => v?.isEmpty ?? true ? "Required" : null,
                    fillColor: Colors.transparent,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    label: "Points Cost",
                    hint: "0",
                    controller: _pointsCostController,
                    type: CustomTextFieldType.number,
                    fillColor: Colors.transparent,
                    leading: const Icon(Icons.money_off),
                  ),
                  const SizedBox(height: 32),
                  const Divider(),
                  SwitchListTile(
                    title: const Text(
                      "Set Availability Slots",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: const Text(
                      "Generate time slots for learners to book",
                    ),
                    value: _setAvailability,
                    onChanged: (v) => setState(() => _setAvailability = v),
                  ),
                  if (_setAvailability) ...[
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => _selectDate(context, true),
                            icon: const Icon(Icons.calendar_today),
                            label: Text(
                              _startDate == null
                                  ? "Start Date"
                                  : DateFormat(
                                      'yyyy-MM-dd',
                                    ).format(_startDate!),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => _selectTime(context, true),
                            icon: const Icon(Icons.access_time),
                            label: Text(
                              _startTime == null
                                  ? "Start Time"
                                  : _startTime!.format(context),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => _selectDate(context, false),
                            icon: const Icon(Icons.calendar_today),
                            label: Text(
                              _endDate == null
                                  ? "End Date"
                                  : DateFormat('yyyy-MM-dd').format(_endDate!),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => _selectTime(context, false),
                            icon: const Icon(Icons.access_time),
                            label: Text(
                              _endTime == null
                                  ? "End Time"
                                  : _endTime!.format(context),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      label: "Slot Duration (minutes)",
                      hint: "60",
                      controller: _durationController,
                      type: CustomTextFieldType.number,
                    ),
                  ],
                  const SizedBox(height: 48),
                  BlocBuilder<GetCategoriesBloc, GetCategoriesState>(
                    builder: (context, catState) {
                      final categoriesLoaded = catState.maybeWhen(
                        loaded: (_) => true,
                        orElse: () => false,
                      );

                      return BlocBuilder<
                        ManageSkillPostBloc,
                        ManageSkillPostState
                      >(
                        builder: (context, state) {
                          final isLoading = state.maybeWhen(
                            loading: () => true,
                            orElse: () => false,
                          );
                          final canSubmit =
                              !isLoading &&
                              categoriesLoaded &&
                              _selectedCategory != null;

                          return SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: canSubmit ? _submit : null,
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: isLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      widget.post == null
                                          ? "Create Post & Slots"
                                          : "Save Changes",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
