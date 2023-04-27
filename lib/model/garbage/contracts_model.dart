import 'dart:collection';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:home/model/garbage/schedule_model.dart';

@immutable
class GarbageContracts extends Equatable {
  final int id;
  final String description;
  final List<GarbageSchedule> dates;
  final LinkedHashMap<DateTime, List<String>> events;
  final String container;

  const GarbageContracts({
    required this.id,
    required this.description,
    required this.dates,
    required this.events,
    required this.container,
  });

  GarbageContracts copyWith({
    int? id,
    String? description,
    List<GarbageSchedule>? dates,
    LinkedHashMap<DateTime, List<String>>? events,
    String? container,
  }) {
    return GarbageContracts(
      id: id ?? this.id,
      description: description ?? this.description,
      dates: dates ?? this.dates,
      events: events ?? this.events,
      container: container ?? this.container,
    );
  }

  factory GarbageContracts.fromJson(Map<String, dynamic> parsedJson) {
    return GarbageContracts(
      id: parsedJson['wasteObjectId'],
      description: parsedJson['descriptionFmt'],
      dates: const [],
      events: LinkedHashMap(),
      container: parsedJson['containerFmt'],
    );
  }

  static List<GarbageContracts> fromJsonArray(List<dynamic> parsedJson) =>
      List<GarbageContracts>.from(
          parsedJson.map((item) => GarbageContracts.fromJson(item)));

  @override
  List<Object?> get props => [id, description];
}
