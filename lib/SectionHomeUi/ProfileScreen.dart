import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../Authentication/auth_ui.dart';
import '../Authentication/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  String userEmail = '';
  String userName = '';

  @override
  void initState() {
    super.initState();
    fetchUserEmail();
  }

  Future<void> fetchUserEmail() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user != null) {
      setState(() {
        userEmail = user.email ?? 'No email found';
        userName = userEmail.split('@')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cloud = Supabase.instance.client;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(18, 18, 18, 0.5),
      appBar: AppBar(
        elevation: MediaQuery.of(context).size.height * 0.06,
        backgroundColor: const Color.fromRGBO(40, 47, 50, 1.0),
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Welcome $userName',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 100),
            Text(
              'Email: $userEmail',
              style: TextStyle(
                fontSize: 26,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomButton(
                onPressed: () async {
                  await cloud.auth.signOut();
                  Get.off(LoginScreen());
                },
                text: "Logout",
              ),
            )
          ],
        ),
      ),
    );
  }
}
