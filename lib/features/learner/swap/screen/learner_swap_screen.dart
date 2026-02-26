import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_swap/features/skill_swap/blocs/get_sessions_bloc.dart';
import 'package:skill_swap/features/skill_swap/models/session_model.dart';
import 'package:skill_swap/features/learner/swap/screen/pending_swaps_tab.dart';

class LearnerSwapScreen extends StatefulWidget {
  const LearnerSwapScreen({super.key});

  @override
  State<LearnerSwapScreen> createState() => _LearnerSwapScreenState();
}

class _LearnerSwapScreenState extends State<LearnerSwapScreen> {
  @override
  void initState() {
    super.initState();
    _fetchSessions();
  }

  void _fetchSessions() {
    context.read<GetSessionsBloc>().add(
      const GetSessionsEvent.fetch(role: 'learner'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Swaps'),
          scrolledUnderElevation: 0,
          elevation: 0,
          centerTitle: false,
          bottom: TabBar(
            isScrollable: true,
            splashBorderRadius: const BorderRadius.all(Radius.circular(8)),
            tabAlignment: TabAlignment.start,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            labelPadding: const EdgeInsets.symmetric(horizontal: 15),
            dividerColor: Theme.of(context).colorScheme.surface,
            labelColor: Theme.of(context).colorScheme.primary,
            unselectedLabelColor: Colors.grey,
            tabs: const [
              Tab(text: 'Pending'),
              Tab(text: 'Active'),
              Tab(text: 'Completed'),
            ],
          ),
        ),
        body: BlocBuilder<GetSessionsBloc, GetSessionsState>(
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
                    .toList();

                final pendingSessions = sessions
                    .where((s) => s.status == 'PENDING')
                    .toList();
                final activeSessions = sessions
                    .where((s) => s.status == 'CONFIRMED')
                    .toList();
                final completedSessions = sessions
                    .where(
                      (s) =>
                          s.status == 'COMPLETED' ||
                          s.status == 'REJECTED' ||
                          s.status == 'CANCELLED',
                    )
                    .toList();

                return TabBarView(
                  children: [
                    PendingSwaps(sessions: pendingSessions),
                    PendingSwaps(
                      sessions: activeSessions,
                      emptyMessage: 'No active sessions',
                    ),
                    PendingSwaps(
                      sessions: completedSessions,
                      emptyMessage: 'No completed sessions',
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
