import 'package:flutter/material.dart';
import 'package:learn/main.dart';

import 'package:learn/president.dart';

import 'package:learn/vice.dart';

import 'package:learn/treasurer.dart';

import 'package:learn/member.dart';

import 'package:learn/youth.dart';

class about extends StatelessWidget {
  const about({super.key});

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
                title: const Text("Votage"),
                centerTitle: true,
                backgroundColor: const Color(0xFF00B0FF),
                titleTextStyle: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 32.0,
                    fontWeight: FontWeight.w500)),
            body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Image.asset(
                "images/aboutcandidate.png",
                height: 245,
                width: 250,
              ),
              Container(
                  alignment: Alignment.center,
                  child: const Text("Select Categories",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25.0,
                        fontWeight: FontWeight.w800,
                      ))),
              Spacer(),
              Container(
                  child: Column(
                children: [
                  MaterialButton(
                    color: const Color(0xFF00B0FF),
                    minWidth: 250,
                    height: 50,
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => president()));
                    },
                    child: const Text("President",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 23.0,
                          fontWeight: FontWeight.w600,
                        )),
                  )
                ],
              )),
              Spacer(),
              Container(
                  child: Column(
                children: [
                  MaterialButton(
                    color: const Color(0xFF00B0FF),
                    minWidth: 250,
                    height: 50,
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => vice()));
                    },
                    child: const Text("Vice President",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 23.0,
                          fontWeight: FontWeight.w600,
                        )),
                  )
                ],
              )),
              Spacer(),
              Container(
                  child: Column(
                children: [
                  MaterialButton(
                    color: const Color(0xFF00B0FF),
                    minWidth: 250,
                    height: 50,
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => treasurer()));
                    },
                    child: const Text("Club treasurer",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 23.0,
                          fontWeight: FontWeight.w600,
                        )),
                  )
                ],
              )),
              Spacer(),
              Container(
                  child: Column(
                children: [
                  MaterialButton(
                    color: const Color(0xFF00B0FF),
                    minWidth: 250,
                    height: 50,
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => member()));
                    },
                    child: const Text("Member",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 23.0,
                          fontWeight: FontWeight.w600,
                        )),
                  )
                ],
              )),
              Spacer(),
              Container(
                  child: Column(
                children: [
                  MaterialButton(
                    color: const Color(0xFF00B0FF),
                    minWidth: 250,
                    height: 50,
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => youth()));
                    },
                    child: const Text("Youth Member",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 23.0,
                          fontWeight: FontWeight.w600,
                        )),
                  )
                ],
              )),
              Spacer(),
              Container(
                  child: Column(
                children: [
                  MaterialButton(
                    color: const Color(0xFF00B0FF),
                    minWidth: 250,
                    height: 50,
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => MyApp()));
                    },
                    child: const Text("Back",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 23.0,
                          fontWeight: FontWeight.w600,
                        )),
                  )
                ],
              )),
              Spacer(),
            ])));
  }
}
