import 'models.dart';

/// Remembers who is logged in while the app is open.
/// (It is cleared when the app is closed or the user logs out.)
class Session {
  static AppUser? currentUser;

  static void clear() {
    currentUser = null;
  }
}
