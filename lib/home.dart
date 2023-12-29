import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:praaccc/addPractice.dart';
import 'package:praaccc/login.dart';
import 'package:praaccc/main.dart';
import 'package:praaccc/practice.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

List<dynamic> days = ['placeholder', 'logout'];
List<String> months = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];
List<String> numberEndings = [
  'st',
  'nd',
  'rd',
  'th',
  'th',
  'th',
  'th',
  'th',
  'th',
  'th',
];

class _HomePageState extends State<HomePage> {
  bool deleteError = false;

  @override
  void initState() {
    FirebaseFirestore.instance.collection("days").snapshots().listen((event) {
      setState(() {
        days = ['placeholder'];
        days.addAll(event.docs.toList().reversed.toList());
        days.addAll(['logout', 'uid']);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CupertinoNavigationBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          border: Border.all(width: 0, color: Colors.transparent),
          automaticallyImplyLeading: false,
          middle: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "The",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Padding(padding: EdgeInsets.only(left: 10)),
              DefaultTextStyle(
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20.0,
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText('Praaccc',
                        textStyle: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold)),
                    TypewriterAnimatedText('Praaccc',
                        textStyle: TextStyle(
                            color: Colors.teal, fontWeight: FontWeight.bold)),
                    TypewriterAnimatedText('Praaccc',
                        textStyle: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold)),
                    TypewriterAnimatedText('Praaccc',
                        textStyle: TextStyle(
                            color: Colors.pink, fontWeight: FontWeight.bold)),
                    TypewriterAnimatedText('Praaccc',
                        textStyle: TextStyle(
                            color: Colors.yellow, fontWeight: FontWeight.bold)),
                    TypewriterAnimatedText('Praaccc',
                        textStyle: TextStyle(
                            color: Colors.purple, fontWeight: FontWeight.bold)),
                    TypewriterAnimatedText('Praaccc',
                        textStyle: TextStyle(
                            color: Colors.orange, fontWeight: FontWeight.bold)),
                    TypewriterAnimatedText('Praaccc',
                        textStyle: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold)),
                  ],
                  repeatForever: true,
                  isRepeatingAnimation: true,
                ),
              ),
              Text(
                "App",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
        body: ListView.builder(
          itemCount: days.length,
          itemBuilder: (context, index) {
            if (days[index] == 'placeholder') {
              return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => AddPractice(),
                          ));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(CupertinoIcons.add_circled_solid, size: 45),
                        Padding(
                            padding: EdgeInsets.only(
                                right: 10, top: 40, bottom: 40)),
                        Text("Add Practice",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ));
            } else if (days[index] == 'logout') {
              return IntrinsicHeight(
                child: Column(
                  children: [
                    TextButton(
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => WillPopScope(
                                        child: FirstPage(),
                                        onWillPop: () async => false,
                                      )));
                        },
                        child: Text("Log Out")),
                    deleteError
                        ? Text(
                            "Press the log out button above, then log in, and then click this button",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.red),
                          )
                        : TextButton(
                            onPressed: () {
                              FirebaseAuth.instance.currentUser!
                                  .delete()
                                  .onError((error, stackTrace) {
                                print(error);
                                print(error
                                    .toString()
                                    .contains("requires-recent-login"));
                                if (error
                                    .toString()
                                    .contains("requires-recent-login")) {
                                  return setState(() {
                                    deleteError = true;
                                  });
                                }
                              }).then(
                                (value) {
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) => WillPopScope(
                                                child: FirstPage(),
                                                onWillPop: () async => false,
                                              )));
                                },
                              );
                            },
                            child: Text("Delete Account")),
                  ],
                ),
              );
            } else if (days[index] == 'uid') {
              print(FirebaseAuth.instance.currentUser!.photoURL);
              if ((FirebaseAuth.instance.currentUser!.photoURL ?? '')
                          .split(' ')
                          .length ==
                      2 ||
                  (FirebaseAuth.instance.currentUser!.photoURL ?? '')
                          .split('%20')
                          .length ==
                      2) {
                return Text(
                  '',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                );
              } else {
                return ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => GradePage(),
                          ));
                    },
                    child: Text(
                        "CLICK THIS AND FIX MY MISTAKE BC IDK HOW TO MANUALLY DO IT MYSELF"));
              }
            } else {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => PracticePage(index: index),
                        ));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      height: days[index]['PM']['jv'] == true ||
                              days[index]['PM']['v'] == true
                          ? 124
                          : 90,
                      width: MediaQuery.sizeOf(context).width,
                      child: Container(
                        // color: Theme.of(context).focusColor,
                        child: Stack(
                          children: [
                            Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      "${days[index]['weekday']}, ${months[days[index]["month"] - 1]} ${days[index]["day"].toString() + numberEndings[((days[index]["day"] % 10) == 0 ? 10 : days[index]["day"] % 10) - 1]}",
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold)),
                                )),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 50, left: 10),
                                  child: Text(
                                      "AM Rating: " +
                                          days[index]['AM']['avgRating']
                                              .toStringAsFixed(1)
                                              .replaceAll(".0", "") +
                                          '/10',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.normal)),
                                )),
                            days[index]['PM']['jv'] == true ||
                                    days[index]['PM']['v'] == true
                                ? Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 80, left: 10),
                                      child: Text(
                                          "PM Rating: " +
                                              days[index]['PM']['avgRating']
                                                  .toStringAsFixed(1)
                                                  .replaceAll(".0", "") +
                                              '/10',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal)),
                                    ))
                                : Container(),
                            Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 52, right: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      days[index]['AM']['jv'] == true
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Container(
                                                color: Colors.blue[900],
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 2.0,
                                                      horizontal: 10),
                                                  child: Text(
                                                    "JV",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ))
                                          : SizedBox.shrink(),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              right:
                                                  days[index]['AM']['v'] == true
                                                      ? 8
                                                      : 0)),
                                      days[index]['AM']['v'] == true
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Container(
                                                color: Colors.purple[900],
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 2.0,
                                                      horizontal: 10),
                                                  child: Text(
                                                    "V",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ))
                                          : SizedBox.shrink(),
                                    ],
                                  ),
                                )),
                            Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 84, right: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      days[index]['PM']['jv'] == true
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Container(
                                                color: Colors.blue[900],
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 2.0,
                                                      horizontal: 10),
                                                  child: Text(
                                                    "JV",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ))
                                          : SizedBox.shrink(),
                                      Padding(
                                          padding: EdgeInsets.only(right: 8)),
                                      days[index]['PM']['v'] == true
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Container(
                                                color: Colors.purple[900],
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 2.0,
                                                      horizontal: 10),
                                                  child: Text(
                                                    "V",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ))
                                          : Container(),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
          },
        ));
  }
}
