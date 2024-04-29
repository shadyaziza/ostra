// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:ui';

import 'package:collection/collection.dart';

// TODO(shadyaziza): use json_serilaziable ?

class ActivityModel {
  final String title;
  final String description;
  final String backgroundColor;
  final String textColor;
  final List<dynamic> tags;
  final int timeInSeconds;
  final DateTime start;
  final DateTime end;

  ActivityModel({
    required this.title,
    required this.description,
    required this.backgroundColor,
    required this.textColor,
    required this.tags,
    required this.timeInSeconds,
    required this.start,
    required this.end,
  });

  ActivityModel copyWith({
    String? name,
    String? description,
    String? backgroundColor,
    String? textColor,
    List<dynamic>? tags,
    int? timeInSeconds,
    DateTime? start,
    DateTime? end,
  }) {
    return ActivityModel(
      title: name ?? this.title,
      description: description ?? this.description,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textColor: textColor ?? this.textColor,
      tags: tags ?? this.tags,
      timeInSeconds: timeInSeconds ?? this.timeInSeconds,
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': title,
      'description': description,
      'backgroundColor': backgroundColor,
      'textColor': textColor,
      'tags': tags,
      'timeInSeconds': timeInSeconds,
      'start': start.millisecondsSinceEpoch,
      'end': end.millisecondsSinceEpoch,
    };
  }

  factory ActivityModel.fromMap(Map<String, dynamic> map) {
    return ActivityModel(
      title: map['name'] as String,
      description: map['description'] as String,
      backgroundColor: map['backgroundColor'] as String,
      textColor: map['textColor'] as String,
      tags: List<dynamic>.from((map['tags'] as List<dynamic>)),
      timeInSeconds: map['timeInSeconds'] as int,
      start: DateTime.fromMillisecondsSinceEpoch(map['start'] as int),
      end: DateTime.fromMillisecondsSinceEpoch(map['end'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory ActivityModel.fromJson(String source) =>
      ActivityModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ActivityModel(name: $title, description: $description, backgroundColor: $backgroundColor, textColor: $textColor, tags: $tags, timeInSeconds: $timeInSeconds, start: $start, end: $end)';
  }

  @override
  bool operator ==(covariant ActivityModel other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.title == title &&
        other.description == description &&
        other.backgroundColor == backgroundColor &&
        other.textColor == textColor &&
        listEquals(other.tags, tags) &&
        other.timeInSeconds == timeInSeconds &&
        other.start == start &&
        other.end == end;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        description.hashCode ^
        backgroundColor.hashCode ^
        textColor.hashCode ^
        tags.hashCode ^
        timeInSeconds.hashCode ^
        start.hashCode ^
        end.hashCode;
  }
}

extension ColorEx on Color {
  String colorToHex({bool leadingHashSign = true}) {
    return '${leadingHashSign ? '#' : ''}'
        '${alpha.toRadixString(16).padLeft(2, '0')}'
        '${red.toRadixString(16).padLeft(2, '0')}'
        '${green.toRadixString(16).padLeft(2, '0')}'
        '${blue.toRadixString(16).padLeft(2, '0')}';
  }
}

extension StringEx on String {
  Color get hexToColor {
    // Remove the '#' character if it exists
    var str = this.replaceFirst('#', '');

    // Check for valid hex string length
    if (str.length != 6 && str.length != 8) {
      throw FormatException(
          'Invalid hex string length. Must be 6 or 8 characters long.');
    }

    // Add 'ff' for opacity if length is 6
    if (str.length == 6) {
      str = 'ff' + str;
    }

    // Check if the string contains only valid hex characters
    if (!RegExp(r'^[0-9a-fA-F]+$').hasMatch(str)) {
      throw FormatException(
          'Invalid hex string. Contains non-hexadecimal characters.');
    }

    try {
      return Color(int.parse(str, radix: 16));
    } catch (e) {
      // Handle any other errors
      throw FormatException('Failed to parse the hex string into a Color.');
    }
  }
}
