import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learn/models/candidate_model.dart';

class VotingResultPage extends StatefulWidget {
  const VotingResultPage({super.key});

  @override
  State<VotingResultPage> createState() => _VotingResultPageState();
}

class _VotingResultPageState extends State<VotingResultPage> {
  late Map<String, CandidateModel> highestVotedCandidates;

  @override
  void initState() {
    super.initState();
    fetchHighestVotedCandidates().then((data) {
      setState(() {
        highestVotedCandidates = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: ListView.builder(
        itemCount: highestVotedCandidates.length,
        itemBuilder: (context, index) {
          String category = highestVotedCandidates.keys.elementAt(index);
          CandidateModel candidate = highestVotedCandidates[category]!;
          return ListTile(
            leading: Image.network(candidate.info?.imageUrl ?? '',
                width: 100, fit: BoxFit.cover),
            title: Text('${candidate.info?.name} - ${candidate.type}'),
            subtitle: Text(
                'Votes: ${candidate.numberOfVotes}'),
          );
        },
      ),
    );
  }

  Future<Map<String, CandidateModel>> fetchHighestVotedCandidates() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('candidates').get();
    Map<String, List<CandidateModel>> candidatesByCategory = {};

    // Organize candidates by category
    for (var doc in snapshot.docs) {
      final candidate = CandidateModel.fromFirestore(doc);
      candidatesByCategory
          .putIfAbsent(candidate.type ?? '', () => [])
          .add(candidate);
    }

    // Find the highest-voted candidate in each category
    Map<String, CandidateModel> highestVotedCandidates = {};
    candidatesByCategory.forEach((category, candidates) {
      // Sort candidates by votes in descending order
      candidates.sort(
          (a, b) => b.numberOfVotes?.compareTo(a.numberOfVotes ?? 0) ?? 0);
      final highestVoted = candidates.first;

      highestVotedCandidates[category] = highestVoted;
    });

    return highestVotedCandidates;
  }
}
