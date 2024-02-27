import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:learn/about.dart';
import 'package:learn/main.dart';

class voting extends StatelessWidget {
  const voting({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
                leading: IconButton(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => MyApp()));
                  },
                  icon: Icon(Icons.arrow_back_sharp),
                ),
                toolbarHeight: 47,
                title: const Text(
                  "Votage",
                  textAlign: TextAlign.start,
                ),
                centerTitle: true,
                backgroundColor: const Color(0xFF00B0FF),
                titleTextStyle: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 32.0,
                    fontWeight: FontWeight.w600)),
            body: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                  Container(
                      height: 80,
                      width: 300,
                      alignment: Alignment.center,
                      child: const Text("President Candidates",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25.0,
                            fontWeight: FontWeight.w800,
                          ))),
                  Container(
                      height: 40,
                      width: 300,
                      alignment: Alignment.topCenter,
                      child: const Text("Choose only one ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25.0,
                            fontWeight: FontWeight.w800,
                          ))),
                  Container(
                      width: 300,
                      height: 300,
                      child: Image.asset(
                        "images/khateb.jpg",
                      )),
                  Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: const Text("1. Mahmoud Elkhateb",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25.0,
                            fontWeight: FontWeight.w800,
                          ))),
                  Container(
                      height: 100,
                      child: Column(
                        children: [
                          MaterialButton(
                            color: const Color(0xFF00B0FF),
                            minWidth: 150,
                            height: 50,
                            onPressed: () {},
                            child: const Text("Vote",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 23.0,
                                  fontWeight: FontWeight.w600,
                                )),
                          )
                        ],
                      )),
                  Container(
                      width: 300,
                      height: 300,
                      child: Image.asset(
                        "images/khateb.jpg",
                      )),
                  Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: const Text("1. Mahmoud Elkhateb",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25.0,
                            fontWeight: FontWeight.w800,
                          ))),
                  Container(
                      height: 100,
                      child: Column(
                        children: [
                          MaterialButton(
                            color: const Color(0xFF00B0FF),
                            minWidth: 150,
                            height: 50,
                            onPressed: () {},
                            child: const Text("Vote",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 23.0,
                                  fontWeight: FontWeight.w600,
                                )),
                          )
                        ],
                      )),
                  Container(
                      width: 300,
                      height: 300,
                      child: Image.asset(
                        "images/khateb.jpg",
                      )),
                  Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: const Text("1. Mahmoud Elkhateb",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25.0,
                            fontWeight: FontWeight.w800,
                          ))),
                  Container(
                      height: 100,
                      child: Column(
                        children: [
                          MaterialButton(
                            color: const Color(0xFF00B0FF),
                            minWidth: 150,
                            height: 50,
                            onPressed: () {},
                            child: const Text("Vote",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 23.0,
                                  fontWeight: FontWeight.w600,
                                )),
                          )
                        ],
                      )),
                  Container(
                      height: 80,
                      width: 400,
                      alignment: Alignment.center,
                      child: const Text("Vise President Candidates",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25.0,
                            fontWeight: FontWeight.w800,
                          ))),
                  Container(
                      width: 300,
                      height: 300,
                      child: Image.asset(
                        "images/khateb.jpg",
                      )),
                  Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: const Text("1. Mahmoud Elkhateb",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25.0,
                            fontWeight: FontWeight.w800,
                          ))),
                  Container(
                      height: 100,
                      child: Column(
                        children: [
                          MaterialButton(
                            color: const Color(0xFF00B0FF),
                            minWidth: 150,
                            height: 50,
                            onPressed: () {},
                            child: const Text("Vote",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 23.0,
                                  fontWeight: FontWeight.w600,
                                )),
                          )
                        ],
                      )),
                  Container(
                      width: 300,
                      height: 300,
                      child: Image.asset(
                        "images/khateb.jpg",
                      )),
                  Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: const Text("1. Mahmoud Elkhateb",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25.0,
                            fontWeight: FontWeight.w800,
                          ))),
                  Container(
                      height: 100,
                      child: Column(
                        children: [
                          MaterialButton(
                            color: const Color(0xFF00B0FF),
                            minWidth: 150,
                            height: 50,
                            onPressed: () {},
                            child: const Text("Vote",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 23.0,
                                  fontWeight: FontWeight.w600,
                                )),
                          )
                        ],
                      )),
                  Container(
                      width: 300,
                      height: 300,
                      child: Image.asset(
                        "images/khateb.jpg",
                      )),
                  Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: const Text("1. Mahmoud Elkhateb",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25.0,
                            fontWeight: FontWeight.w800,
                          ))),
                  Container(
                      height: 100,
                      child: Column(
                        children: [
                          MaterialButton(
                            color: const Color(0xFF00B0FF),
                            minWidth: 150,
                            height: 50,
                            onPressed: () {},
                            child: const Text("Vote",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 23.0,
                                  fontWeight: FontWeight.w600,
                                )),
                          )
                        ],
                      )),
                ]))));
  }
}
