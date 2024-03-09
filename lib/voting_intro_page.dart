import 'package:flutter/material.dart';
import 'package:learn/about_page.dart';
import 'package:learn/models/candidate_model.dart';
import 'package:learn/voting_page.dart';

class VotingIntroPage extends StatelessWidget {
  final List<CandidateModel> candidates;

  const VotingIntroPage({super.key, required this.candidates});

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
      body: Column(
        children: [
          Container(
            child: Image.asset(
              "images/vote.png",
            ),
          ),
          Container(
              alignment: Alignment.topCenter,
              child: const Text("Vote page",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                    fontWeight: FontWeight.w800,
                  ))),
          Spacer(),
          Container(
              width: 380,
              child: const Text(
                'there is only 5 min to vote to your candidates time will begin immediately after you click start vote',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              )),
          Spacer(),
          Container(
            child: Column(
              children: [
                MaterialButton(
                  color: const Color.fromARGB(255, 0, 176, 255),
                  minWidth: 200,
                  height: 50,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            VotingPage(candidates: candidates),
                      ),
                    );
                  },
                  child: const Text("Start Vote",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 25.0,
                        fontWeight: FontWeight.w800,
                      )),
                ),
              ],
            ),
          ),
          Spacer(),
          Container(
              width: 380,
              alignment: Alignment.topCenter,
              child: const Text(
                'If you have not made your electoral decision go back to',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              )),
          Container(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                MaterialButton(
                  minWidth: 325,
                  height: 62,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AboutPage(candidates: candidates),
                      ),
                    );
                  },
                  child: const Text("about candidate page",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Color(0xFF00B0FF),
                        fontSize: 23.0,
                        fontWeight: FontWeight.w600,
                      )),
                )
              ],
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
