import 'package:flutter/material.dart';
import 'package:learn/candidates_page.dart';
import 'package:learn/models/candidate_model.dart';

class AboutPage extends StatelessWidget {
  final List<CandidateModel> candidates;

  const AboutPage({super.key, required this.candidates});

  @override
  Widget build(BuildContext context) {
    List<String?> candidateTypes = [
      'President',
      'Vice President',
      'Club Treasury',
      'Member',
      'Youth Member',
    ];

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 47,
        title: const Text("Votage"),
        centerTitle: true,
        backgroundColor: const Color(0xFF00B0FF),
        titleTextStyle: const TextStyle(
          color: Color.fromARGB(255, 0, 0, 0),
          fontSize: 32.0,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Column(
        children: [
          Image.asset(
            "images/aboutcandidate.png",
            height: 245,
            width: 250,
          ),
          Container(
            alignment: Alignment.center,
            child: const Text(
              "Select Categories",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25.0,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: candidateTypes.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () {
                      List<CandidateModel> filteredCandidates = candidates
                          .where((candidate) =>
                              candidate.type == candidateTypes[index])
                          .toList();

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CandidatesPage(
                            candidates: filteredCandidates,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      candidateTypes[index] ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 23.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
