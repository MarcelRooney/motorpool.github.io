import 'package:car_rental/screens/auth/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCsuE6hVHTLyGzK8rfVGLAvQlgF_uimUDQ",
          appId: "1:335301664598:web:eb465d2051f6c6e4b980f7",
          messagingSenderId: "335301664598",
          projectId: "moto-e9a4b",
          storageBucket: "moto-e9a4b.appspot.com"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: ((context, child) {
        return ResponsiveWrapper.builder(child,
            maxWidth: 1500,
            minWidth: 480,
            defaultScale: true,
            breakpoints: [
              const ResponsiveBreakpoint.resize(480, name: MOBILE),
              const ResponsiveBreakpoint.autoScale(800, name: TABLET),
              const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
            ],
            background: Container(color: Colors.white));
      }),
      title: 'Motorpool',
      home: LoginScreen(),
    );
  }
}
