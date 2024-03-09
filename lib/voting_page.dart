import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learn/config/user_config.dart';
import 'package:learn/home_page.dart';
import 'package:learn/models/candidate_model.dart';

class VotingPage extends StatefulWidget {
  final List<CandidateModel> candidates;

  const VotingPage({super.key, required this.candidates});

  @override
  State<VotingPage> createState() => _VotingPageState();
}

class _VotingPageState extends State<VotingPage> {
  final PageController _pageController = PageController();
  late List<String?> _candidateTypes;
  Timer? _timer;
  int _start = 300; // 300 seconds for 5 minutes

  @override
  void initState() {
    super.initState();
    // _startTimer();

    _candidateTypes =
        widget.candidates.map((candidate) => candidate.type).toSet().toList();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
          updateUserHasVoted(UserConfig.userModel?.docId);
          Navigator.of(context).pop(); // Navigate back when timer reaches 0
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 47,
        title: const Text("Votage"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => (_pageController.page ?? 0) > 0
              ? _pageController.previousPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut)
              : Navigator.pop(context),
        ),
        backgroundColor: const Color(0xFF00B0FF),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 32.0,
          fontWeight: FontWeight.w600,
        ),
        actions: [
          Center(
            child: Text(
              "${(_start ~/ 60).toString().padLeft(2, '0')}:${(_start % 60).toString().padLeft(2, '0')}",
              style: const TextStyle(fontSize: 32),
            ),
          )
        ],
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: _candidateTypes.length,
        itemBuilder: (context, page) => buildCandidatePage(context, page),
      ),
    );
  }

  // Helper method to build each candidate page
  Widget buildCandidatePage(BuildContext context, int page) {
    List<CandidateModel> filteredCandidates = widget.candidates
        .where((candidate) => candidate.type == _candidateTypes[page])
        .toList();

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 16.0),
          alignment: Alignment.center,
          child: Text(
            "${_candidateTypes[page]} Candidates",
            style: const TextStyle(
                color: Colors.black,
                fontSize: 22.0,
                fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(
            height: 40,
            child: Text("Choose only one",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                    fontWeight: FontWeight.w800))),
        Expanded(
          child: ListView.builder(
            itemCount: filteredCandidates.length,
            itemBuilder: (context, index) =>
                buildCandidateItem(context, filteredCandidates, index, page),
          ),
        ),
      ],
    );
  }

// Helper method to build each candidate item
  Widget buildCandidateItem(BuildContext context,
      List<CandidateModel> candidates, int index, int page) {
    final candidate = candidates[index];
    return Column(
      children: [
        Image.network(candidate.info?.imageUrl ?? ''),
        Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(candidate.info?.name ?? '',
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 25.0,
                  fontWeight: FontWeight.w800)),
        ),
        MaterialButton(
          color: const Color(0xFF00B0FF),
          minWidth: 150,
          height: 50,
          onPressed: () => voteForCandidate(context, candidate, page),
          child: const Text(
            "Vote",
            style: TextStyle(
              color: Colors.white,
              fontSize: 23.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 24.0),
      ],
    );
  }

  Future<void> updateCandidateVote(CandidateModel candidate) async {
    final candidateRef =
        FirebaseFirestore.instance.collection('candidates').doc(candidate.id);
    final newVoteCount = (candidate.numberOfVotes ?? 0) + 1;
    final List<String> newVotersUserIds =
        List.from(candidate.votersUserIds ?? [])
          ..add(UserConfig.userModel?.userId ?? '');

    try {
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.update(candidateRef, {
          'numberOfVotes': newVoteCount,
          'votersUserIds': newVotersUserIds,
        });
      });
      log("Vote updated successfully");
    } catch (e) {
      log("Error updating vote: $e");
    }
  }

  Future<void> updateUserVotingChoice(
      String? usersDocId, String? candidateType, String? candidateId) async {
    final userRef =
        FirebaseFirestore.instance.collection('users').doc(usersDocId);

    try {
      // Fetch the current user document
      final doc = await userRef.get();
      if (doc.exists) {
        Map<String, dynamic> userData = doc.data() as Map<String, dynamic>;
        // Get the current votingChoices map, or initialize it if it doesn't exist
        Map votingChoices = userData['votingChoices'] ?? {};
        // Update the specific candidate type with the new candidate ID
        votingChoices[candidateType] = candidateId;

        // Update the user document with the modified votingChoices map
        await userRef.update({
          'votingChoices': votingChoices,
        });
        log("User voting choice updated successfully");
      }
    } catch (e) {
      log("Error updating user voting choice: $e");
    }
  }

  Future<void> updateUserHasVoted(String? usersDocId) async {
    final userRef =
        FirebaseFirestore.instance.collection('users').doc(usersDocId);

    try {
      // Fetch the current user document
      final doc = await userRef.get();
      if (doc.exists) {
        await userRef.update({
          'hasVoted': true,
          'voteTimestamp': DateTime.now(),
        });
        log("User voting choice updated successfully");
      }
    } catch (e) {
      log("Error updating user voting choice: $e");
    }
  }

  void voteForCandidate(
      BuildContext context, CandidateModel candidate, int? page) async {
    // Update the candidate's vote count and voters list
    updateCandidateVote(candidate);

    // Update the user's voting choice
    updateUserVotingChoice(UserConfig.userModel?.docId,
        candidate.type?.splitMapJoin(' ').toLowerCase(), candidate.id);

    updateUserHasVoted(UserConfig.userModel?.docId);

    // Navigate to the next candidate type or finish voting
    if ((page ?? 0) >= _candidateTypes.length - 1) {
      // This is the last candidate type, navigate to the HomePage or a voting completion page
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const HomePage()));
    } else {
      // There are more candidate types to vote for, proceed to the next page
      _pageController.nextPage(
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    }
  }
}
