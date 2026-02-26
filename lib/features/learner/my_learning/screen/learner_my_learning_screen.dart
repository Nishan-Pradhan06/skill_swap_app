import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_swap/features/skill_swap/blocs/get_sessions_bloc.dart';
import 'package:skill_swap/features/skill_swap/models/session_model.dart';
import '../widgets/booking_status_card.dart';
import 'package:skill_swap/features/skill_swap/blocs/handle_session_action_bloc.dart';

class LearnerMyLearningScreen extends StatefulWidget {
  const LearnerMyLearningScreen({super.key});

  @override
  State<LearnerMyLearningScreen> createState() =>
      _LearnerMyLearningScreenState();
}

class _LearnerMyLearningScreenState extends State<LearnerMyLearningScreen> {
  @override
  void initState() {
    super.initState();
    _fetchBookings();
  }

  void _fetchBookings() {
    context.read<GetSessionsBloc>().add(
      const GetSessionsEvent.fetch(role: 'learner'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Learning"),
        scrolledUnderElevation: 0,
        centerTitle: false,
      ),
      body: BlocListener<HandleSessionActionBloc, HandleSessionActionState>(
        listener: (context, state) {
          state.whenOrNull(
            success: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message), backgroundColor: Colors.green),
              );
              _fetchBookings();
            },
            failure: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message), backgroundColor: Colors.red),
              );
            },
          );
        },
        child: RefreshIndicator(
          onRefresh: () async {
            _fetchBookings();
          },
          child: BlocBuilder<GetSessionsBloc, GetSessionsState>(
            builder: (context, state) {
              return state.when(
                initial: () => const SizedBox.shrink(),
                loading: () => const Center(child: CircularProgressIndicator()),
                failure: (message) => Center(child: Text(message)),
                success: (data) {
                  final sessions = data
                      .map(
                        (e) => SessionModel.fromJson(e as Map<String, dynamic>),
                      )
                      .where((s) => s.status == 'CONFIRMED')
                      .toList();

                  if (sessions.isEmpty) {
                    return _buildEmptyState(context);
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    itemCount: sessions.length,
                    itemBuilder: (context, index) {
                      return BookingStatusCard(session: sessions[index]);
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.school_outlined, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            "No bookings yet",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.grey[500],
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Book a session with a mentor to start your learning journey!",
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey[400]),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              // Navigate to home or discovery
            },
            child: const Text("Explore Skills"),
          ),
        ],
      ),
    );
  }
}
