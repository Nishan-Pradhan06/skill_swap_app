import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
  final bool isGradient;
  final double? height;
  final double? width;
  final Color backgroundColor;
  final double svgSize;
  final EdgeInsetsGeometry padding;
  final List<Color>? gradientColors;
  final bool showSvgOverlay;
  final String svgOverlayPath;
  final void Function()? onTap;
  final EdgeInsetsGeometry? margin;
  final BorderRadiusGeometry? borderRadius;
  final BorderRadiusGeometry? clipRRectBorderRadius;

  /// NEW: Wrap with IntrinsicHeight when true
  final bool useIntrinsicHeight;

  const CustomContainer({
    super.key,
    required this.child,
    this.isGradient = false,
    this.height,
    this.width,
    this.backgroundColor = Colors.white,
    this.svgSize = 100,
    this.padding = const EdgeInsets.all(16),
    this.gradientColors,
    this.showSvgOverlay = false,
    this.svgOverlayPath = 'assets/svg/overlay.svg',
    this.onTap,
    this.useIntrinsicHeight = false, // default off
    this.margin,
    this.borderRadius,
    this.clipRRectBorderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final container = GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin,
        height: useIntrinsicHeight
            ? null // let IntrinsicHeight handle it
            : (height ?? MediaQuery.sizeOf(context).height / 4.5),
        width: width ?? MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(20),
          gradient: isGradient
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors:
                      gradientColors ??
                      const [Color(0xFF6B48FF), Color(0xFF40C4FF)],
                )
              : null,
          color: isGradient ? null : backgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 5,
              spreadRadius: 0.2,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: clipRRectBorderRadius ?? BorderRadius.circular(20),
          child: Stack(
            children: [
              // Main content
              Padding(padding: padding, child: child),

              // Optional SVG overlay
              if (showSvgOverlay)
                Positioned(
                  top: 0,
                  right: 0,
                  child: SvgPicture.asset(
                    svgOverlayPath,
                    height: svgSize,
                    width: svgSize,
                    fit: BoxFit.cover,
                  ),
                ),
            ],
          ),
        ),
      ),
    );

    return useIntrinsicHeight ? IntrinsicHeight(child: container) : container;
  }
}
