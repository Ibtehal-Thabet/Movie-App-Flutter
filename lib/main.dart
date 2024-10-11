import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:movieflutter/Authentication/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'Authentication/auth_ui.dart';
import 'HomePage/HomePage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Supabase.initialize(
    url: 'https://tmxcnmqqgjwrfayosbsf.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRteGNubXFxZ2p3cmZheW9zYnNmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mjg0MzI5OTcsImV4cCI6MjA0NDAwODk5N30.S7_IYwakjB1y9CHE2628O1o3tRYMEzjqu2p8ui6csPg',
  );
  SharedPreferences sp = await SharedPreferences.getInstance();
  // String imagepath = sp.getString('imagepath') ?? '';
  runApp(MyApp(
      // imagepath: imagepath,
      ));

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom]);

  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
  //     overlays: [SystemUiOverlay.bottom]);
}

class MyApp extends StatelessWidget {
  // String imagepath;
  MyApp({
    super.key,
    // required this.imagepath,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      home: intermediatescreen(),
    );
  }
}

class intermediatescreen extends StatefulWidget {
  const intermediatescreen({super.key});

  @override
  State<intermediatescreen> createState() => _intermediatescreenState();
}

class _intermediatescreenState extends State<intermediatescreen> {
  final cloud = Supabase.instance.client;
  @override
  Widget build(BuildContext context) {
    final session = cloud.auth.currentSession;

    return AnimatedSplashScreen(
      // disableNavigation: true,
      backgroundColor: const Color.fromRGBO(25, 25, 27, 1),

      duration: 2000,
      nextScreen: session != null ? const MyHomePage() : const LoginScreen(),
      splash: Stack(
        fit: StackFit.expand,
        children: [
          // Add the background image
          Positioned.fill(
              child: Stack(children: [
            LayeredRadialBackground(),
            LayeredRadialBackgroundOverlay(),
          ])),
          // Splash logo
           Column(
                mainAxisAlignment:MainAxisAlignment.center,
                children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 60.0, 0, 0),
                child: Expanded(
                    child: Image.asset(
                  'asset/action_logo.png',
                  height: 400,
                )),
              ),
              Expanded(
                child: Image.asset(
                  'asset/movie_word.png',
                  color: Colors.white,
                ),
              ),
            ]),
        ],
      ),
      // splash: Image.asset('assets/images/background.jpg'),
      splashTransition: SplashTransition.fadeTransition,
      splashIconSize: 1000,
      // centered: false,
    );
  }
}

// import 'package:animated_splash_screen/animated_splash_screen.dart';
// import 'package:flutter/material.dart' hide CarouselController;
// import 'package:flutter/services.dart';
// import 'package:movieflutter/Authentication/login_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'Authentication/auth_main.dart';
// import 'Authentication/auth_ui.dart';
// import 'HomePage/HomePage.dart';
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   SharedPreferences sp = await SharedPreferences.getInstance();
//   String imagepath = sp.getString('imagepath') ?? '';
//   runApp(MyApp(
//     imagepath: imagepath,
//   ));

//   SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
//       overlays: [SystemUiOverlay.bottom]);
//
//   // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
//   //     overlays: [SystemUiOverlay.bottom]);
// }
//
// class MyApp extends StatelessWidget {
//   String imagepath;
//   MyApp({
//     super.key,
//     required this.imagepath,
//   });
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Movie App',
//       home: intermediatescreen(),
//     );
//   }
// }
//
// class intermediatescreen extends StatefulWidget {
//   const intermediatescreen({super.key});
//
//   @override
//   State<intermediatescreen> createState() => _intermediatescreenState();
// }
//
// class _intermediatescreenState extends State<intermediatescreen> {
//   final isLogedIn = cloud.auth.currentSession;
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedSplashScreen(
//       // disableNavigation: true,
//       backgroundColor: const Color.fromRGBO(18, 18, 18, 1),
//
//       duration: 2000,
//       nextScreen: isLogedIn != null ? const MyHomePage() : const LoginScreen(),
//       splash: Stack(children: [
//         LayeredRadialBackground(),
//         LayeredRadialBackgroundOverlay(),
//         Container(
//           child: Center(
//             child: Column(
//               children: [
//                 Expanded(
//                   child: Container(
//                     margin: const EdgeInsets.only(bottom: 6),
//                     decoration: const BoxDecoration(
//                         image: DecorationImage(
//                             image: AssetImage('asset/action_logo'),
//                             fit: BoxFit.contain)),
//                   ),
//                 ),
//                 Expanded(
//                   child: Container(
//                     margin: const EdgeInsets.only(bottom: 10),
//                     decoration: const BoxDecoration(
//                         image: DecorationImage(
//                             image: AssetImage('asset/movies_woed'),
//                             fit: BoxFit.contain)),
//                   ),
//                 ),
//                 Expanded(
//                   child: Container(
//                     child: const Text(
//                       '',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ]),
//
//       // splash: Image.asset('assets/images/background.jpg'),
//       splashTransition: SplashTransition.fadeTransition,
//       splashIconSize: 200,
//       // centered: false,
//     );
//   }
// }
