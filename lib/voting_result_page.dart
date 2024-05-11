import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learn/models/candidate_model.dart'; // Make sure this matches the correct path for the model

class VotingResultPage extends StatefulWidget {
  const VotingResultPage({Key? key}) : super(key: key);

  @override
  State<VotingResultPage> createState() => _VotingResultPageState();
}

class _VotingResultPageState extends State<VotingResultPage> {
  Future<Map<String, List<CandidateModel>>>? candidatesByCategory;

  @override
  void initState() {
    super.initState();
    candidatesByCategory = fetchCandidatesByCategory();
  }

  Future<Map<String, List<CandidateModel>>> fetchCandidatesByCategory() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('candidates').get();
    Map<String, List<CandidateModel>> candidates = {};
    for (var doc in snapshot.docs) {
      CandidateModel candidate = CandidateModel.fromFirestore(doc);
      String type = candidate.type ?? 'Unknown';
      candidates.putIfAbsent(type, () => []).add(candidate);
    }
    return candidates;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Voting Results"),
        centerTitle: true,
        backgroundColor: const Color(0xFF00B0FF),
      ),
      body: FutureBuilder<Map<String, List<CandidateModel>>>(
        future: candidatesByCategory,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return const Center(child: Text("No data available"));
          }
          return ListView(
            children: snapshot.data!.entries.map((entry) {
              List<CandidateModel> sortedCandidates = entry.value;
              sortedCandidates.sort((a, b) => b.numberOfVotes?.compareTo(a.numberOfVotes ?? 0) ?? 0);

              int winnerCount = entry.key == "Member" ? 6 : entry.key == "Youth Member" ? 3 : 1;

              return ExpansionTile(
                title: Text(entry.key),
                children: sortedCandidates.map((candidate) {
                  bool isWinner = sortedCandidates.indexOf(candidate) < winnerCount;
                  return ListTile(
                    leading: Image.network(candidate.info?.imageUrl ?? '', width: 50, fit: BoxFit.cover),
                    title: Text(candidate.info?.name ?? 'Unknown'),
                    subtitle: Text('Votes: ${candidate.numberOfVotes}'),
                    tileColor: isWinner ? Colors.lightGreen[100] : null, // Highlight winners
                  );
                }).toList(),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
