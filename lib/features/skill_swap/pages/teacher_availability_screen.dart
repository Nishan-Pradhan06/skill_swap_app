import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:skill_swap/core/widgets/custom_padding.dart';
import 'package:skill_swap/core/widgets/custom_toast.dart';
import 'package:skill_swap/features/skill_swap/blocs/availability_bloc.dart';
import 'package:skill_swap/features/skill_swap/blocs/get_skill_swap_posts_bloc.dart';
import 'package:skill_swap/features/skill_swap/models/skill_swap_post_model.dart';

class TeacherAvailabilityScreen extends StatefulWidget {
  const TeacherAvailabilityScreen({super.key});

  @override
  State<TeacherAvailabilityScreen> createState() =>
      _TeacherAvailabilityScreenState();
}

class _TeacherAvailabilityScreenState extends State<TeacherAvailabilityScreen> {
  DateTime? _startDate;
  TimeOfDay? _startTime;
  DateTime? _endDate;
  TimeOfDay? _endTime;
  final TextEditingController _durationController = TextEditingController(
    text: '60',
  );
  SkillSwapPostModel? _selectedPost;

  @override
  void initState() {
    super.initState();
    context.read<AvailabilityBloc>().add(const AvailabilityEvent.load());
  }

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
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

  void _submitAvailability() {
    if (_startDate == null ||
        _startTime == null ||
        _endDate == null ||
        _endTime == null) {
      CustomToast.showError("Please select all date and time fields");
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

    context.read<AvailabilityBloc>().add(
      AvailabilityEvent.set(
        startTime: startDateTime,
        endTime: endDateTime,
        durationMinutes: int.tryParse(_durationController.text) ?? 60,
        postId: _selectedPost?.id,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Availability')),
      body: BlocConsumer<AvailabilityBloc, AvailabilityState>(
        listener: (context, state) {
          state.whenOrNull(
            success: (message) {
              CustomToast.showSuccess(message);
              // Reset fields after successful set if needed
            },
            failure: (message) => CustomToast.showError(message),
          );
        },
        builder: (context, state) {
          return CustomPadding(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Select Skill to Set Availability",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                BlocBuilder<GetSkillSwapPostsBloc, GetSkillSwapPostsState>(
                  builder: (context, postState) {
                    return postState.maybeWhen(
                      loaded: (posts) {
                        // Filter posts by current user if necessary
                        // Assuming GetSkillSwapPostsBloc already has them or we filter here
                        // For simplicity, showing all posts for now, but usually it should be sl<GetProfileBloc>().state.user.id
                        return DropdownButtonFormField<SkillSwapPostModel>(
                          initialValue: _selectedPost,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Select Skill Post",
                          ),
                          items: posts.map((post) {
                            return DropdownMenuItem(
                              value: post,
                              child: Text(post.title),
                            );
                          }).toList(),
                          onChanged: (val) {
                            setState(() {
                              _selectedPost = val;
                            });
                            // Optionally reload slots for this post
                            context.read<AvailabilityBloc>().add(
                              AvailabilityEvent.load(postId: val?.id),
                            );
                          },
                        );
                      },
                      loading: () => const LinearProgressIndicator(),
                      orElse: () => const Text(
                        "No skills found. Create a skill post first.",
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),
                const Text(
                  "Set Time Window",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => _selectDate(context, true),
                        child: Text(
                          _startDate == null
                              ? "Start Date"
                              : DateFormat('yyyy-MM-dd').format(_startDate!),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => _selectTime(context, true),
                        child: Text(
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
                      child: OutlinedButton(
                        onPressed: () => _selectDate(context, false),
                        child: Text(
                          _endDate == null
                              ? "End Date"
                              : DateFormat('yyyy-MM-dd').format(_endDate!),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => _selectTime(context, false),
                        child: Text(
                          _endTime == null
                              ? "End Time"
                              : _endTime!.format(context),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _durationController,
                  decoration: const InputDecoration(
                    labelText: "Session Duration (minutes)",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: state.maybeWhen(
                      loading: () => null,
                      orElse: () => _submitAvailability,
                    ),
                    child: state.maybeWhen(
                      loading: () => const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      orElse: () => const Text("Create Slots"),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  "Current Slots",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: state.maybeWhen(
                    loaded: (slots) {
                      if (slots.isEmpty) {
                        return const Center(
                          child: Text("No slots created yet"),
                        );
                      }
                      return ListView.builder(
                        itemCount: slots.length,
                        itemBuilder: (context, index) {
                          final slot = slots[index];
                          return Card(
                            child: ListTile(
                              title: Text(
                                DateFormat(
                                  'MMM dd, yyyy - HH:mm',
                                ).format(slot.startTime),
                              ),
                              subtitle: Text(
                                "${slot.isBooked ? "Booked" : "Available"} ${slot.postId != null ? "(Post #${slot.postId})" : ""}",
                              ),
                              trailing: Icon(
                                slot.isBooked
                                    ? Icons.lock
                                    : Icons.check_circle_outline,
                                color: slot.isBooked
                                    ? Colors.red
                                    : Colors.green,
                              ),
                            ),
                          );
                        },
                      );
                    },
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    orElse: () => const SizedBox.shrink(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
