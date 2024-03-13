import 'package:flutter/material.dart';
import 'package:ostra/app/app.locator.dart';
import 'package:ostra/services/theme_service.dart';
import 'package:ostra/ui/common/common.dart';
import 'package:ostra/ui/views/timer/timer.dart';
import 'package:ostra/utils/utils.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'package:stacked/stacked.dart';

class TimerView extends StackedView<TimerViewModel> {
  const TimerView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    TimerViewModel viewModel,
    Widget? child,
  ) {
    final themeService = locator<ThemeService>();
    return Scaffold(
      appBar: AppBar(
        title: const OstraTitle(),
        centerTitle: false,
        actions: [
          ThemeButton(themeService: themeService),
        ],
      ),
      bottomNavigationBar: Container(
        height: 82,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            StartResumeTimerButton(
              onPressed: (!viewModel.isActive) || viewModel.isPaused
                  ? viewModel.resumeTimer
                  : null,
              color: (!viewModel.isActive) || viewModel.isPaused
                  ? Theme.of(context).primary
                  : null,
            ),
            PauseTimerButton(
              onPressed: viewModel.isActive ? viewModel.pauseTimer : null,
              color: viewModel.isActive ? Theme.of(context).primary : null,
            ),
            StopTimerButton(
              timeElapsed: 20,
              onSave: viewModel.isActive || viewModel.isPaused
                  ? viewModel.stopTimer
                  : null,
              icon: PhosphorIcon(
                PhosphorIcons.stop(PhosphorIconsStyle.duotone),
                color: viewModel.isActive || viewModel.isPaused
                    ? Theme.of(context).primary
                    : null,
                size: 32,
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          gapH64,
          TimerCircle(
            onPressed: viewModel.startTimer,
            timerDisplay: viewModel.value,
          ),
          gapH16,
          const Expanded(child: ActivityListWidget()),
        ],
      ),
    );
  }

  @override
  TimerViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      TimerViewModel();
}

class TimerCircle extends StatelessWidget {
  const TimerCircle({
    super.key,
    required this.onPressed,
    required this.timerDisplay,
  });
  final String timerDisplay;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: const CircleBorder(),
      onTap: onPressed,
      child: Center(
        child: CircularBorderedGradient(
          child: Text(
            timerDisplay,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class PauseTimerButton extends StatelessWidget {
  const PauseTimerButton({
    super.key,
    required this.onPressed,
    this.color,
  });
  final VoidCallback? onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: PhosphorIcon(
        PhosphorIcons.pause(PhosphorIconsStyle.duotone),
        color: color,
        size: 32,
      ),
    );
  }
}

class StartResumeTimerButton extends StatelessWidget {
  const StartResumeTimerButton({
    super.key,
    required this.onPressed,
    this.color,
  });
  final VoidCallback? onPressed;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: PhosphorIcon(
        PhosphorIcons.play(PhosphorIconsStyle.duotone),
        color: color,
        size: 32,
      ),
    );
  }
}

class ThemeButton extends StatelessWidget {
  const ThemeButton({
    super.key,
    required this.themeService,
  });

  final ThemeService themeService;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: themeService.toggleTheme,
      child: PhosphorIcon(
        themeService.isDark
            ? PhosphorIcons.sun(PhosphorIconsStyle.duotone)
            : PhosphorIcons.moon(PhosphorIconsStyle.duotone),
        color: themeService.isDark
            ? Colors.amberAccent
            : Theme.of(context).onSurface,
        size: 32,
      ),
    );
  }
}

class OstraTitle extends StatelessWidget {
  const OstraTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'Ostra'.localized,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primary,
          ),
    );
  }
}
