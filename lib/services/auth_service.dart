import 'package:firebase_auth/firebase_auth.dart';
import '../dataconnect_generated/generated.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final HealthbridgeConnector _connector = HealthbridgeConnector.instance;

  User? get currentUser => _auth.currentUser;
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<UserCredential?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null) await _ensurePatient(credential.user!);
      return credential;
    } on FirebaseAuthException catch (error) {
      throw _handleAuthException(error);
    }
  }

  Future<void> _ensurePatient(User user) async {
    final userResult = await _connector.getUser(firebaseUid: user.uid).execute();
    final sqlUser = userResult.data.user;
    if (sqlUser == null) return;
    final patientResult = await _connector.getPatientByUserId(userId: sqlUser.id).execute();
    if (patientResult.data.patient == null) {
      await _connector.insertPatient(userId: sqlUser.id).execute();
    }
  }

  Future<UserCredential?> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? phoneNumber,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credential.user;
      if (user != null) {
        final result = await _connector
            .insertUser(
              firebaseUid: user.uid,
              email: email,
              firstName: firstName,
              lastName: lastName,
            )
            .phoneNumber(phoneNumber)
            .role('patient')
            .execute();
        await Future.wait([
          _connector.insertPatient(userId: result.data.user_insert.id).execute(),
          user.updateDisplayName('$firstName $lastName'),
        ]);
      }
      return credential;
    } on FirebaseAuthException catch (error) {
      throw _handleAuthException(error);
    }
  }

  Future<void> signOut() => _auth.signOut();

  Future<void> updateUserProfile({
    String? firstName,
    String? lastName,
    String? phoneNumber,
  }) async {
    final user = _auth.currentUser;
    if (user != null && (firstName != null || lastName != null)) {
      await user.updateDisplayName('${firstName ?? ''} ${lastName ?? ''}'.trim());
    }
  }

  Future<Map<String, dynamic>?> getUserData(String uid) async {
    final result = await _connector.getUser(firebaseUid: uid).execute();
    final user = result.data.user;
    return user == null
        ? null
        : {
            'firstName': user.firstName,
            'lastName': user.lastName,
            'email': user.email,
            'phoneNumber': user.phoneNumber,
            'role': user.role,
          };
  }

  String _handleAuthException(FirebaseAuthException error) {
    switch (error.code) {
      case 'user-not-found': return 'No user found with this email.';
      case 'wrong-password': return 'Incorrect password.';
      case 'invalid-credential':
      case 'invalid-login-credentials': return 'The email or password is incorrect.';
      case 'email-already-in-use': return 'An account already exists with this email.';
      case 'weak-password': return 'Password is too weak. Use at least 6 characters.';
      case 'invalid-email': return 'Invalid email address.';
      case 'too-many-requests': return 'Too many attempts. Please try again later.';
      case 'network-request-failed': return 'Network error. Please check your connection.';
      default: return 'Authentication could not be completed. Please try again.';
    }
  }
}
