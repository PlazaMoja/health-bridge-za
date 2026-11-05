import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'cart.dart';
import 'dataconnect_generated/generated.dart';
import 'notifications_page.dart';
import 'personal_info_page.dart';
import 'privacy_security_page.dart';
import 'services/settings_service.dart';
import 'settings_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Opens a profile sub-page, then reloads this page in case the name changed.
  Future<void> open(Widget page) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
    if (mounted) setState(() {});
  }

  Future<Map<String, dynamic>?> _loadUserData(String uid) async {
    final result = await HealthbridgeConnector.instance
      .getUser(firebaseUid: uid)
      .execute();
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

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(

      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'My Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: user == null
          ? const Center(
              child: Text('Please login to view profile'),
            )
          : FutureBuilder<Map<String, dynamic>?>(
              future: _loadUserData(user.uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final userData = snapshot.data;
                final firstName = userData?['firstName'] ?? '';
                final lastName = userData?['lastName'] ?? '';
                final fullName = '$firstName $lastName'.trim().isEmpty
                    ? (user.displayName ?? 'User')
                    : '$firstName $lastName';
                final email = userData?['email'] ?? user.email ?? '';
                final phoneNumber = userData?['phoneNumber'] ?? '';
                final role = userData?['role'] ?? 'patient';

                return ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 45,
                            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                            child: Text(
                              fullName.isNotEmpty
                                  ? fullName[0].toUpperCase()
                                  : 'U',
                              style: const TextStyle(
                                fontSize: 40,
                                color: Color(0xFF2F80ED),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          const SizedBox(height: 15),

                          Text(
                            fullName,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 5),

                          Text(
                            email,
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),

                          if (phoneNumber.isNotEmpty) ...[
                            const SizedBox(height: 5),
                            Text(
                              phoneNumber,
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],

                          const SizedBox(height: 10),

                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: role == 'patient'
                                  ? Colors.blue.withValues(alpha: 0.15)
                                  : Colors.purple.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              role.toUpperCase(),
                              style: TextStyle(
                                color: role == 'patient'
                                    ? Colors.blue
                                    : Colors.purple,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),

                    const Text(
                      'Account',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    _profileOption(
                      icon: Icons.person_outline,
                      title: 'Personal Information',
                      onTap: () => open(const PersonalInfoPage()),
                    ),

                    _profileOption(
                      icon: Icons.lock_outline,
                      title: 'Privacy & Security',
                      onTap: () => open(const PrivacySecurityPage()),
                    ),

                    _profileOption(
                      icon: Icons.notifications_none,
                      title: 'Notifications',
                      onTap: () => open(const NotificationsPage()),
                    ),

                    _profileOption(
                      icon: Icons.settings_outlined,
                      title: 'Settings',
                      onTap: () => open(const SettingsPage()),
                    ),

                    const SizedBox(height: 25),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: OutlinedButton(
                        onPressed: () async {
                          Cart.clear();
                          SettingsService.reset();
                          await FirebaseAuth.instance.signOut();
                          // Go back to the first screen. It shows the login
                          // page by itself once nobody is signed in, and the
                          // home page again after the next login. (Pushing a
                          // new LoginPage here left it stuck on top after
                          // logging back in.)
                          if (context.mounted) {
                            Navigator.of(context)
                                .popUntil((route) => route.isFirst);
                          }
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                          side: const BorderSide(color: Colors.red),
                        ),
                        child: const Text(
                          'Log Out',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }

  Widget _profileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(
          icon,
          color: const Color(0xFF2F80ED),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey,
        ),
      ),
    );
  }
}
