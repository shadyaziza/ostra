import 'package:flutter/material.dart';
import 'package:ostra/app/app.locator.dart';
import 'package:ostra/services/theme_service.dart';
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
    return Scaffold(
      appBar: AppBar(actions: [
        TextButton(
          onPressed: locator<ThemeService>().toggleTheme,
          child: const Text('Theme'),
        ),
      ]),
      floatingActionButton:
          FloatingActionButton(onPressed: viewModel.startTimer),
      body: Center(
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
