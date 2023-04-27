import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class GarbageSchedule extends Equatable {
  final DateTime date;

  const GarbageSchedule({
    required this.date,
  });

  factory GarbageSchedule.fromJson(Map<String, dynamic> parsedJson) {
    return GarbageSchedule(
      date: DateTime.parse(parsedJson['date']),
    );
  }

  static List<GarbageSchedule> fromJsonArray(List<dynamic> parsedJson) =>
      List<GarbageSchedule>.from(parsedJson.map((item) => GarbageSchedule.fromJson(item)));

  @override
  List<Object?> get props => [date];
}