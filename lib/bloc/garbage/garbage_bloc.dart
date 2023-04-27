import 'dart:collection';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home/bloc/garbage/garbage_repository.dart';
import 'package:home/constants/request_constants.dart';

part 'garbage_event.dart';
part 'garbage_state.dart';

class GarbageBloc extends Bloc<GarbageEvent, GarbageState> {
  final GarbageRepository _repository = GarbageRepository();

  GarbageBloc() : super(const GarbageState()) {
    on<GarbageEventInit>(_mapGarbageEventInit);
  }

  Future _mapGarbageEventInit(
      GarbageEventInit event,
      Emitter<GarbageState> emit,
      ) async {
    try {
      final LinkedHashMap<DateTime, List<String>> schedule = await _repository.getSchedule();

      emit(state.copyWith(events: schedule, status: RequestStatus.success));
    } catch (e) {
      emit(state.copyWith(status: RequestStatus.failed));
    }
  }
}
