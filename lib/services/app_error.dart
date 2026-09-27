import 'package:firebase_auth/firebase_auth.dart';

class AppError {
  static String message(Object error) {
    if (error is FirebaseAuthException) {
      return _firebaseAuthMessage(error);
    }

    if (error is FirebaseException) {
      return _firebaseMessage(error);
    }

    final text = error.toString().replaceFirst('Exception: ', '').trim();
    if (text.isEmpty || text.startsWith('Instance of ')) {
      return 'Something went wrong. Please try again.';
    }
    return text;
  }

  static String _firebaseAuthMessage(FirebaseAuthException error) {
    switch (error.code) {
      case 'network-request-failed':
        return 'Network error. Check your connection and try again.';
      case 'permission-denied':
        return 'You do not have permission to access this information.';
      case 'too-many-requests':
        return 'Too many requests. Please wait a moment and try again.';
      default:
        return 'We could not complete your account request. Please try again.';
    }
  }

  static String _firebaseMessage(FirebaseException error) {
    switch (error.code) {
      case 'permission-denied':
        return 'You do not have permission to view this information.';
      case 'failed-precondition':
        return 'This information is temporarily unavailable. Please try again later.';
      case 'unavailable':
      case 'network-request-failed':
        return 'Network error. Check your connection and try again.';
      case 'not-found':
        return 'The requested information could not be found.';
      default:
        return 'We could not load this information. Please try again.';
    }
  }
}
