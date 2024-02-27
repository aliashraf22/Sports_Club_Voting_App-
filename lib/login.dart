// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:learn/main.dart';

import 'package:learn/signup.dart';

// ignore: camel_case_types
class login extends StatelessWidget {
  const login({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: Scaffold(
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
      ),
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
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your Email',
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
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => MyApp()));
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
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const signup()));
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            child: const Text(
              'Dont Have An Account? Signup',
              style: TextStyle(
                fontSize: 20,
                color: Color(0xFF00B0FF),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
