import 'package:{{projectName}}/core/core.dart';

extension AppFailureX on AppFailure {
  String get message {
    return switch (this) {
      ServerFailure(:final message) => message,
      ConnectionFailure() => 'No internet connection',
      TimeoutFailure() => 'Connection timed out',
      CacheFailure() => 'Cache error',
    };
  }
}
