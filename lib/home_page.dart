import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learn/about_page.dart';
import 'package:learn/admin_panel_page.dart';
import 'package:learn/config/user_config.dart';
import 'package:learn/models/candidate_model.dart';
import 'package:learn/models/user_model.dart';
import 'package:learn/voting_intro_page.dart';
import 'package:learn/voting_result_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            UserConfig.setUserModel(UserModel.fromFirestore(snapshot.data!.docs
                .where((user) => user['userId'] == UserConfig.userModel?.userId)
                .first));
          }

          return StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('candidates').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              List<CandidateModel> candidates = snapshot.data!.docs
                  .map((doc) => CandidateModel.fromFirestore(doc))
                  .toList();

              return _buildBody(context, candidates);
            },
          );
        },
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      toolbarHeight: 47,
      title: const Text("Votage"),
      centerTitle: true,
      backgroundColor: const Color(0xFF00B0FF),
      titleTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 32.0,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildBody(BuildContext context, List<CandidateModel> candidates) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset("images/homepage.png"),
        const Text("Home page",
            style: TextStyle(
                color: Colors.black,
                fontSize: 25.0,
                fontWeight: FontWeight.w800)),
        const SizedBox(height: 16.0),
        UserConfig.userModel?.isAdmin == true
            ? Column(
                children: [
                  const SizedBox(height: 16.0),
                  _buildButton(
                      context, "Admin Panel", () => const AdminPanelPage()),
                ],
              )
            : const SizedBox(),
        const SizedBox(height: 16.0),
        _buildButton(context, "About Candidate",
            () => AboutPage(candidates: candidates)),
        UserConfig.userModel?.hasVoted == false ||
                UserConfig.userModel?.isAdmin == true
            ? Column(
                children: [
                  const SizedBox(height: 16.0),
                  _buildButton(context, "Vote",
                      () => VotingIntroPage(candidates: candidates)),
                ],
              )
            : const SizedBox(),
        UserConfig.userModel?.hasVoted == true
            ? Column(
                children: [
                  const SizedBox(height: 16.0),
                  _buildButton(
                      context, "Show Result", () => const VotingResultPage()),
                ],
              )
            : const SizedBox(),
      ],
    );
  }

  Widget _buildButton(
      BuildContext context, String text, Widget Function() pageBuilder) {
    return MaterialButton(
      color: const Color(0xFF00B0FF),
      minWidth: 325,
      height: 62,
      onPressed: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => pageBuilder())),
      child: Text(text,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 23.0,
              fontWeight: FontWeight.w600)),
    );
  }
}
