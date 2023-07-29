import 'package:flutter/material.dart';
import 'package:igv2/loading.dart';
import 'package:igv2/models/login.dart';
import 'package:igv2/screens/userPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginHandle _login = LoginHandle();
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: const Icon(Icons.login),
              elevation: 0.0,
              backgroundColor: Colors.blue[400],
              title: const Text("Login"),
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) => value!.isEmpty
                          ? "Please enter the username or the email"
                          : null,
                      decoration:
                          const InputDecoration(hintText: "Email or Username"),
                      onChanged: (value) => setState(() {
                        email = value;
                      }),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) => value!.length < 6
                          ? "Please enter the correct password"
                          : null,
                      decoration: const InputDecoration(hintText: "Password"),
                      obscureText: true,
                      onChanged: (value) => setState(() {
                        password = value;
                      }),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              loading = true;
                            });
                            dynamic result =
                                await _login.login(email!, password!);
                            if (result! == false) {
                              setState(() {
                                loading = false;
                              });
                            } else {
                              setState(() {
                                loading = false;
                                Navigator.pushReplacementNamed(context, "/user",
                                    arguments: email);
                              });
                            }
                          }
                        },
                        child: const Text("Login"))
                  ],
                ),
              ),
            ),
          );
  }
}
