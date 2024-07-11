import 'package:flutter/material.dart';

class VoiceCopilotButton extends StatelessWidget {
  final Color backgroundColor;
  final IconData icon;
  final Color? iconColor;
  final double? iconSize;
  final double? borderRadius;
  final double? margin;
  final double? padding;
  final Function()? function;
  const VoiceCopilotButton({
    required this.backgroundColor,
    required this.icon,
    this.iconColor,
    this.function,
    this.iconSize,
    this.borderRadius,
    this.margin,
    this.padding,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius ?? 20),
        ),
        padding: EdgeInsets.all(padding ?? 25),
        margin: EdgeInsets.all(margin ?? 5),
        child: Icon(
          icon,
          color: iconColor ?? Colors.white,
          size: iconSize ?? 35,
        ),
      ),
    );
  }
}
