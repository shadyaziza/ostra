// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'time_tracker_controller.g.dart';

class TimerModel {
  final bool isActive;

  final bool isPaused;

  final bool isStopped;

  final String time;

  const TimerModel({
    this.isActive = false,
    this.isPaused = false,
    this.isStopped = false,
    this.time = "00:00:00",
  });

  TimerModel copyWith({
    bool? isActive,
    bool? isPaused,
    bool? isStopped,
    String? time,
  }) {
    return TimerModel(
      isActive: isActive ?? this.isActive,
      isPaused: isPaused ?? this.isPaused,
      isStopped: isStopped ?? this.isStopped,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isActive': isActive,
      'isPaused': isPaused,
      'isStopped': isStopped,
      'time': time,
    };
  }

  factory TimerModel.fromMap(Map<String, dynamic> map) {
    return TimerModel(
      isActive: map['isActive'] as bool? ?? false,
      isPaused: map['isPaused'] as bool? ?? false,
      isStopped: map['isStopped'] as bool? ?? false,
      time: map['time'] as String? ?? "00:00:00",
    );
  }

  String toJson() => json.encode(toMap());

  factory TimerModel.fromJson(String source) =>
      TimerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TimerModel(isActive: $isActive, isPaused: $isPaused, isStopped: $isStopped, time: $time)';
  }

  @override
  bool operator ==(covariant TimerModel other) {
    if (identical(this, other)) return true;

    return other.isActive == isActive &&
        other.isPaused == isPaused &&
        other.isStopped == isStopped &&
        other.time == time;
  }

  @override
  int get hashCode {
    return isActive.hashCode ^
        isPaused.hashCode ^
        isStopped.hashCode ^
        time.hashCode;
  }
}

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
