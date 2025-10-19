import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// Enum to control title alignment in CustomAppBar
enum TitleAlignment { center, left }

/// A custom AppBar widget built by developer.
/// Supports title, actions, leading, background color, elevation, optional height, title alignment, and automatically adding back button.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  final double elevation;
  final List<Widget>? actions;
  final Widget? leading;
  final double? height;
  final TitleAlignment titleAlignment;
  final bool automaticallyImplyLeading;

  const CustomAppBar({
    super.key,
    required this.title,
    this.backgroundColor = Colors.white,
    this.elevation = 0.01,
    this.actions,
    this.leading,
    this.height,
    this.titleAlignment = TitleAlignment.center,
    this.automaticallyImplyLeading = true,
  });

  @override
  Size get preferredSize => Size.fromHeight(height ?? kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    Widget? leadingWidget = leading;

    // Automatically add a back button if implied and possible
    if (leadingWidget == null &&
        automaticallyImplyLeading &&
        Navigator.canPop(context)) {
      leadingWidget = IconButton(
        onPressed: () => Navigator.pop(context),
        icon: SvgPicture.asset('assets/icons/back.svg'),
      );
    }

    return Material(
      color: backgroundColor,
      elevation: elevation,
      child: SafeArea(
        child: Container(
          height: preferredSize.height,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              leadingWidget ?? const SizedBox.shrink(),
              Expanded(
                child: Align(
                  alignment: titleAlignment == TitleAlignment.center
                      ? Alignment.center
                      : Alignment.centerLeft,
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF6B48FF),
                    ),
                  ),
                ),
              ),
              if (actions != null) ...actions!,
            ],
          ),
        ),
      ),
    );
  }
}

class CustomBackButton extends StatelessWidget {
  final String svgAssetPath;
  final double size;
  final Color? color;
  final VoidCallback? onPressed;

  const CustomBackButton({
    super.key,
    required this.svgAssetPath,
    this.size = 24,
    this.color,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset(
        svgAssetPath,
        width: size,
        height: size,
        colorFilter: color != null
            ? ColorFilter.mode(color!, BlendMode.srcIn)
            : null,
      ),
      onPressed:
          onPressed ??
          () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
    );
  }
}
