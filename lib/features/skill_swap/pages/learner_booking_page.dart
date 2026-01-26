import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_swap/core/di/dependency_injection.dart';
import 'package:skill_swap/core/widgets/custom_padding.dart';
import 'package:skill_swap/core/widgets/custom_toast.dart';
import 'package:skill_swap/features/skill_swap/blocs/booking_bloc.dart';
import 'package:skill_swap/features/skill_swap/repositories/skill_swap_repository.dart';
import 'package:skill_swap/features/skill_swap/models/availability_slot_model.dart';

class LearnerBookingPage extends StatefulWidget {
  final int mentorId;
  final int? postId;
  final String? skillTitle;
  final int pointsCost;
  const LearnerBookingPage({
    super.key,
    required this.mentorId,
    required this.pointsCost,
    this.postId,
    this.skillTitle,
  });

  @override
  State<LearnerBookingPage> createState() => _LearnerBookingPageState();
}

class _LearnerBookingPageState extends State<LearnerBookingPage> {
  List<AvailabilitySlotModel> _slots = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSlots();
  }

  Future<void> _loadSlots() async {
    final result = await sl<SkillSwapRepository>().getAvailability(
      mentorId: widget.mentorId,
      postId: widget.postId,
    );
    result.fold(
      (failure) => CustomToast.showError(failure.message),
      (slots) => setState(() {
        _slots = slots;
        _isLoading = false;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<BookingBloc>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Book Session')),
        body: BlocListener<BookingBloc, BookingState>(
          listener: (context, state) {
            state.whenOrNull(
              success: (message) {
                CustomToast.showSuccess(message);
                _loadSlots(); // Reload slots
              },
              failure: (message) => CustomToast.showError(message),
            );
          },
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.secondaryContainer.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Session Cost",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${widget.pointsCost} Points",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Duration",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "60 Minutes",
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "Select an available slot below",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: CustomPadding(
                        child: ListView.builder(
                          itemCount: _slots.length,
                          itemBuilder: (context, index) {
                            final slot = _slots[index];
                            return Card(
                              child: ListTile(
                                title: Text("${slot.startTime.toLocal()}"),
                                subtitle: Text(
                                  slot.isBooked ? "Booked" : "Available",
                                ),
                                trailing: slot.isBooked
                                    ? const Text(
                                        "Unavailable",
                                        style: TextStyle(color: Colors.red),
                                      )
                                    : Builder(
                                        builder: (context) {
                                          final bookingState = context
                                              .watch<BookingBloc>()
                                              .state;
                                          final isBooking = bookingState
                                              .maybeWhen(
                                                loading: () => true,
                                                orElse: () => false,
                                              );

                                          return ElevatedButton(
                                            onPressed: isBooking
                                                ? null
                                                : () {
                                                    context
                                                        .read<BookingBloc>()
                                                        .add(
                                                          BookingEvent.book(
                                                            mentorId:
                                                                widget.mentorId,
                                                            slotId: slot.id,
                                                            skill:
                                                                widget
                                                                    .skillTitle ??
                                                                "General",
                                                            points: widget
                                                                .pointsCost,
                                                            scheduledTime:
                                                                slot.startTime,
                                                            durationMinutes: 60,
                                                          ),
                                                        );
                                                  },
                                            child: const Text("Book"),
                                          );
                                        },
                                      ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
