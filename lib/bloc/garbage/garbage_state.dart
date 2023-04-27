part of 'garbage_bloc.dart';

@immutable
class GarbageState extends Equatable {
  final LinkedHashMap<DateTime, List<String>>? events;
  final RequestStatus status;

  const GarbageState({
    this.events,
    this.status = RequestStatus.pending,
  });

  GarbageState copyWith({
    LinkedHashMap<DateTime, List<String>>? events,
    required RequestStatus status,
  }) {
    return GarbageState(
      events: events,
      status: status,
    );
  }

  @override
  List<Object?> get props => [events];
}
