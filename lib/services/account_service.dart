import 'package:firebase_auth/firebase_auth.dart';

import '../dataconnect_generated/generated.dart';

/// The logged-in person's database IDs.
class AccountIds {
  final String userId;
  final String patientId;
  const AccountIds(this.userId, this.patientId);
}

/// Everything on Profile > Personal Information.
class PersonalDetails {
  final String firstName;
  final String lastName;
  final String email; // shown only - it's the login, changed through Firebase Auth
  final String phoneNumber;
  final DateTime? dateOfBirth;
  final String gender;
  final String address;
  final String emergencyContactName;
  final String emergencyContactPhone;

  const PersonalDetails({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.gender,
    required this.address,
    required this.emergencyContactName,
    required this.emergencyContactPhone,
  });
}

/// Profile data, password changes and account deletion.
class AccountService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final HealthbridgeConnector _connector = HealthbridgeConnector.instance;

  User _requireAuthUser() {
    final user = _auth.currentUser;
    if (user == null) throw Exception('Please sign in to continue.');
    return user;
  }

  /// Looks up the User and Patient rows for whoever is logged in,
  /// creating the Patient row if it's missing.
  Future<AccountIds> ids() async {
    final uid = _requireAuthUser().uid;
    final user = (await _connector.getUser(firebaseUid: uid).execute()).data.user;
    if (user == null) throw Exception('Your account profile is not ready yet.');

    final patient = (await _connector.getPatientByUserId(userId: user.id).execute())
        .data
        .patient;
    if (patient != null) return AccountIds(user.id, patient.id);

    final created = await _connector.insertPatient(userId: user.id).execute();
    return AccountIds(user.id, created.data.patient_insert.id);
  }

  Future<PersonalDetails> loadPersonalDetails() async {
    final authUser = _requireAuthUser();
    final user =
        (await _connector.getUser(firebaseUid: authUser.uid).execute()).data.user;
    if (user == null) throw Exception('Your account profile is not ready yet.');

    final ids = await this.ids();
    final patient =
        (await _connector.getPatientProfile(userId: ids.userId).execute())
            .data
            .patient;

    return PersonalDetails(
      firstName: user.firstName,
      lastName: user.lastName,
      email: user.email,
      phoneNumber: user.phoneNumber ?? '',
      dateOfBirth: patient?.dateOfBirth,
      gender: patient?.gender ?? '',
      address: patient?.address ?? '',
      emergencyContactName: patient?.emergencyContactName ?? '',
      emergencyContactPhone: patient?.emergencyContactPhone ?? '',
    );
  }

  Future<void> savePersonalDetails(PersonalDetails details) async {
    if (details.firstName.trim().isEmpty || details.lastName.trim().isEmpty) {
      throw Exception('Please enter your first and last name.');
    }
    final dob = details.dateOfBirth;
    if (dob != null && dob.isAfter(DateTime.now())) {
      throw Exception("Date of birth can't be in the future.");
    }

    final ids = await this.ids();
    String? orNull(String value) => value.trim().isEmpty ? null : value.trim();

    await _connector
        .updateUserDetails(
          id: ids.userId,
          firstName: details.firstName.trim(),
          lastName: details.lastName.trim(),
        )
        .phoneNumber(orNull(details.phoneNumber))
        .execute();

    await _connector
        .updatePatientDetails(id: ids.patientId)
        .dateOfBirth(dob)
        .gender(orNull(details.gender))
        .address(orNull(details.address))
        .emergencyContactName(orNull(details.emergencyContactName))
        .emergencyContactPhone(orNull(details.emergencyContactPhone))
        .execute();

    // Keep the name Firebase Auth shows elsewhere in step.
    await _auth.currentUser?.updateDisplayName(
        '${details.firstName.trim()} ${details.lastName.trim()}');
  }

  /// Firebase asks for the current password again before sensitive changes.
  Future<User> _reauthenticate(String password) async {
    final user = _requireAuthUser();
    final email = user.email;
    if (email == null) throw Exception('This account has no email address.');
    try {
      await user.reauthenticateWithCredential(
        EmailAuthProvider.credential(email: email, password: password),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password' ||
          e.code == 'invalid-credential' ||
          e.code == 'invalid-login-credentials') {
        throw Exception('Your current password is incorrect.');
      }
      rethrow;
    }
    return user;
  }

  Future<void> changePassword(String currentPassword, String newPassword) async {
    if (newPassword.length < 6) {
      throw Exception('New password must be at least 6 characters.');
    }
    if (newPassword == currentPassword) {
      throw Exception('New password must be different from the current one.');
    }
    final user = await _reauthenticate(currentPassword);
    await user.updatePassword(newPassword);
  }

  /// Deletes the patient's data (appointments, records, orders, settings)
  /// and then the login itself.
  Future<void> deleteAccount(String password) async {
    final user = await _reauthenticate(password);
    final ids = await this.ids();
    await _connector
        .deletePatientAccount(userId: ids.userId, patientId: ids.patientId)
        .execute();
    await user.delete();
  }
}
