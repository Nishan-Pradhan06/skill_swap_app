import 'package:flutter/material.dart';
import 'package:animated_read_more_text/animated_read_more_text.dart';

class CustomReadMoreText extends StatelessWidget {
  final String text;
  final int maxLines;
  final TextStyle? textStyle;
  final TextStyle? buttonTextStyle;
  final bool isSuffixButton;
  final bool allowCollapse;
  final bool expandOnTextTap;
  final Curve animationCurve;
  final Duration animationDuration;

  const CustomReadMoreText({
    super.key,
    required this.text,
    this.maxLines = 4,
    this.textStyle,
    this.buttonTextStyle,
    this.isSuffixButton = true,
    this.allowCollapse = true,
    this.expandOnTextTap = true,
    this.animationCurve = Curves.easeOutBack,
    this.animationDuration = const Duration(milliseconds: 300),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedReadMoreText(
      text,
      maxLines: maxLines,
      textStyle:
          textStyle ??
          TextStyle(
            fontSize: 14,
            color: theme.textTheme.bodyMedium?.color ?? Colors.black87,
            height: 1.4,
          ),
      buttonTextStyle:
          buttonTextStyle ??
          TextStyle(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
      isSuffixButton: isSuffixButton,
      allowCollapse: allowCollapse,
      expandOnTextTap: expandOnTextTap,
      animationCurve: animationCurve,
      animationDuration: animationDuration,
    );
  }
}
