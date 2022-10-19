import 'user.dart';

enum AppStatus { ready, loading }

class AppState {
  AppState({
    required this.user,
    required this.status,
  });

  final User user;
  final AppStatus status;
}