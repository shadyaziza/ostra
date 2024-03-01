import 'package:flutter/material.dart';
import 'package:ostra/app/app.locator.dart';
import 'package:ostra/services/activities_service.dart';
import 'package:ostra/services/theme_service.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'package:stacked/stacked.dart';

import 'timer_viewmodel.dart';

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
        title: Text(
          'Ostra',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primary,
              ),
        ),
        centerTitle: false,
        actions: [
          TextButton(
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
          ),
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
            IconButton(
              onPressed: (!viewModel.isActive) || viewModel.isPaused
                  ? viewModel.resumeTimer
                  : null,
              icon: PhosphorIcon(
                PhosphorIcons.play(PhosphorIconsStyle.duotone),
                color: (!viewModel.isActive) || viewModel.isPaused
                    ? Theme.of(context).primary
                    : null,
                size: 32,
              ),
            ),
            IconButton(
              onPressed: viewModel.isActive ? viewModel.pauseTimer : null,
              icon: PhosphorIcon(
                PhosphorIcons.pause(PhosphorIconsStyle.duotone),
                color: viewModel.isActive ? Theme.of(context).primary : null,
                size: 32,
              ),
            ),
            StopAndSaveActivityIconWidget(
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
      body: Padding(
        padding: const EdgeInsets.only(top: 32),
        child: Column(
          children: [
            InkWell(
              customBorder: const CircleBorder(),
              onTap: viewModel.startTimer,
              child: Center(
                child: CircularBorderedGradient(
                  child: Text(
                    viewModel.value,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const Expanded(child: ActivityListWidget()),
          ],
        ),
      ),
    );
  }

  @override
  TimerViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      TimerViewModel();
}

class CircularBorderedGradient extends StatelessWidget {
  const CircularBorderedGradient({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CircleBorderGradientPainter(
        gradient: const LinearGradient(
          colors: [Colors.blue, Color(0xFF00E5B7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        strokeWidth: 4.0,
      ),
      child: Container(
        width: 200,
        height: 200,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
        ),
        child: child,
      ),
    );
  }
}

class CircleBorderGradientPainter extends CustomPainter {
  final LinearGradient gradient;
  final double strokeWidth;

  CircleBorderGradientPainter(
      {required this.gradient, required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    // Create a paint object
    final paint = Paint()
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    // Create a rectangle to define the boundaries of the gradient
    final rect = Offset.zero & size;
    // Create the shader from the gradient and the rectangle bounds
    paint.shader = gradient.createShader(rect);

    // Draw the circle with the gradient paint
    canvas.drawCircle(
        size.center(Offset.zero), size.width / 2 - strokeWidth / 2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class StopAndSaveActivityIconWidget extends StackedView<SaveActivityViewModel> {
  const StopAndSaveActivityIconWidget(
      {super.key, required this.onSave, required this.icon});

  final VoidCallback? onSave;
  final Widget icon;

  @override
  Widget builder(BuildContext context, viewModel, Widget? child) {
    return IconButton(
      onPressed: () {
        onSave?.call();
        viewModel.saveActivity('str');
      },
      icon: icon,
    );
  }

  @override
  viewModelBuilder(BuildContext context) => SaveActivityViewModel();
}

class SaveActivityViewModel extends ReactiveViewModel {
  final ActivitiesService _activitiesService = locator<ActivitiesService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [_activitiesService];

  void saveActivity(String str) {
    _activitiesService.add(DateTime.now().toString());
    rebuildUi();
  }
}

class ActivityListWidget extends StackedView<ActivityListViewModel> {
  const ActivityListWidget({super.key});

  @override
  Widget builder(BuildContext context, viewModel, Widget? child) {
    if (viewModel.list.isEmpty) return const Text('no activity');
    return ListView.builder(
      itemCount: viewModel.list.length,
      itemBuilder: (context, index) {
        return Text(viewModel.list[index]);
      },
    );
  }

  @override
  viewModelBuilder(BuildContext context) => ActivityListViewModel();
}

class ActivityListViewModel extends ReactiveViewModel {
  final ActivitiesService _activitiesService = locator<ActivitiesService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [_activitiesService];

  List<String> get list => _activitiesService.activities;
}
