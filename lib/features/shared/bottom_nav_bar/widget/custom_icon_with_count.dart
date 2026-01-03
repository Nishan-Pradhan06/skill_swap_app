import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../notifications/bloc/get_notification_count/get_notification_count_bloc.dart';

class IconWithCount extends StatelessWidget {
  final IconData? icon;
  const IconWithCount({super.key, this.icon});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetNotificationCountBloc, GetNotificationCountState>(
      builder: (context, state) {
        int count = 0;

        state.whenOrNull(
          loaded: (value) {
            count = value;
          },
        );

        return Stack(
          clipBehavior: Clip.none,
          children: [
             Icon(icon),

            if (count > 0)
              Positioned(
                right: -2,
                top: -2,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: ColorScheme.of(
                      context,
                    ).errorContainer.withValues(alpha: .9),
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 15,
                    minHeight: 15,
                  ),
                  child: Center(
                    child: Text(
                      count.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
