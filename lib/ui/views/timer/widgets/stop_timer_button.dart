import 'package:flutter/material.dart';
import 'package:ostra/ui/views/timer/timer.dart';

class StopTimerButton extends StatelessWidget {
  const StopTimerButton({
    super.key,
    required this.onSave,
    required this.icon,
    required this.timeElapsed,
  });

  final VoidCallback? onSave;
  final Widget icon;
  final int timeElapsed;

  @override
  Widget build(
    BuildContext context,
  ) {
    return IconButton(
      onPressed: onSave == null
          ? null
          : () {
              onSave?.call();
              // viewModel.saveActivity(
              //   'title',
              //   'desc',
              //   // TODO(shadyaziza): what the hell is time elapsed :D
              //   timeElapsed,
              // );
            },
      icon: icon,
    );
  }
}
