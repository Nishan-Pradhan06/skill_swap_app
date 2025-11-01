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
        vertical: 0,
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
                      'https://scontent.fbdp2-1.fna.fbcdn.net/v/t39.30808-6/357720692_1633633700482790_3750526617895490452_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=6ee11a&_nc_eui2=AeHWAq9_r27J3XQrlPQ-b_JUEyGQJfikjFsTIZAl-KSMWwbH_DyL0jlSK7OS8xPX9HAgOLME2YwNnxveoY-R8waL&_nc_ohc=jTaUJfge-bcQ7kNvwEImS61&_nc_oc=Adk0WAWO0epSZa-eY1J9Jb_G4hcLn0I2jvTO7trHCqUtD0x4qZpIrSOHg0pclDc_C7JdLjnVtaCT40ll49cajZha&_nc_zt=23&_nc_ht=scontent.fbdp2-1.fna&_nc_gid=SiEn8qgUaybLk1TnaPlm7A&oh=00_AfcnfwUHNF1WmrTukeM4nGSZHGmqFQLP9xiUNKfpgpuQRg&oe=690BE537',
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
