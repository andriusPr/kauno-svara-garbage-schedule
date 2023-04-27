part of 'garbage_bloc.dart';

@immutable
abstract class GarbageEvent {
  const GarbageEvent();
}

@immutable
class GarbageEventInit extends GarbageEvent {
  const GarbageEventInit();
}