import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_swap/core/widgets/custom_appbar.dart';
import 'package:skill_swap/features/skill_swap/blocs/get_sessions_bloc.dart';
import 'package:skill_swap/features/skill_swap/blocs/handle_session_action_bloc.dart';
import 'package:skill_swap/features/skill_swap/models/session_model.dart';
import 'widgets/skill_request_card.dart';

class MentorRequestsScreen extends StatefulWidget {
  const MentorRequestsScreen({super.key});

  @override
  State<MentorRequestsScreen> createState() => _MentorRequestsScreenState();
}

class _MentorRequestsScreenState extends State<MentorRequestsScreen> {
  @override
  void initState() {
    super.initState();
    _fetchRequests();
  }

  void _fetchRequests() {
    context.read<GetSessionsBloc>().add(
      const GetSessionsEvent.fetch(role: 'mentor'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Incoming Requests"),
        scrolledUnderElevation: 0,
        centerTitle: false,
      ),
      body: BlocListener<HandleSessionActionBloc, HandleSessionActionState>(
        listener: (context, state) {
          state.maybeWhen(
            success: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message), backgroundColor: Colors.green),
              );
              _fetchRequests(); // Refresh list after action
            },
            failure: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message), backgroundColor: Colors.red),
              );
            },
            orElse: () {},
          );
        },
        child: RefreshIndicator(
          onRefresh: () async {
            _fetchRequests();
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
                      final session = sessions[index];
                      return SkillRequestCard(
                        session: session,
                        onAccept: () {
                          context.read<HandleSessionActionBloc>().add(
                            HandleSessionActionEvent.performAction(
                              sessionId: session.id,
                              action: 'accept',
                            ),
                          );
                        },
                        onReject: () {
                          context.read<HandleSessionActionBloc>().add(
                            HandleSessionActionEvent.performAction(
                              sessionId: session.id,
                              action: 'reject',
                            ),
                          );
                        },
                      );
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
          Icon(Icons.inbox_outlined, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            "No requests yet",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.grey[500],
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "When students book your skills, they will appear here.",
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey[400]),
          ),
        ],
      ),
    );
  }
}
