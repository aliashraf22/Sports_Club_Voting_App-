import 'package:flutter/material.dart';
import 'package:learn/about.dart';

class member extends StatelessWidget {
  const member({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
                leading: IconButton(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => about()));
                  },
                  icon: Icon(Icons.arrow_back_sharp),
                ),
                toolbarHeight: 47,
                title: const Text("Votage"),
                centerTitle: true,
                backgroundColor: const Color(0xFF00B0FF),
                titleTextStyle: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 32.0,
                    fontWeight: FontWeight.w500)),
            body: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                  Container(
                      height: 80,
                      width: 400,
                      alignment: Alignment.center,
                      child: const Text("Member",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25.0,
                            fontWeight: FontWeight.w800,
                          ))),
                  Container(
                      width: 300,
                      height: 300,
                      child: Image.asset(
                        "images/Hossam Ghaly.jpg",
                      )),
                  Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: const Text("1. hossam ghaly",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25.0,
                            fontWeight: FontWeight.w800,
                          ))),
                  Container(
                      alignment: Alignment.center,
                      child: const Text("INFO:",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25.0,
                            fontWeight: FontWeight.w800,
                          ))),
                  Container(
                      alignment: Alignment.topCenter,
                      width: 340,
                      child: const Text(
                          "من أكثر لاعبي النادي الأهلي لكرة القدم شعبية، حصل على لقب أفضل لاعب في أفريقيا لعام 1983، بعد اعتزاله الكرة، انتخب عضوًا لمجلس الإدارة سنة 1988، وفي عام 2000 عاد الخطيب مرة أخرى إلى الانتخابات، ونجح في الحصول علي المركز الأول في العضوية، وفي عام 2002 انتخب أمينًا للصندوق، وفي انتخابات 2004 انتخب نائبًا لرئيس النادي، وفي 30 نوفمبر 2017 خاض الانتخابات على منصب الرئيس، وفاز على محمود طاهر، وأصبح رئيسًا للنادي.",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 23.0,
                            fontWeight: FontWeight.w600,
                          ))),
                  Container(
                      alignment: Alignment.topCenter,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(9.0)),
                      ),
                      width: 300,
                      height: 300,
                      child: Image.asset(
                        fit: BoxFit.fill,
                        "images/abdelhalem.jpg",
                        width: 300,
                        height: 300,
                      )),
                  Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: const Text("2. Abdelhalem Ali",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25.0,
                            fontWeight: FontWeight.w800,
                          ))),
                  Container(
                      alignment: Alignment.topCenter,
                      child: const Text("INFO:",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25.0,
                            fontWeight: FontWeight.w800,
                          ))),
                  Container(
                      width: 340,
                      alignment: Alignment.center,
                      child: const Text(
                          "أصبح عضوًا في مجلس الإدارة في 1996 في عهد صالح سليم، كما كان أيضاً ضمن أعضاء المجلس في الدورة التالية من عام 2000، ترشح لرئاسة النادي في 2014، وخلف حسن حمدي في رئاسة النادي.",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 23.0,
                            fontWeight: FontWeight.w600,
                          ))),
                  Container(
                      width: 300,
                      height: 300,
                      child: Image.asset(
                        fit: BoxFit.fill,
                        "images/Reda.jpg",
                        width: 300,
                        height: 300,
                      )),
                  Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: const Text("3. Reda Abdelaal",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25.0,
                            fontWeight: FontWeight.w800,
                          ))),
                  Container(
                      alignment: Alignment.topCenter,
                      child: const Text("INFO:",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25.0,
                            fontWeight: FontWeight.w800,
                          ))),
                  Container(
                      width: 340,
                      alignment: Alignment.center,
                      child: const Text(
                          "هو لاعب كرة يد مصري سابق، التحق بنادي الزمالك في عام 1968 حيث كان عمره 13 عامًا، حقق حسين لبيب 21 بطولة مع نادي الزمالك، و7 بطولات في الدوري المصري المحترفين لكرة اليد، و9 بطولات في كأس مصر، و5 بطولات أفريقية.",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 23.0,
                            fontWeight: FontWeight.w600,
                          ))),
                  Container(
                      height: 100,
                      child: Column(
                        children: [
                          MaterialButton(
                            color: const Color(0xFF00B0FF),
                            minWidth: 325,
                            height: 62,
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => about()));
                            },
                            child: const Text("Back",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 23.0,
                                  fontWeight: FontWeight.w600,
                                )),
                          )
                        ],
                      )),
                ]))));
  }
}
