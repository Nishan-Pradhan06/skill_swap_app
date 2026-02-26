import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_swap/core/utils/date_string_split_utils.dart';
import 'package:skill_swap/core/widgets/custom_padding.dart';
import 'package:skill_swap/core/widgets/custom_text_form_field.dart';
import 'package:skill_swap/core/widgets/custom_toast.dart';
import 'package:skill_swap/features/skill_swap/blocs/get_categories_bloc.dart';
import 'package:skill_swap/features/skill_swap/blocs/manage_skill_post_bloc.dart';
import 'package:skill_swap/core/di/dependency_injection.dart';
import 'package:skill_swap/features/skill_swap/repositories/skill_swap_repository.dart';
import 'package:skill_swap/features/skill_swap/models/skill_swap_post_model.dart';
import 'package:skill_swap/features/skill_swap/models/availability_range_model.dart';
import '../../../../core/theme/app_theme.dart';

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

  List<String> _selectedSkills = [];
  PostCategoryModel? _selectedCategory;
  bool _setAvailability = false;
  List<AvailabilityRangeModel> _availabilityRanges = [];
  Set<DateTime> _selectedSlots =
      {}; // Tracks exact start times of selected slots

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

    if (p?.skillToLearn != null && p!.skillToLearn.isNotEmpty) {
      _selectedSkills = p.skillToLearn.split(',').map((s) => s.trim()).toList();
    }

    if (p != null) {
      if (p.availabilitySlots != null && p.availabilitySlots!.isNotEmpty) {
        _setAvailability = true;
        _durationController.text = p.durationMinutes.toString();

        // Populate selected slots
        for (var slot in p.availabilitySlots!) {
          _selectedSlots.add(slot.startTime.toLocal());
        }

        // Reconstruct ranges for UI
        final sortedSlots = p.availabilitySlots!.toList()
          ..sort((a, b) => a.startTime.compareTo(b.startTime));

        if (sortedSlots.isNotEmpty) {
          DateTime rangeStart = sortedSlots[0].startTime.toLocal();
          DateTime rangeEnd = sortedSlots[0].endTime.toLocal();

          for (int i = 1; i < sortedSlots.length; i++) {
            final currentStart = sortedSlots[i].startTime.toLocal();
            final currentEnd = sortedSlots[i].endTime.toLocal();

            // If contiguous and same date
            if (currentStart.isAtSameMomentAs(rangeEnd) &&
                currentStart.day == rangeStart.day) {
              rangeEnd = currentEnd;
            } else {
              _availabilityRanges.add(
                AvailabilityRangeModel(
                  startTime: rangeStart,
                  endTime: rangeEnd,
                  durationMinutes: p.durationMinutes,
                ),
              );
              rangeStart = currentStart;
              rangeEnd = currentEnd;
            }
          }
          // Add the last range
          _availabilityRanges.add(
            AvailabilityRangeModel(
              startTime: rangeStart,
              endTime: rangeEnd,
              durationMinutes: p.durationMinutes,
            ),
          );
        }
      } else if (p.teachDate != null) {
        _setAvailability = true;
        // Legacy support
        try {
          if (p.teachTime != null) {
            final s = DateTime.parse(
              "${p.teachDate!}T${p.teachTime!}Z",
            ).toLocal();

            DateTime? e;
            if (p.teachEndDate != null && p.teachEndTime != null) {
              e = DateTime.parse(
                "${p.teachEndDate!}T${p.teachEndTime!}Z",
              ).toLocal();
            } else {
              e = s.add(Duration(minutes: p.durationMinutes));
            }

            final range = AvailabilityRangeModel(
              startTime: s,
              endTime: e,
              durationMinutes: p.durationMinutes,
            );
            _availabilityRanges.add(range);
            _generateSlotsForRange(range);
          }
        } catch (e) {
          debugPrint("Error parsing legacy availability: $e");
        }
        _durationController.text = p.durationMinutes.toString();
      }
    }
    context.read<GetCategoriesBloc>().add(
      const GetCategoriesEvent.getCategories(),
    );
  }

  void _generateSlotsForRange(AvailabilityRangeModel range) {
    DateTime current = range.startTime;
    while (current
            .add(Duration(minutes: range.durationMinutes))
            .isBefore(range.endTime) ||
        current
            .add(Duration(minutes: range.durationMinutes))
            .isAtSameMomentAs(range.endTime)) {
      _selectedSlots.add(current);
      current = current.add(Duration(minutes: range.durationMinutes));
    }
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

  Future<void> _addAvailabilityRange() async {
    DateTime? selectedDate = DateTime.now();
    TimeOfDay startTime = const TimeOfDay(hour: 9, minute: 0);
    TimeOfDay endTime = const TimeOfDay(hour: 17, minute: 0);

    await showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text("Add Availability Range"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: const Text("Date"),
                    subtitle: Text(
                      DateTimeUtils.formatDatePattern(
                        selectedDate!,
                        'yyyy-MM-dd',
                      ),
                    ),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate!,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 90)),
                      );
                      if (picked != null) {
                        setDialogState(() => selectedDate = picked);
                      }
                    },
                  ),
                  ListTile(
                    title: const Text("Start Time"),
                    subtitle: Text(startTime.format(context)),
                    trailing: const Icon(Icons.access_time),
                    onTap: () async {
                      final picked = await showTimePicker(
                        context: context,
                        initialTime: startTime,
                      );
                      if (picked != null) {
                        setDialogState(() => startTime = picked);
                      }
                    },
                  ),
                  ListTile(
                    title: const Text("End Time"),
                    subtitle: Text(endTime.format(context)),
                    trailing: const Icon(Icons.access_time),
                    onTap: () async {
                      final picked = await showTimePicker(
                        context: context,
                        initialTime: endTime,
                      );
                      if (picked != null) {
                        setDialogState(() => endTime = picked);
                      }
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    final start = DateTime(
                      selectedDate!.year,
                      selectedDate!.month,
                      selectedDate!.day,
                      startTime.hour,
                      startTime.minute,
                    );
                    final end = DateTime(
                      selectedDate!.year,
                      selectedDate!.month,
                      selectedDate!.day,
                      endTime.hour,
                      endTime.minute,
                    );

                    if (end.isBefore(start)) {
                      CustomToast.showError(
                        "End time must be after start time",
                      );
                      return;
                    }

                    setState(() {
                      final range = AvailabilityRangeModel(
                        startTime: start,
                        endTime: end,
                        durationMinutes:
                            int.tryParse(_durationController.text) ?? 60,
                      );
                      _availabilityRanges.add(range);
                      _generateSlotsForRange(range);
                      _availabilityRanges.sort(
                        (a, b) => a.startTime.compareTo(b.startTime),
                      );
                    });
                    Navigator.pop(dialogContext);
                  },
                  child: const Text("Add"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Map<DateTime, List<DateTime>> _getGroupedSelectedSlots() {
    final Map<DateTime, List<DateTime>> groupedSlots = {};
    final sortedSlots = _selectedSlots.toList()..sort();

    for (final slotTime in sortedSlots) {
      final date = DateTime(slotTime.year, slotTime.month, slotTime.day);
      groupedSlots.putIfAbsent(date, () => []).add(slotTime);
    }
    return groupedSlots;
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedCategory == null) {
      CustomToast.showError("Please select a category");
      return;
    }

    List<Map<String, dynamic>>? availabilitiesData;
    if (_setAvailability) {
      if (_selectedSlots.isEmpty) {
        CustomToast.showError("Please select at least one availability slot");
        return;
      }

      final duration = int.tryParse(_durationController.text) ?? 60;
      availabilitiesData = _selectedSlots.map((startTime) {
        return {
          "start_time": startTime.toUtc().toIso8601String(),
          "end_time": startTime
              .add(Duration(minutes: duration))
              .toUtc()
              .toIso8601String(),
          "duration_minutes": duration,
        };
      }).toList();
    }

    if (widget.post == null) {
      context.read<ManageSkillPostBloc>().add(
        ManageSkillPostEvent.create(
          title: _titleController.text,
          description: _descriptionController.text,
          categoryId: _selectedCategory!.id,
          skillToLearn: _selectedSkills.join(', '),
          pointsCost: int.tryParse(_pointsCostController.text) ?? 0,
          availabilities: availabilitiesData,
        ),
      );
    } else {
      context.read<ManageSkillPostBloc>().add(
        ManageSkillPostEvent.update(
          postId: widget.post!.id,
          title: _titleController.text,
          description: _descriptionController.text,
          categoryId: _selectedCategory!.id,
          skillToLearn: _selectedSkills.join(', '),
          pointsCost: int.tryParse(_pointsCostController.text) ?? 0,
          availabilities: availabilitiesData,
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

  void _addSkill(String skill) {
    final s = skill.trim();
    if (s.isNotEmpty && !_selectedSkills.contains(s)) {
      setState(() {
        _selectedSkills.add(s);
        _skillToLearnController.clear();
      });
    }
  }

  void _removeSkill(String skill) {
    setState(() {
      _selectedSkills.remove(skill);
    });
  }

  Future<void> _showSkillSelectionDialog(BuildContext context) async {
    final categoriesState = context.read<GetCategoriesBloc>().state;
    List<PostCategoryModel> categories = [];
    categoriesState.whenOrNull(loaded: (cats) => categories = cats);

    await showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text("Select Skills"),
          content: SizedBox(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: categories.map((c) {
                  final isSelected = _selectedSkills.contains(c.name);
                  return ChoiceChip(
                    label: Text(c.name),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        _addSkill(c.name);
                      } else {
                        _removeSkill(c.name);
                      }
                      Navigator.pop(dialogContext);
                      _showSkillSelectionDialog(
                        context,
                      ); // Reopen to allow multiple
                    },
                  );
                }).toList(),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text("Close"),
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
                    borderColor: Colors.transparent,

                    fillColor: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0XFF272c29)
                        : AppTheme.surfaceLight,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    label: "Description",
                    hint: "Describe what you'll teach",
                    controller: _descriptionController,
                    maxLines: 3,
                    validator: (v) =>
                        v?.isEmpty ?? true ? "Description required" : null,
                    borderColor: Colors.transparent,

                    fillColor: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0XFF272c29)
                        : AppTheme.surfaceLight,
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
                          // IconButton(
                          //   onPressed: () => context
                          //       .read<GetCategoriesBloc>()
                          //       .add(const GetCategoriesEvent.getCategories()),
                          //   icon: const Icon(Icons.refresh, size: 20),
                          //   tooltip: "Refresh categories",
                          // ),
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: CustomTextField(
                          label: "Skill you will learn",
                          hint: "e.g. Python Programming",
                          controller: _skillToLearnController,
                          validator: (v) =>
                              _selectedSkills.isEmpty && (v?.isEmpty ?? true)
                              ? "Add at least one skill"
                              : null,
                          borderColor: Colors.transparent,
                          fillColor:
                              Theme.of(context).brightness == Brightness.dark
                              ? const Color(0XFF272c29)
                              : AppTheme.surfaceLight,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        margin: const EdgeInsets.only(bottom: 4),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          onPressed: () =>
                              _addSkill(_skillToLearnController.text),
                          icon: const Icon(Icons.add, color: Colors.white),
                          tooltip: "Add custom skill",
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        margin: const EdgeInsets.only(bottom: 4),
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          onPressed: () => _showSkillSelectionDialog(context),
                          icon: Icon(
                            Icons.list,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          tooltip: "Select from list",
                        ),
                      ),
                    ],
                  ),
                  if (_selectedSkills.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _selectedSkills
                          .map(
                            (skill) => Chip(
                              label: Text(skill),
                              onDeleted: () => _removeSkill(skill),
                              deleteIcon: const Icon(Icons.close, size: 16),
                              backgroundColor: Theme.of(
                                context,
                              ).colorScheme.primary.withOpacity(0.1),
                              side: BorderSide.none,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                  const SizedBox(height: 16),
                  CustomTextField(
                    label: "Points Cost",
                    hint: "0",
                    controller: _pointsCostController,
                    type: CustomTextFieldType.number,
                    borderColor: Colors.transparent,

                    fillColor: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0XFF272c29)
                        : AppTheme.surfaceLight,
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
                    ..._availabilityRanges.asMap().entries.map((entry) {
                      final index = entry.key;
                      final range = entry.value;
                      final dateStr = DateTimeUtils.formatDatePattern(
                        range.startTime,
                        'MMM dd, yyyy',
                      );
                      final startStr = DateTimeUtils.formatTime12h(
                        range.startTime,
                      );
                      final endStr = DateTimeUtils.formatTime12h(range.endTime);

                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          title: Text("$dateStr: $startStr - $endStr"),
                          subtitle: Text("${range.durationMinutes} min slots"),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => setState(() {
                              _availabilityRanges.removeAt(index);
                              // Re-generate _selectedSlots from remaining ranges
                              _selectedSlots.clear();
                              for (var r in _availabilityRanges) {
                                _generateSlotsForRange(r);
                              }
                            }),
                          ),
                        ),
                      );
                    }).toList(),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: _addAvailabilityRange,
                            icon: const Icon(Icons.add),
                            label: const Text("Add Availability Range"),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      label: "Default Slot Duration (minutes)",
                      hint: "60",
                      controller: _durationController,
                      type: CustomTextFieldType.number,
                      borderColor: Colors.transparent,
                      fillColor: Theme.of(context).brightness == Brightness.dark
                          ? const Color(0XFF272c29)
                          : AppTheme.surfaceLight,
                    ),
                    if (_availabilityRanges.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      const Text(
                        "Manage Individual Slots:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const Text(
                        "Tap to toggle slots on/off",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const SizedBox(height: 12),
                      ..._getGroupedSelectedSlots().entries.map((group) {
                        final date = group.key;
                        final slots = group.value;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              child: Text(
                                DateTimeUtils.formatDatePattern(
                                  date,
                                  'EEEE, MMM dd',
                                ),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: slots.map((slotTime) {
                                final isSelected = _selectedSlots.contains(
                                  slotTime,
                                );
                                final duration =
                                    int.tryParse(_durationController.text) ??
                                    60;
                                return FilterChip(
                                  label: Text(
                                    "${DateTimeUtils.formatTime12h(slotTime)} - ${DateTimeUtils.formatTime12h(slotTime.add(Duration(minutes: duration)))}",
                                    style: TextStyle(
                                      decoration: isSelected
                                          ? null
                                          : TextDecoration.lineThrough,
                                      color: isSelected ? null : Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                  selected: isSelected,
                                  onSelected: (val) {
                                    setState(() {
                                      if (val) {
                                        _selectedSlots.add(slotTime);
                                      } else {
                                        _selectedSlots.remove(slotTime);
                                      }
                                    });
                                  },
                                  selectedColor: Theme.of(
                                    context,
                                  ).colorScheme.primary.withOpacity(0.2),
                                  checkmarkColor: Theme.of(
                                    context,
                                  ).colorScheme.primary,
                                );
                              }).toList(),
                            ),
                            const Divider(height: 24),
                          ],
                        );
                      }).toList(),
                    ],
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
