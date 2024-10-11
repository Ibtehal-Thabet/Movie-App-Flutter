import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:movieflutter/Authentication/auth_main.dart';
import 'package:movieflutter/Authentication/login_screen.dart';
import 'package:movieflutter/HomePage/HomePage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'auth_ui.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
              _registerText(),
              const SizedBox(height: 50),
              _inputField("Email", emailController),
              const SizedBox(height: 20),
              _inputField("Password", passwordController, isPassword: true),
              const SizedBox(height: 50),
              _registerBtn(emailController, passwordController),
              const SizedBox(height: 50),
              _extraText()
            ],
          ),
        ),
      ),
    );
  }

  Widget _registerBtn(TextEditingController emailController,
      TextEditingController passwordController) {
    return CustomButton(

      onPressed: () async {
        if(emailController.text.contains("@")&&emailController.text.contains(".com")) {
          // var users =await cloud.from("user").select().eq("email", "donia@gmail.com");
          // var password = cloud.from("user").select("password");
          try {
            await cloud.auth.signUp(
                password: passwordController.text, email: emailController.text);

            Fluttertoast.showToast(
                msg: "Successful registration",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
            Get.off(MyHomePage());
          } catch (e) {
            Fluttertoast.showToast(
                msg: "this email exist",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
          // if (found == true) {
          //   try {
          //     await cloud.from("user").insert({
          //       "email": emailController.text,
          //       "password": passwordController.text,
          //       "movie_id":"jj"
          //     });
          //   } catch (e) {
          //
          //   }
          // }
        }
        else{
          Fluttertoast.showToast(
              msg: "please enter valid email",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }

      },
      text: "Register",
    );
  }

  Widget _extraText() {
    return Row(children: [
      Text(
        "Already have an account? ",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
      TextButton(
          onPressed: () {
            Get.off(LoginScreen());
          },
          child: Text(
            "Login ",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.white),
          ))
    ]);
  }

  Widget _registerText() {
    return const Text(
      "Create Account",
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
      controller: controller, hintText: hintText, isPassword: isPassword,);
}

Widget _loginBtn() {
  return CustomButton(
    onPressed: () {
    },
    text: "Register",
  );
}

Widget _extraText() {
  return const Text(
    "Already have an account? Login",
    textAlign: TextAlign.center,
    style: TextStyle(fontSize: 16, color: Colors.white),
  );
}

Widget _loginText() {
  return const Text(
    "Create Account",
    textAlign: TextAlign.start,
    style: TextStyle(fontSize: 40, color: Colors.white),
  );
}
