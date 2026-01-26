import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_swap/core/di/dependency_injection.dart';
import 'package:skill_swap/core/widgets/custom_button.dart';
import 'package:skill_swap/core/widgets/custom_padding.dart';
import 'package:skill_swap/core/widgets/custom_toast.dart';
import 'package:skill_swap/features/skill_swap/blocs/availability_bloc.dart';

class TeacherDashboardPage extends StatelessWidget {
  const TeacherDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          sl<AvailabilityBloc>()..add(const AvailabilityEvent.load()),
      child: Scaffold(
        appBar: AppBar(title: const Text('My Availability')),
        body: BlocConsumer<AvailabilityBloc, AvailabilityState>(
          listener: (context, state) {
            state.whenOrNull(
              success: (message) => CustomToast.showSuccess(message),
              failure: (message) => CustomToast.showError(message),
            );
          },
          builder: (context, state) {
            return CustomPadding(
              child: Column(
                children: [
                  _buildSetAvailabilityForm(context),
                  const SizedBox(height: 20),
                  const Divider(),
                  const Text(
                    "My Slots",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: state.maybeWhen(
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      loaded: (slots) => ListView.builder(
                        itemCount: slots.length,
                        itemBuilder: (context, index) {
                          final slot = slots[index];
                          return ListTile(
                            title: Text("${slot.startTime.toLocal()}"),
                            subtitle: Text(
                              slot.isBooked ? "Booked" : "Available",
                            ),
                            trailing: slot.isBooked
                                ? const Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                  )
                                : const Icon(
                                    Icons.circle_outlined,
                                    color: Colors.grey,
                                  ),
                          );
                        },
                      ),
                      orElse: () => const SizedBox(),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSetAvailabilityForm(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text("Add Availability", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            CustomButton(
              text: "Select Time Range",
              onPressed: () async {
                final date = await showDatePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 30)),
                  initialDate: DateTime.now(),
                );
                if (!context.mounted) return;

                if (date != null) {
                  // Simplified time picking for MVP: 9 AM to 5 PM
                  context.read<AvailabilityBloc>().add(
                    AvailabilityEvent.set(
                      startTime: date.copyWith(hour: 9),
                      endTime: date.copyWith(hour: 17),
                      durationMinutes: 60,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

extension DateCopyWith on DateTime {
  DateTime copyWith({int? year, int? month, int? day, int? hour, int? minute}) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
    );
  }
}
