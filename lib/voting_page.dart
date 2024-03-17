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
  final Map<String, String> _selectedCandidates = {};
  Timer? _timer;
  int _start = 300; // 300 seconds for 5 minutes

  @override
  void initState() {
    super.initState();
    _startTimer();

    _candidateTypes =
        widget.candidates.map((candidate) => candidate.type).toSet().toList();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
          updateUserHasVoted(UserConfig.userModel?.docId);
        });

        _navigateToHomePage();
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  void _navigateToHomePage() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => const HomePage(),
        ),
        (route) => false);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    updateUserHasVoted(UserConfig.userModel?.docId);
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
              : _navigateToHomePage(),
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
          child: Text(
            "Choose only one",
            style: TextStyle(
              color: Colors.black,
              fontSize: 25.0,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredCandidates.length + 1,
            itemBuilder: (context, index) {
              if (index == filteredCandidates.length) {
                return Center(
                  child: MaterialButton(
                    color: const Color(0xFF00B0FF),
                    minWidth: 300,
                    height: 60,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("warning"),
                            content: const Text("Are you sure?"),
                            actions: [
                              TextButton(
                                onPressed: ()  {
                                  Navigator.pop(
                                      context); // Close the dialog first

                                  // Assuming updateCandidateVote and updateUserVotingChoice are async methods
                                  // that update your Firestore database with the new vote counts and choices
                                  for (String candidateType
                                      in _selectedCandidates.keys) {
                                    String? candidateId =
                                        _selectedCandidates[candidateType];
                                    if (candidateId != null) {
                                      // Find the candidate model from the list of candidates using the candidateId
                                      CandidateModel? candidate =
                                          widget.candidates.first;

                                      // Update the candidate's vote count
                                       updateCandidateVote(candidate);
                                    }
                                  }

                                  // Mark the user as having voted
                                   updateUserHasVoted(
                                      UserConfig.userModel?.docId);

                                  if (page  >= _candidateTypes.length - 1) {
                                    // This is the last candidate type, navigate to the HomePage or a voting completion page
                                    _navigateToHomePage();
                                  } else {
                                    // There are more candidate types to vote for, proceed to the next page
                                    _pageController.nextPage(
                                        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                                  }
                                },
                                child: const Text("Ok"),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Cancel"),
                              )
                            ],
                          );
                        },
                      );
                    },
                    child: const Text(
                      "Submit",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 23.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              }
              return buildCandidateItem(
                  context, filteredCandidates, index, page);
            },
          ),
        ),
      ],
    );
  }

// Helper method to build each candidate item
  Widget buildCandidateItem(BuildContext context,
      List<CandidateModel> candidates, int index, int page) {
    final candidate = candidates[index];
    bool isSelected =
        _selectedCandidates[_candidateTypes[page]!] == candidate.id;

    return Column(
      children: [
        Image.network(
          candidate.info?.imageUrl ?? '',
          height: 400,
          fit: BoxFit.fill,
        ),
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
          color: isSelected ? Colors.green : const Color(0xFF00B0FF),
          minWidth: 150,
          height: 50,
          onPressed: () => setState(() {
            if (isSelected) {
              _selectedCandidates.remove(_candidateTypes[page]!);
            } else {
              _selectedCandidates[_candidateTypes[page]!] = candidate.id!;
            }
          }),
          child: isSelected
              ? const Icon(Icons.check, color: Colors.white)
              : const Text(
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

  void voteForCandidate(
      BuildContext context, CandidateModel candidate, int? page) async {
    // Update the candidate's vote count and voters list
    updateCandidateVote(candidate);

    updateUserHasVoted(UserConfig.userModel?.docId);

    // Navigate to the next candidate type or finish voting
    if ((page ?? 0) >= _candidateTypes.length - 1) {
      // This is the last candidate type, navigate to the HomePage or a voting completion page
      _navigateToHomePage();
    } else {
      // There are more candidate types to vote for, proceed to the next page
      _pageController.nextPage(
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    }
  }

  Future<void> updateCandidateVote(CandidateModel candidate) async {
    final candidateRef =
        FirebaseFirestore.instance.collection('candidates').doc(candidate.id);
    final newVoteCount = (candidate.numberOfVotes ?? 0) + 1;

    try {
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.update(candidateRef, {
          'numberOfVotes': newVoteCount,
        });
      });
      log("Vote updated successfully");
    } catch (e) {
      log("Error updating vote: $e");
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
}
