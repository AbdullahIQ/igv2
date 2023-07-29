import 'package:flutter/material.dart';
import 'package:igv2/screens/loginPage.dart';
import 'package:igv2/screens/userPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  Future<bool> checkPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("creds")) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: checkPrefs(),
      builder: (context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.data == true) {
          return const UserPage();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
