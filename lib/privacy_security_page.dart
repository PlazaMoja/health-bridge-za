import 'package:flutter/material.dart';

import 'cart.dart';
import 'services/account_service.dart';
import 'services/app_error.dart';
import 'services/settings_service.dart';

/// Profile > Privacy & Security: change password, data sharing choice,
/// and deleting the account.
class PrivacySecurityPage extends StatefulWidget {
  const PrivacySecurityPage({super.key});

  @override
  State<PrivacySecurityPage> createState() => _PrivacySecurityPageState();
}

class _PrivacySecurityPageState extends State<PrivacySecurityPage> {
  final currentController = TextEditingController();
  final newController = TextEditingController();
  final confirmController = TextEditingController();

  bool hidePasswords = true;
  bool isChangingPassword = false;

  @override
  void dispose() {
    currentController.dispose();
    newController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> changePassword() async {
    if (currentController.text.isEmpty ||
        newController.text.isEmpty ||
        confirmController.text.isEmpty) {
      showMessage('Please fill in all three password fields.');
      return;
    }
    if (newController.text.length < 6) {
      showMessage('New password must be at least 6 characters.');
      return;
    }
    if (newController.text != confirmController.text) {
      showMessage('The new passwords do not match.');
      return;
    }

    setState(() => isChangingPassword = true);
    try {
      await AccountService()
          .changePassword(currentController.text, newController.text);
      currentController.clear();
      newController.clear();
      confirmController.clear();
      if (!mounted) return;
      FocusScope.of(context).unfocus();
      showMessage('Your password has been changed.');
    } catch (e) {
      if (!mounted) return;
      showMessage(AppError.message(e));
    } finally {
      if (mounted) setState(() => isChangingPassword = false);
    }
  }

  Future<void> setShareData(bool value) async {
    try {
      await SettingsService.save(shareDataForResearch: value);
    } catch (e) {
      if (!mounted) return;
      showMessage(AppError.message(e));
    }
  }

  Future<void> confirmDeleteAccount() async {
    final passwordController = TextEditingController();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete account?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'This permanently deletes your account, your personal '
              'information and all your appointments. It cannot be undone.',
            ),
            const SizedBox(height: 15),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Enter your password to confirm',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    // (The controller isn't disposed here because the dialog may still be
    // animating closed; it is tiny and gets garbage collected.)
    final password = passwordController.text;
    if (confirmed != true) return;

    if (password.isEmpty) {
      showMessage('Please enter your password to delete your account.');
      return;
    }

    try {
      await AccountService().deleteAccount(password);
      Cart.clear();
      SettingsService.reset();
      if (!mounted) return;
      showMessage('Your account has been deleted.');
      // Signing out happens automatically; go back to the first screen,
      // which now shows the login page.
      Navigator.popUntil(context, (route) => route.isFirst);
    } catch (e) {
      if (!mounted) return;
      showMessage(AppError.message(e));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Privacy & Security',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Change password
          _card(
            title: 'Change password',
            children: [
              _passwordField(currentController, 'Current password'),
              _passwordField(newController, 'New password (6+ characters)'),
              _passwordField(confirmController, 'Confirm new password'),
              Row(
                children: [
                  Checkbox(
                    value: !hidePasswords,
                    onChanged: (v) =>
                        setState(() => hidePasswords = !(v ?? false)),
                  ),
                  const Text('Show passwords'),
                ],
              ),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: isChangingPassword ? null : changePassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2F80ED),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: isChangingPassword
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'Update Password',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Data & privacy
          _card(
            title: 'Your data',
            children: [
              ValueListenableBuilder<AppSettings>(
                valueListenable: SettingsService.settings,
                builder: (context, settings, _) => SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Share anonymous data for research'),
                  subtitle: const Text(
                    'Helps improve health services. Your name and phone '
                    'number are never shared.',
                  ),
                  value: settings.shareDataForResearch,
                  onChanged: setShareData,
                ),
              ),
              const Divider(),
              const ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.shield_outlined, color: Color(0xFF2F80ED)),
                title: Text('How we protect your data'),
                subtitle: Text(
                  'Your password is handled by Firebase Authentication and is '
                  'never visible to anyone, including us. Your details are '
                  'only used to provide Health Bridge services.',
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Danger zone
          _card(
            title: 'Delete account',
            children: [
              const Text(
                'Permanently remove your account and all your appointments.',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton.icon(
                  onPressed: confirmDeleteAccount,
                  icon: const Icon(Icons.delete_outline),
                  label: const Text(
                    'Delete My Account',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _card({required String title, required List<Widget> children}) {
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

  Widget _passwordField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        obscureText: hidePasswords,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF2F80ED)),
          filled: true,
          fillColor: Theme.of(context).scaffoldBackgroundColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
