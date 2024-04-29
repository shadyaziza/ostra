import 'dart:convert';

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
