import 'package:flutter/material.dart';

import 'package:learn/about.dart';
import 'package:learn/chat.dart';

import 'package:learn/vote.dart';

import 'package:learn/getstart.dart';

void main() {
  runApp(
    MaterialApp(home: mainpage()),
  );
}

class MyApp extends StatelessWidget {
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
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset("images/homepage.png"),
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    "Home page",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Spacer(),
                Container(
                    child: Column(
                  children: [
                    MaterialButton(
                      color: const Color(0xFF00B0FF),
                      minWidth: 325,
                      height: 62,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const about()));
                      },
                      child: const Text("About Candidate",
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
                      minWidth: 325,
                      height: 62,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const vote()));
                      },
                      child: const Text("Vote",
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 254, 254),
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
                      minWidth: 325,
                      height: 62,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => VotingScreen()));
                      },
                      child: const Text("Show Result",
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 23.0,
                            fontWeight: FontWeight.w600,
                          )),
                    )
                  ],
                )),
                Spacer(),
              ],
            )));
  }
}
