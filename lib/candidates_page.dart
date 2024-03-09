import 'package:flutter/material.dart';
import 'package:learn/models/candidate_model.dart';

class CandidatesPage extends StatelessWidget {
  final List<CandidateModel> candidates;

  const CandidatesPage({super.key, required this.candidates});

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
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16.0),
            alignment: Alignment.center,
            child: Text(
              "${candidates.first.type} Candidates",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: candidates.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      width: 300,
                      height: 300,
                      child: Image.network(
                        candidates[index].info?.imageUrl ?? '',
                      ),
                    ),
                    Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: Text(
                        candidates[index].info?.name ?? '',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 25.0,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(80.0)),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        "INFO:",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25.0,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      width: 340,
                      child: Text(
                        candidates[index].info?.bio ?? '',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 23.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
