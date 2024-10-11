import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:movieflutter/Authentication/register_screen.dart';
import 'package:movieflutter/HomePage/HomePage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'auth_ui.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // bool isLoading = false;
  final cloud = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff19191b),
        body: Stack(children: [
          LayeredRadialBackground(),
          LayeredRadialBackgroundOverlay(),
          _page()
        ]));
  }

  Widget _page() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _loginText(),
              const SizedBox(height: 50),
              _inputField("Email", emailController),
              const SizedBox(height: 20),
              _inputField("Password", passwordController, isPassword: true),
              const SizedBox(height: 50),
              _loginBtn(),
              const SizedBox(height: 50),
              _extraText()
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputField(String hintText, TextEditingController controller,
      {isPassword = false}) {
    return CustomTextField(
        controller: controller, hintText: hintText, isPassword: isPassword);
  }

  Widget _loginBtn() {
    return CustomButton(
      onPressed: () async {
        try {
          await cloud.auth.signInWithPassword(
              password: passwordController.text, email: emailController.text);
          Get.off(MyHomePage());
        } catch (e) {
          Fluttertoast.showToast(
              msg: "this email not exist please register first",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
      text: "Login",
    );
  }

  Widget _extraText() {
    return Row(children: [
      Text(
        "Don't have an account? ",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
      TextButton(
          onPressed: () {
            Get.off(RegisterScreen());
          },
          child: Text(
            "Register Now",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.white),
          ))
    ]);
  }

  Widget _loginText() {
    return const Text(
      "Login",
      style: TextStyle(fontSize: 40, color: Colors.white),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
        backgroundColor: Color(0xff19191b),
        body: Stack(children: [
          LayeredRadialBackground(),
          LayeredRadialBackgroundOverlay(),
          _page()
        ])),
  ));
}

Widget _page() {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  return Padding(
    padding: const EdgeInsets.all(32.0),
    child: Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _loginText(),
            const SizedBox(height: 50),
            _inputField("Email", emailController),
            const SizedBox(height: 20),
            _inputField("Password", passwordController, isPassword: true),
            const SizedBox(height: 50),
            _loginBtn(),
            const SizedBox(height: 50),
            _extraText()
          ],
        ),
      ),
    ),
  );
}

Widget _inputField(String hintText, TextEditingController controller,
    {isPassword = false}) {
  return CustomTextField(
      controller: controller, hintText: hintText, isPassword: isPassword);
}

Widget _loginBtn() {
  return CustomButton(
    onPressed: () {
      Get.off(MyHomePage());
    },
    text: "Login",
  );
}

Widget _extraText() {
  return Row(children: [
    Text(
      "Don't have an account? ",
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 16, color: Colors.white),
    ),
    TextButton(
        onPressed: () {
          Get.off(RegisterScreen());
        },
        child: Text(
          "Register Now",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.white),
        ))
  ]);
}

Widget _loginText() {
  return const Text(
    "Login",
    textAlign: TextAlign.start,
    style: TextStyle(fontSize: 40, color: Colors.white),
  );
}
