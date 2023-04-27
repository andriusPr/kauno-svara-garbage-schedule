enum RequestStatus {
  pending(message: 'Loading events.'),
  failed(message: 'Failed to load events!'),
  success(message: 'Events loaded.');

  const RequestStatus({
    required this.message,
  });

  final String message;
}

const Duration requestCacheTtl = Duration(hours: 2);