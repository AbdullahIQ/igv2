import 'package:flutter/material.dart';
import 'package:igv2/screens/loginPage.dart';
import 'package:igv2/screens/profilePage.dart';
import 'package:igv2/screens/storyPage.dart';
import 'package:igv2/screens/userPage.dart';
import 'package:igv2/wrapper.dart';

import 'models/data.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      routes: {
        "/": (context) => const Wrapper(),
        "/login": (context) => const LoginPage(),
        "/user": (context) => const UserPage(),
        "/profile": (context) => const InstagramProfilePage(),
        // "/user": (context) => const UserPage(),
      },
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return const LoginPage();
//     // return StoryScreen(stories: stories);
//   }
// }
