import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:skill_swap/core/widgets/custom_padding.dart';
import 'package:skill_swap/router/app_routes_names.dart';
import '../../../../core/theme/app_theme.dart';

class CustomProfileHeader extends StatelessWidget {
  final bool isLoading;

  const CustomProfileHeader({super.key, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      child: CustomPadding(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                GestureDetector(
                  onTap: () {
                    context.pushNamed(AppRoutesName.profileScreenRoute);
                  },
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      'https://media.licdn.com/dms/image/v2/D4D03AQFnlTDji6hFzw/profile-displayphoto-shrink_400_400/profile-displayphoto-shrink_400_400/0/1703435442674?e=1762992000&v=beta&t=hPkwUus4-obeAXp7s1Wm_belXU6dQenEbQgJYpWgXFk',
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nishan Pradhan',
                      style: TextTheme.of(context).bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text('Learner', style: TextTheme.of(context).bodySmall),
                  ],
                ),
              ],
            ),
            Container(
              height: 40,
              width: 65,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Row(
                  spacing: 4,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '120',
                      style: TextTheme.of(context).bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: AppTheme.backgroundLight,
                      ),
                    ),
                    Image.asset('assets/images/coin.png', height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
