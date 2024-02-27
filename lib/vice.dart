import 'package:flutter/material.dart';
import 'package:learn/about.dart';

class vice extends StatelessWidget {
  const vice({super.key});

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
                      child: const Text("Vice President Candidates",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25.0,
                            fontWeight: FontWeight.w800,
                          ))),
                  Container(
                      width: 300,
                      height: 300,
                      child: Image.asset(
                        "images/farouq.jpg",
                      )),
                  Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: const Text("1. Elamry Farouq",
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
                          "العامرى فاروق هو رجل أعمال مصري وشخصية سياسية ورياضية مصرية بارزة حيث شغل عدة مناصب في مجلس إدارة النادي الأهلي المصري وكان أول وزير دولة للرياضة في مصر بعد فصل وزارة الشباب عنها. شغل منصب نائب رئيس مجلس إدارة النادي الأهلي المصري ورئيس مكتبه التنفيذي بعد نجاحه ضمن قائمة الكابتن محمود الخطيب، وكان أحد أهم المستثمرين في مجال التعليم في مصر من خلال امتلاكه لمدارس بيبي جاردن للغات ولدار الفاروق للنشر والتوزيع.",
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
                        "images/elataal.jpeg",
                        width: 300,
                        height: 300,
                      )),
                  Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: const Text("2. Hany Elataal",
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
                          "هاني العتال هو لاعب كرة يد سابق ورجل أعمال مصري الجنسية، حاصل على درجة البكالوريوس في إدارة الأعمال والجدير بالذكر أنه بدأ مسيرته الرياضية مع نادي الزمالك وحقق العديد من الإنجازات، وبعد اعتزاله شغب منصب نائب رئيس مجلس إدارة نادي الزمالك بالإضافة إلى تأسيسه شركة العتال للعديد والصلب، وإن أحد أبرز إنجازات هاني العتال هو أنه استطاع توظيف خبرته الرياضية في تطوير برامج تدريبية للشباب واللاعبين الواعدين، بهدف تطوير رياضة كرة اليد وتعزيز مستوى الأداء في الدولة، كما أنه قام بالعديد من المبادرات الاجتماعية والخيرية، حيث ساهم في دعم العديد من المشاريع الخيرية والمؤسسات الاجتماعية..",
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
                        "images/mando.jpg",
                        width: 300,
                        height: 300,
                      )),
                  Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: const Text("3. Hossam mandoh",
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
