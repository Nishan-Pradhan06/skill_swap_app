import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;

  // Customization options
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Gradient? gradient;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry padding;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final Color? borderColor;
  final double borderWidth;
  final bool isDisabled;
  final List<BoxShadow>? boxShadow;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.width,
    this.height,
    this.backgroundColor,
    this.gradient,
    this.textColor = Colors.white,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w600,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.leadingIcon,
    this.trailingIcon,
    this.borderColor,
    this.borderWidth = 0,
    this.isDisabled = false,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    const Color defaultEnabledColor = Color(0xFF6B48FF);
    const Color defaultDisabledColor = Color.fromARGB(87, 107, 70, 193);

    final Color effectiveColor =
        backgroundColor ??
        (isDisabled ? defaultDisabledColor : defaultEnabledColor);

    return AbsorbPointer(
      absorbing: isDisabled || isLoading,
      child: SizedBox(
        width: width,
        height: height,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: gradient,
            color: gradient == null ? effectiveColor : null,
            borderRadius: borderRadius,
            border: borderColor != null
                ? Border.all(color: borderColor!, width: borderWidth)
                : null,
            boxShadow: boxShadow,
          ),
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(borderRadius: borderRadius),
              padding: EdgeInsets.zero,
              minimumSize: Size(width ?? 0, height ?? 0),
            ),
            child: Align(
              // ✅ ensures vertical + horizontal centering
              alignment: Alignment.center,
              child: Padding(
                padding: padding,
                child: isLoading
                    ? const SizedBox(
                        height: 22,
                        width: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: Colors.white,
                        ),
                      )
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (leadingIcon != null) ...[
                            leadingIcon!,
                            const SizedBox(width: 8),
                          ],
                          Text(
                            text,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: textColor,
                              fontSize: fontSize,
                              fontWeight: fontWeight,
                            ),
                          ),
                          if (trailingIcon != null) ...[
                            const SizedBox(width: 8),
                            trailingIcon!,
                          ],
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
