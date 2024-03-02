import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:learn/main.dart';
import 'package:learn/president.dart';

class VotingScreen extends StatefulWidget {
  @override
  _VotingScreenState createState() => _VotingScreenState();
}

class _VotingScreenState extends State<VotingScreen> {
  List<President> president = [
    President(name: '1. Mahmoud Elkhateb', image: 'images/khateb.jpg'),
    President(name: '2. Mahmoud Taher', image: 'images/taher.jpg'),
    President(name: '3. Huseein Labib', image: 'images/labeb.jpg'),
  ];
  List<President> selectedpresident = [];

  President? selectedPresident;

  void _toggleCandidate(President president) {
    setState(() {
      if (selectedpresident.contains(president)) {
        selectedpresident.remove(president);
      } else {
        if (selectedpresident.length < 2) {
          selectedpresident.add(president);
        } else {
          // Optionally, you can show a message indicating the user has reached the limit
          // or prevent further selection beyond the limit.
          // For simplicity, I'm just printing a message here.
          print('You can only vote for 3 candidates.');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            color: const Color.fromARGB(255, 0, 0, 0),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => MyApp()));
            },
            icon: Icon(Icons.arrow_back_sharp),
          ),
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
      body: Expanded(
        child: ListView.builder(
          itemCount: president.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedPresident = president[index];
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    president[index].image,
                    height: 400,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(
                    height: 2.0,
                  ),
                  Text(president[index].name,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 23.0,
                        fontWeight: FontWeight.w600,
                      )),
                  SizedBox(height: 4.0, width: 60.0),
                  selectedPresident?.name == president[index].name
                      ? Icon(Icons.check_circle,
                          color: const Color(0xFF00B0FF), size: 32.0)
                      : Container(),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Perform actions with selected candidates, such as submitting the votes.
          print(
              'Selected Candidates: ${selectedpresident.map((candidate) => candidate.name).toList()}');
        },
        child: Icon(
          Icons.check_circle_sharp,
          color: const Color(0xFF00B0FF),
        ),
      ),
    );
  }
}

class President {
  final String name;
  final String image;

  President({required this.name, required this.image});
}
