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
  final Map<String, CandidateModel> _selectedCandidates = {};
  final List<CandidateModel> _members = [];
  final List<CandidateModel> _youthMembers = [];
  Timer? _timer;
  int _start = 600; // 600 seconds for 10 minutes

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

  bool _isMember(String? stringToCompare) {
    return stringToCompare == "Member";
  }

  bool _isYouthMember(String? stringToCompare) {
    return stringToCompare == "Youth Member";
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
        SizedBox(
          height: 40,
          child: Text(
            _isMember(_candidateTypes[page])
                ? "Choose Six Members"
                : _isYouthMember(_candidateTypes[page])
                    ? "Choose Three Youth Members"
                    : "Choose Only One",
            style: const TextStyle(
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
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(300, 60),
                      backgroundColor: const Color(0xFF00B0FF),
                    ),
                    onPressed: !_enableSubmit(page)
                        ? null
                        : () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("warning"),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text("Are you sure? You selected:"),
                                      const SizedBox(height: 12.0),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: _isMember(
                                                _candidateTypes[page])
                                            ? _members
                                                .map((e) =>
                                                    Text(e.info?.name ?? ''))
                                                .toList()
                                            : _isYouthMember(
                                                    _candidateTypes[page])
                                                ? _youthMembers
                                                    .map((e) => Text(
                                                        e.info?.name ?? ''))
                                                    .toList()
                                                : _selectedCandidates.entries
                                                    .map(
                                                      (e) => Text(
                                                        e.key ==
                                                                _candidateTypes[
                                                                    page]
                                                            ? e.value.info
                                                                    ?.name ??
                                                                ''
                                                            : '',
                                                      ),
                                                    )
                                                    .toList(),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);

                                        if (_isMember(_candidateTypes[page])) {
                                          for (CandidateModel candidate
                                              in _members) {
                                            updateCandidateVote(candidate);
                                          }
                                        } else if (_isYouthMember(
                                            _candidateTypes[page])) {
                                          for (CandidateModel candidate
                                              in _youthMembers) {
                                            updateCandidateVote(candidate);
                                          }
                                        } else {
                                          CandidateModel? candidate =
                                              _selectedCandidates[
                                                  _candidateTypes[page]];

                                          if (candidate != null) {
                                            updateCandidateVote(candidate);
                                          }
                                        }

                                        updateUserHasVoted(
                                            UserConfig.userModel?.docId);

                                        if (page >=
                                            _candidateTypes.length - 1) {
                                          _navigateToHomePage();
                                        } else {
                                          _pageController.nextPage(
                                              duration: const Duration(
                                                  milliseconds: 500),
                                              curve: Curves.easeInOut);
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
                    child: Text(
                      page == _candidateTypes.length - 1 ? "Submit" : "Next",
                      style: const TextStyle(
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

  bool _enableSubmit(int page) {
    if (_isMember(_candidateTypes[page])) {
      return _members.length == 6;
    } else if (_isYouthMember(_candidateTypes[page])) {
      return _youthMembers.length == 3;
    } else {
      return _selectedCandidates[_candidateTypes[page]!] != null;
    }
  }

// Helper method to build each candidate item
  Widget buildCandidateItem(BuildContext context,
      List<CandidateModel> candidates, int index, int page) {
    final CandidateModel candidate = candidates[index];
    final String? type = candidate.type;
    bool isSelected = _isSelected(candidate, type, page);

    return Column(
      children: [
        Image.network(
          candidate.info?.imageUrl ?? '',
          height: 400,
          width: double.maxFinite,
          fit: BoxFit.fill,
        ),
        Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            candidate.info?.name ?? 'Unknown',
            style: const TextStyle(
                color: Colors.black,
                fontSize: 25.0,
                fontWeight: FontWeight.w800),
          ),
        ),
        MaterialButton(
          color: isSelected ? Colors.green : const Color(0xFF00B0FF),
          minWidth: 150,
          height: 50,
          onPressed: () => _toggleCandidateSelection(candidate, type, page),
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

  bool _isSelected(CandidateModel candidate, String? type, int page) {
    if (_isMember(type)) {
      return _members.contains(candidate);
    } else if (_isYouthMember(type)) {
      return _youthMembers.contains(candidate);
    }
    return _selectedCandidates[_candidateTypes[page]!]?.id == candidate.id;
  }

  void _toggleCandidateSelection(
      CandidateModel candidate, String? type, int page) {
    setState(() {
      if (_isSelected(candidate, type, page)) {
        if (_isMember(type)) {
          _members.remove(candidate);
        } else if (_isYouthMember(type)) {
          _youthMembers.remove(candidate);
        } else {
          _selectedCandidates.remove(type);
        }
      } else {
        if (_canAddCandidate(type)) {
          if (_isMember(type)) {
            _members.add(candidate);
          } else if (_isYouthMember(type)) {
            _youthMembers.add(candidate);
          } else {
            _selectedCandidates[type!] = candidate;
          }
        }
      }
    });
  }

  bool _canAddCandidate(String? type) {
    int limit = type == "Member"
        ? 6
        : type == "Youth Member"
            ? 3
            : 1;
    List<CandidateModel> selectedList = _isMember(type)
        ? _members
        : _isYouthMember(type)
            ? _youthMembers
            : [];
    return selectedList.length < limit;
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
