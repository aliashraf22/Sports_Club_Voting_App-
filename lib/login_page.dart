import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:learn/config/user_config.dart';
import 'package:learn/home_page.dart';
import 'package:learn/models/user_model.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 47,
          title: const Text("Votage"),
          centerTitle: true,
          backgroundColor: const Color(0xFF00B0FF),
          titleTextStyle: const TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 32.0,
              fontWeight: FontWeight.w500)),
      body: const FormExample(),
    );
  }
}

class FormExample extends StatefulWidget {
  const FormExample({super.key});

  @override
  State<FormExample> createState() => _FormExampleState();
}

class _FormExampleState extends State<FormExample> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _userIdController = TextEditingController(text: '1234');
  final TextEditingController _passwordController = TextEditingController(text: '12345678');

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          Image.asset(
            "images/login.png",
            width: 400,
            height: 400,
            alignment: Alignment.center,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: TextFormField(
              controller: _userIdController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your Club Id',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your Password',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: MaterialButton(
              color: const Color(0xFF00B0FF),
              minWidth: 325,
              height: 62,
              textColor: Colors.white,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _signIn(_userIdController.text, _passwordController.text)
                      .then((isAuthenticated) {
                    if (isAuthenticated) {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
                        (_) => false,
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Login Failed'),
                          content: Text('Invalid Club ID or Password.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  });
                }
              },
              child: const Text('Log In',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 25.0,
                    fontWeight: FontWeight.w600,
                  )),
            ),
          ),
          // TextButton(
          //   onPressed: () {
          //     Navigator.of(context).push(
          //         MaterialPageRoute(builder: (context) => const signup()));
          //   },
          //   style: TextButton.styleFrom(
          //     foregroundColor: Colors.white,
          //   ),
          //   child: const Text(
          //     'Dont Have An Account? Signup',
          //     style: TextStyle(
          //       fontSize: 20,
          //       color: Color(0xFF00B0FF),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Future<bool> _signIn(String clubId, String inputPassword) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final String hashedInputPassword = _hashPassword(inputPassword);

    try {
      final QuerySnapshot userSnapshot = await firestore
          .collection('users')
          .where('userId', isEqualTo: clubId)
          .limit(1)
          .get();

      if (userSnapshot.docs.isEmpty) {
        // No user found
        return false;
      }

      final userData = userSnapshot.docs.first.data();
      if (userData != null &&
          (userData as Map)['hashedPassword'] == hashedInputPassword) {
        // Password matches
        UserConfig.setUserModel(
            UserModel.fromFirestore(userSnapshot.docs.first));
        return true;
      } else {
        // Password does not match
        return false;
      }
    } catch (e) {
      // Handle errors, such as network issues or Firestore errors
      log(e.toString());
      return false;
    }
  }

  String _hashPassword(String password) {
    // This is a simple SHA-256 hash. Real applications require stronger methods
    // such as bcrypt with salts, which cannot be securely implemented client-side.
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }
}
