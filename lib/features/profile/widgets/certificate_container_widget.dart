import 'package:flutter/material.dart';

import '../../../core/widgets/custom_container.dart';

class ContainerWithImageWidget extends StatelessWidget {
  final String certificateImageUrl;
  final String certificateTitle;
  final void Function()? onTap;
  const ContainerWithImageWidget({
    super.key,
    required this.certificateImageUrl,
    required this.certificateTitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      onTap: onTap,
      useIntrinsicHeight: true,
      useIntrinsicWidth: true,
      padding: EdgeInsetsGeometry.all(0),
      clipRRectBorderRadius: BorderRadius.circular(8),
      borderRadius: BorderRadius.circular(8),
      child: Stack(
        children: [
          Image.network(certificateImageUrl, height: 200),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
              width: double.infinity,
              color: Theme.of(context).colorScheme.surface,
              child: Text(
                certificateTitle,
                style: TextTheme.of(context).bodySmall?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
