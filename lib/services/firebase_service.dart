import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../dataconnect_generated/generated.dart';
import '../firebase_options.dart';

class FirebaseService {
  /// Run with --dart-define=USE_EMULATOR=true to use the local Firebase
  /// emulators (Auth + Data Connect) instead of the real project.
  /// Start them first with: firebase emulators:start --only auth,dataconnect
  static const useEmulator = bool.fromEnvironment('USE_EMULATOR');

  static Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    if (useEmulator) {
      await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
      HealthbridgeConnector.instance.dataConnect
          .useDataConnectEmulator('localhost', 9399);
    }
  }
}
