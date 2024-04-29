// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';

import 'package:ostra/domain_models/domain_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'time_tracker_controller.g.dart';

@riverpod
class TimeTrackerController extends _$TimeTrackerController {
  @override
  TimerModel build() {
    ref.onDispose(() {
      _timer?.cancel();
    });
    return const TimerModel();
  }

  int _elapsedSeconds = 0; // Added to track elapsed time for pause/resume

  Timer? _timer;

  void startTimer() {
    if (!(_timer?.isActive ?? false)) {
      state = state.copyWith(
        isPaused: false,
      );
      _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
        _elapsedSeconds++;
        state = state.copyWith(
          time: _elapsedSeconds.asHumanReadableTime,
          isActive: true,
          isStopped: false,
          isPaused: false,
        );
      });
    }
  }

  void pauseTimer() {
    state = state.copyWith(
      isPaused: true,
      isActive: false,
      isStopped: false,
    );
    _timer?.cancel();
  }

  void resumeTimer() {
    // No need to check if timer is active, as pause should have already cancelled it
    startTimer();
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
    _elapsedSeconds = 0; // Reset elapsed seconds on stop
    state = state.copyWith(
      time: _elapsedSeconds.asHumanReadableTime,
      isActive: false,
      isPaused: false,
      isStopped: true,
    ); // Reset the display value
  }
}

// TODO(shadyaziza): move to extensions later
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
