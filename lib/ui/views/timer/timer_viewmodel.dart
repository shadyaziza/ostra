import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ostra/app/app.locator.dart';
import 'package:ostra/services/theme_service.dart';
import 'package:rxdart/subjects.dart';
import 'package:stacked/stacked.dart';

class TimerViewModel extends ReactiveViewModel {
  final ThemeService _themeService = locator<ThemeService>();

  ThemeData get themeData => _themeService.themeData;

  @override
  List<ListenableServiceMixin> get listenableServices => [_themeService];

  final BehaviorSubject<String> _subject = BehaviorSubject<String>();

  String get elapsedValue => _subject.valueOrNull ?? 0.asHumanReadableTime;

// TODO(shadyaziza): create a formatter
  String get elapsed => elapsedValue.toString();

  String _value = 0.asHumanReadableTime;

  String get value => _value;

  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      _subject.add(timer.tick.asHumanReadableTime);
      _value = timer.tick.asHumanReadableTime;
      rebuildUi();
    });
  }

  @override
  void dispose() {
    _subject.close();
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
