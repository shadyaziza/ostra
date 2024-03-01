import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ostra/app/app.locator.dart';
import 'package:ostra/services/theme_service.dart';
import 'package:stacked/stacked.dart';

class TimerViewModel extends ReactiveViewModel {
  final ThemeService _themeService = locator<ThemeService>();

  ThemeData get themeData => _themeService.themeData;

  @override
  List<ListenableServiceMixin> get listenableServices => [_themeService];

  String _value = "00:00:00";
  int _elapsedSeconds = 0; // Added to track elapsed time for pause/resume

  String get value => _value;

  Timer? _timer;

  bool get isActive => _timer?.isActive ?? false;

  bool _isPaused = false;

  bool get isPaused => _isPaused;

  void startTimer() {
    if (!(_timer?.isActive ?? false)) {
      _isPaused = false;
      _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
        _elapsedSeconds++;
        _value = _elapsedSeconds.asHumanReadableTime;
        rebuildUi();
      });
    }
  }

  void pauseTimer() {
    _isPaused = true;
    _timer?.cancel();
    rebuildUi();
  }

  void resumeTimer() {
    // No need to check if timer is active, as pause should have already cancelled it
    startTimer();
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
    _elapsedSeconds = 0; // Reset elapsed seconds on stop
    _value = _elapsedSeconds.asHumanReadableTime; // Reset the display value
    rebuildUi();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

extension on int {
  String get asHumanReadableTime {
    int hours = this ~/ 3600;
    int minutes = (this % 3600) ~/ 60;
    int seconds = this % 60;

    String formattedTime = "${hours.toString().padLeft(2, '0')}:"
        "${minutes.toString().padLeft(2, '0')}:"
        "${seconds.toString().padLeft(2, '0')}";

    return formattedTime;
  }
}
