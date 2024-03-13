import 'package:flutter/material.dart';
import 'package:ostra/ui/views/timer/timer.dart';
import 'package:stacked/stacked.dart';

class StopTimerButton extends StackedView<ActivityListViewModel> {
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
  Widget builder(BuildContext context, viewModel, Widget? child) {
    return IconButton(
      onPressed: onSave == null
          ? null
          : () {
              onSave?.call();
              viewModel.saveActivity(
                'title',
                'desc',
                // TODO(shadyaziza): what the hell is time elapsed :D
                timeElapsed,
              );
            },
      icon: icon,
    );
  }

  @override
  viewModelBuilder(BuildContext context) => ActivityListViewModel();
}
