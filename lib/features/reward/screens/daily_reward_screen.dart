import 'package:confetti/confetti.dart';
import 'package:skill_swap/core/widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:skill_swap/features/profile/bloc/get_profile/get_profile_bloc.dart';
import 'package:skill_swap/router/app_routes_names.dart';
import '../blocs/reward_bloc.dart';

class DailyRewardScreen extends StatefulWidget {
  const DailyRewardScreen({super.key});

  @override
  State<DailyRewardScreen> createState() => _DailyRewardScreenState();
}

class _DailyRewardScreenState extends State<DailyRewardScreen> {
  late ConfettiController _confettiController;
  bool alreadyClaimed = false;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 2),
    );

    //Check if already claimed today based on profile data
    final profileState = context.read<GetProfileBloc>().state;
    profileState.maybeWhen(
      loaded: (data) {
        if (data.lastLoginRewardPoints != null) {
          final today = DateTime.now();
          final lastReward = data.lastLoginRewardPoints!;
          if (lastReward.year == today.year &&
              lastReward.month == today.month &&
              lastReward.day == today.day) {
            setState(() {
              alreadyClaimed = true;
            });
            return; // Exit if marked as claimed based on last reward
          }
        }

        // Also check if created_at is today (new user)
        if (data.createdAt != null) {
          final today = DateTime.now();
          final created = data.createdAt!;
          if (created.year == today.year &&
              created.month == today.month &&
              created.day == today.day) {
            setState(() {
              alreadyClaimed = true;
            });
          }
        }
      },
      orElse: () {},
    );
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _claimReward() {
    context.read<RewardBloc>().add(const RewardEvent.claimReward());
  }

  List<DateTime> _getCurrentWeekDays() {
    final now = DateTime.now();
    final currentWeekDay = now.weekday; // 1 = Monday, 7 = Sunday
    final firstDayOfWeek = now.subtract(Duration(days: currentWeekDay - 1));
    return List.generate(
      7,
      (index) => firstDayOfWeek.add(Duration(days: index)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final weekDays = _getCurrentWeekDays();
    final today = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Daily Reward",
          style: GoogleFonts.outfit(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: BackButton(
          color: Theme.of(context).iconTheme.color,
          onPressed: () => context.pop(),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Background design
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                  Theme.of(context).scaffoldBackgroundColor,
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Header Image
                Image.asset('assets/images/coin.png', height: 120, width: 120),
                const SizedBox(height: 20),

                Text(
                  alreadyClaimed
                      ? "You've collected today's reward!"
                      : "Claim your Daily Reward!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Log in every day to earn more points.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(height: 40),

                // 7-Day List
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: weekDays.map((day) {
                      final isToday =
                          day.year == today.year &&
                          day.month == today.month &&
                          day.day == today.day;
                      final isPast = day.isBefore(
                        DateTime(today.year, today.month, today.day),
                      );
                      final dayName = _getDayName(day.weekday);

                      return _buildDayItem(
                        context,
                        dayName: dayName,
                        points: "10", // Assuming constant points for now
                        isToday: isToday,
                        isPast: isPast,
                        isClaimed: isToday
                            ? alreadyClaimed
                            : isPast, // Simple visual logic
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 50),

                // Action Button
                BlocConsumer<RewardBloc, RewardState>(
                  listener: (context, state) {
                    state.whenOrNull(
                      success: (message) {
                        _confettiController.play();
                        setState(() {
                          alreadyClaimed = true;
                        });
                        context.read<GetProfileBloc>().add(
                          const GetProfileEvent.getProfile(),
                        );
                        CustomToast.showSuccess(message);
                      },
                      failure: (message) {
                        CustomToast.showError(message);
                      },
                    );
                  },
                  builder: (context, state) {
                    return state.maybeWhen(
                      loading: () => const CircularProgressIndicator(),
                      orElse: () {
                        if (alreadyClaimed) {
                          return _buildClaimedButton(context);
                        }
                        return _buildClaimButton(context);
                      },
                    );
                  },
                ),
                const SizedBox(height: 20),

                // Navigate to Purchase Points
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      context.pushNamed(AppRoutesName.purchasePointScreenRoute);
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Get More Points',
                      style: GoogleFonts.outfit(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Confetti
          // Align(
          //   alignment: Alignment.topCenter,
          //   child: ConfettiWidget(
          //     confettiController: _confettiController,
          //     blastDirectionality: BlastDirectionality.explosive,
          //     shouldLoop: false,
          //     colors: const [
          //       Colors.green,
          //       Colors.blue,
          //       Colors.pink,
          //       Colors.orange,
          //       Colors.purple,
          //       Colors.amber,
          //     ],
          //     createParticlePath: drawStar,
          //     emissionFrequency: 0.05,
          //     numberOfParticles: 20,
          //     gravity: 0.2,
          //   ),
          // ),
        ],
      ),
    );
  }

  String _getDayName(int weekday) {
    switch (weekday) {
      case 1:
        return "Mon";
      case 2:
        return "Tue";
      case 3:
        return "Wed";
      case 4:
        return "Thu";
      case 5:
        return "Fri";
      case 6:
        return "Sat";
      case 7:
        return "Sun";
      default:
        return "";
    }
  }

  Widget _buildDayItem(
    BuildContext context, {
    required String dayName,
    required String points,
    required bool isToday,
    required bool isPast,
    required bool isClaimed,
  }) {
    final activeColor = Theme.of(context).colorScheme.primary;
    final inactiveColor = Theme.of(
      context,
    ).disabledColor.withValues(alpha: 0.2);

    return Column(
      children: [
        Text(
          dayName,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isToday
                ? activeColor
                : Theme.of(
                    context,
                  ).textTheme.bodyMedium?.color?.withValues(alpha: 0.6),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 40,
          height: 50,
          decoration: BoxDecoration(
            color: isToday
                ? activeColor
                : (isClaimed
                      ? activeColor.withValues(alpha: 0.2)
                      : inactiveColor),
            borderRadius: BorderRadius.circular(12),
            border: isToday ? Border.all(color: activeColor, width: 2) : null,
          ),
          child: Center(
            child: isClaimed || isPast
                ? Icon(
                    Icons.check_rounded,
                    color: isToday ? Colors.white : activeColor,
                    size: 20,
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/coin.png',
                        width: 16,
                        height: 16,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        points,
                        style: GoogleFonts.outfit(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: isToday
                              ? Colors.white
                              : Theme.of(context).textTheme.bodyLarge?.color
                                    ?.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildClaimButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _claimReward,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
          shadowColor: Theme.of(
            context,
          ).colorScheme.primary.withValues(alpha: 0.4),
        ),
        child: Text(
          'Claim Points',
          style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildClaimedButton(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle_rounded, color: Colors.green),
          const SizedBox(width: 8),
          Text(
            'Come back tomorrow',
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Theme.of(
                context,
              ).textTheme.bodyLarge?.color?.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }

  Path drawStar(Size size) {
    // Method to draw star
    double degToRad(double deg) => deg * (3.1415926535897932 / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    // final internalRadius = halfWidth / 2.5;
    final degreesPerStep = 360 / numberOfPoints;
    // final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degToRad(degreesPerStep)) {
      path.lineTo(
        halfWidth + externalRadius * 1 * db(step),
        halfWidth + externalRadius * 1 * db(step),
      ); // simple placeholder logic for star
    }
    path.close();
    return path;
  }

  double db(double val) => val; // Dummy
}
