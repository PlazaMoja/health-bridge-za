import 'package:flutter/material.dart';

import 'services/account_service.dart';
import 'services/app_error.dart';
import 'widgets/load_state.dart';

/// Profile > Personal Information.
/// Loads the user's details from the database and lets them edit and save them.
/// Returns true to the Profile page when something was saved.
class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key});

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  static const genders = ['Female', 'Male', 'Other', 'Prefer not to say'];

  final account = AccountService();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final emergencyNameController = TextEditingController();
  final emergencyPhoneController = TextEditingController();

  PersonalDetails? details;
  DateTime? dateOfBirth;
  String gender = '';

  bool isLoading = true;
  bool isSaving = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    loadDetails();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    emergencyNameController.dispose();
    emergencyPhoneController.dispose();
    super.dispose();
  }

  Future<void> loadDetails() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final d = await account.loadPersonalDetails();
      if (!mounted) return;
      setState(() {
        details = d;
        firstNameController.text = d.firstName;
        lastNameController.text = d.lastName;
        phoneController.text = d.phoneNumber;
        addressController.text = d.address;
        emergencyNameController.text = d.emergencyContactName;
        emergencyPhoneController.text = d.emergencyContactPhone;
        dateOfBirth = d.dateOfBirth;
        gender = genders.contains(d.gender) ? d.gender : '';
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
        errorMessage = AppError.message(e);
      });
    }
  }

  Future<void> pickDateOfBirth() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: dateOfBirth ?? DateTime(now.year - 25),
      firstDate: DateTime(1900),
      lastDate: now,
      helpText: 'Date of birth',
    );
    if (picked != null) {
      setState(() => dateOfBirth = picked);
    }
  }

  Future<void> save() async {
    final d = details;
    if (d == null) return;

    if (firstNameController.text.trim().isEmpty ||
        lastNameController.text.trim().isEmpty) {
      _showMessage('Please enter your first and last name.');
      return;
    }

    setState(() => isSaving = true);
    try {
      await account.savePersonalDetails(PersonalDetails(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: d.email,
        phoneNumber: phoneController.text,
        dateOfBirth: dateOfBirth,
        gender: gender,
        address: addressController.text,
        emergencyContactName: emergencyNameController.text,
        emergencyContactPhone: emergencyPhoneController.text,
      ));

      if (!mounted) return;
      _showMessage('Your details have been saved.');
      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;
      _showMessage(AppError.message(e));
    } finally {
      if (mounted) setState(() => isSaving = false);
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  static String _formatDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Personal Information',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: details == null
          ? LoadState(
              isLoading: isLoading,
              errorMessage: errorMessage,
              onRetry: loadDetails,
            )
          : ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _section('Basic details', [
                  _field(firstNameController, 'First name',
                      Icons.person_outline),
                  _field(lastNameController, 'Last name',
                      Icons.person_outline),
                  // The email is the login, so it isn't edited here.
                  TextFormField(
                    initialValue: details!.email,
                    enabled: false,
                    decoration: _decoration(
                      'Email',
                      Icons.email_outlined,
                      helper: 'Used to log in - this can\'t be changed here.',
                    ),
                  ),
                  const SizedBox(height: 15),
                  _field(phoneController, 'Phone number', Icons.phone_outlined,
                      keyboard: TextInputType.phone),
                  InkWell(
                    onTap: pickDateOfBirth,
                    borderRadius: BorderRadius.circular(12),
                    child: InputDecorator(
                      decoration:
                          _decoration('Date of birth', Icons.cake_outlined),
                      child: Text(
                        dateOfBirth == null
                            ? 'Tap to choose'
                            : _formatDate(dateOfBirth!),
                        style: TextStyle(
                          color: dateOfBirth == null ? Colors.grey : null,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  DropdownButtonFormField<String>(
                    initialValue: gender.isEmpty ? null : gender,
                    decoration: _decoration('Gender', Icons.wc_outlined),
                    items: genders
                        .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                        .toList(),
                    onChanged: (value) => setState(() => gender = value ?? ''),
                  ),
                  const SizedBox(height: 15),
                  _field(addressController, 'Home address',
                      Icons.home_outlined,
                      maxLines: 2),
                ]),
                const SizedBox(height: 20),
                _section('Emergency contact', [
                  _field(emergencyNameController, 'Contact name',
                      Icons.contact_emergency_outlined),
                  _field(emergencyPhoneController, 'Contact phone number',
                      Icons.phone_in_talk_outlined,
                      keyboard: TextInputType.phone),
                ]),
                const SizedBox(height: 25),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: isSaving ? null : save,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2F80ED),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: isSaving
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'Save Changes',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _section(String title, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          ...children,
        ],
      ),
    );
  }

  Widget _field(
    TextEditingController controller,
    String label,
    IconData icon, {
    TextInputType keyboard = TextInputType.text,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        keyboardType: keyboard,
        maxLines: maxLines,
        decoration: _decoration(label, icon),
      ),
    );
  }

  InputDecoration _decoration(String label, IconData icon, {String? helper}) {
    return InputDecoration(
      labelText: label,
      helperText: helper,
      prefixIcon: Icon(icon, color: const Color(0xFF2F80ED)),
      filled: true,
      fillColor: Theme.of(context).scaffoldBackgroundColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}
