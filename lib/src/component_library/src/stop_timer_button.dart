import 'package:flutter/material.dart';

class StopTimerButton extends StatelessWidget {
  const StopTimerButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.timeElapsed,
  });

  final VoidCallback? onPressed;
  final Widget icon;
  final int timeElapsed;

  @override
  Widget build(
    BuildContext context,
  ) {
    return IconButton(
      onPressed: onPressed,
      icon: icon,
    );
  }
}
