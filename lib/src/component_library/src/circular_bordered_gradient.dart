import 'package:flutter/material.dart';

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
