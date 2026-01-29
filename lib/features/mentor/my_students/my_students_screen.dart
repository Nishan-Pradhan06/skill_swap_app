import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:skill_swap/features/skill_swap/blocs/get_sessions_bloc.dart';
import 'package:skill_swap/features/skill_swap/models/session_model.dart';

class MyStudentsScreen extends StatefulWidget {
  const MyStudentsScreen({super.key});

  @override
  State<MyStudentsScreen> createState() => _MyStudentsScreenState();
}

class _MyStudentsScreenState extends State<MyStudentsScreen> {
  @override
  void initState() {
    super.initState();
    _fetchSessions();
  }

  void _fetchSessions() {
    context.read<GetSessionsBloc>().add(
      const GetSessionsEvent.fetch(role: 'mentor'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Students"),
        scrolledUnderElevation: 0,
        centerTitle: false,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _fetchSessions();
        },
        child: BlocBuilder<GetSessionsBloc, GetSessionsState>(
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox.shrink(),
              loading: () => const Center(child: CircularProgressIndicator()),
              failure: (message) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 60, color: Colors.red[300]),
                    const SizedBox(height: 16),
                    Text(
                      message,
                      style: TextStyle(color: Colors.red[300]),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              success: (data) {
                final sessions = data
                    .map(
                      (e) => SessionModel.fromJson(e as Map<String, dynamic>),
                    )
                    .where((session) => session.status == 'CONFIRMED')
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
                    return _buildStudentCard(session);
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildStudentCard(SessionModel session) {
    final learnerName =
        session.learner['full_name'] ??
        session.learner['email'] ??
        'Unknown Student';
    final learnerEmail = session.learner['email'] ?? '';
    final formattedDate = DateFormat(
      'MMM dd, yyyy',
    ).format(session.scheduledTime);
    final formattedTime = DateFormat('hh:mm a').format(session.scheduledTime);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.blue[100],
                  child: Text(
                    learnerName[0].toUpperCase(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[700],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        learnerName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (learnerEmail.isNotEmpty)
                        Text(
                          learnerEmail,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.green[300]!),
                  ),
                  child: Text(
                    'Confirmed',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[700],
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            _buildInfoRow(Icons.school, 'Skill', session.skill),
            const SizedBox(height: 8),
            _buildInfoRow(Icons.calendar_today, 'Date', formattedDate),
            const SizedBox(height: 8),
            _buildInfoRow(Icons.access_time, 'Time', formattedTime),
            const SizedBox(height: 8),
            _buildInfoRow(
              Icons.timer,
              'Duration',
              '${session.durationMinutes} minutes',
            ),
            const SizedBox(height: 8),
            _buildInfoRow(Icons.stars, 'Points', '${session.points} pts'),
            if (session.meetingLink != null && session.meetingLink!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Open meeting link
                  },
                  icon: const Icon(Icons.video_call),
                  label: const Text('Join Meeting'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 44),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.people_outline, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            "No students yet",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.grey[500],
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "When you accept booking requests,\nstudents will appear here.",
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
