import 'dart:math';

import 'package:flutter/material.dart';

Color getRandomColor() {
  final random = Random();
  return Color.fromRGBO(
    random.nextInt(256),
    random.nextInt(256),
    random.nextInt(256),
    1,
  );
}

double calculateLuminance(Color color) {
  // Convert RGB to the range 0-1
  num red = color.red / 255.0;
  num green = color.green / 255.0;
  num blue = color.blue / 255.0;

  // Apply gamma correction to each color component
  red = red < 0.03928 ? red / 12.92 : pow((red + 0.055) / 1.055, 2.4);
  green = green < 0.03928 ? green / 12.92 : pow((green + 0.055) / 1.055, 2.4);
  blue = blue < 0.03928 ? blue / 12.92 : pow((blue + 0.055) / 1.055, 2.4);

  // Calculate the luminance
  return 0.2126 * red + 0.7152 * green + 0.0722 * blue;
}

double contrastRatio(Color color1, Color color2) {
  final double l1 = calculateLuminance(color1) + 0.05;
  final double l2 = calculateLuminance(color2) + 0.05;

  return (l1 > l2) ? l1 / l2 : l2 / l1;
}

Color getTextColorBasedOnBackground(Color backgroundColor) {
  final double contrastWithWhite = contrastRatio(backgroundColor, Colors.white);
  final double contrastWithBlack = contrastRatio(backgroundColor, Colors.black);

  // WCAG recommends a contrast ratio of at least 4.5:1 for normal text
  if (contrastWithWhite > contrastWithBlack) {
    return (contrastWithWhite >= 4.5) ? Colors.white : Colors.black;
  } else {
    return (contrastWithBlack >= 4.5) ? Colors.black : Colors.white;
  }
}
