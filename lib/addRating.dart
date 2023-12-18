import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:praaccc/home.dart';
import 'dart:io';

class AddRating extends StatefulWidget {
  const AddRating({super.key, this.am, this.index, this.pmExists});
  final am;
  final index;
  final pmExists;

  @override
  State<AddRating> createState() => _AddRatingState();
}

List<String> weekdays = [
  "Sunday",
  'Monday',
  'Tuesday',
  "Wednesday",
  "Thursday",
  "Friday",
  "Saturday",
  "Sunday"
];

class _AddRatingState extends State<AddRating> {
  int holiday = 1;
  var clicked = false;
  List<int> varsit = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  bool am = true;
  final TextEditingController _comment = TextEditingController();
  final TextEditingController _name = TextEditingController();
  var ratings = [];
  bool varsity = false;
  bool admin = false;
  List<int> grades = [9, 10, 11, 12];
  int grade = 9;

  @override
  void initState() {
    super.initState();
    setState(() {
      am = widget.am;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      widget.pmExists
          ? Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Text(
                "Which practice do you want to rate?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ))
          : Container(),
      widget.pmExists
          ? Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 5),
                  child: SizedBox(
                      width: MediaQuery.sizeOf(context).width / 2 - 15,
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith((states) {
                              // If the button is pressed, return green, otherwise blue
                              if (am) {
                                return Theme.of(context)
                                    .colorScheme
                                    .surfaceTint
                                    .withAlpha(60);
                              }
                              return null;
                            }),
                          ),
                          onPressed: () {
                            setState(() {
                              am = true;
                            });
                          },
                          child: Text(
                            "AM",
                            textAlign: TextAlign.center,
                          ))),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0, left: 5),
                  child: SizedBox(
                      width: MediaQuery.sizeOf(context).width / 2 - 15,
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith((states) {
                              // If the button is pressed, return green, otherwise blue
                              if (!am) {
                                return Theme.of(context)
                                    .colorScheme
                                    .surfaceTint
                                    .withAlpha(60);
                              }
                              return null;
                            }),
                          ),
                          onPressed: () {
                            setState(() {
                              am = false;
                            });
                          },
                          child: Text(
                            "PM",
                            textAlign: TextAlign.center,
                          ))),
                ),
              ],
            )
          : Container(),
      Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: Text(
            "What do you rate this practice?",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          )),
      Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: CupertinoSlidingSegmentedControl<int>(
            groupValue: holiday,
            onValueChanged: (int? value) {
              if (value != null) {
                setState(() {
                  holiday = value;
                });
              }
            },
            backgroundColor:
                Theme.of(context).colorScheme.surfaceTint.withAlpha(38),
            thumbColor: Theme.of(context).colorScheme.primary.withAlpha(50),
            children: <int, Widget>{
              1: Padding(
                padding: EdgeInsets.symmetric(horizontal: 1),
                child: Text(
                  '1',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ),
              2: Padding(
                padding: EdgeInsets.symmetric(horizontal: 1),
                child: Text(
                  '2',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ),
              3: Padding(
                padding: EdgeInsets.symmetric(horizontal: 1),
                child: Text(
                  '3',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ),
              4: Padding(
                padding: EdgeInsets.symmetric(horizontal: 1),
                child: Text(
                  '4',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ),
              5: Padding(
                padding: EdgeInsets.symmetric(horizontal: 1),
                child: Text(
                  '5',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ),
              6: Padding(
                padding: EdgeInsets.symmetric(horizontal: 1),
                child: Text(
                  '6',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ),
              7: Padding(
                padding: EdgeInsets.symmetric(horizontal: 1),
                child: Text(
                  '7',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ),
              8: Padding(
                padding: EdgeInsets.symmetric(horizontal: 1),
                child: Text(
                  '8',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ),
              9: Padding(
                padding: EdgeInsets.symmetric(horizontal: 1),
                child: Text(
                  '9',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ),
              10: Padding(
                padding: EdgeInsets.symmetric(horizontal: 1),
                child: Text(
                  '10',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ),
            },
          )),
      Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: Text(
            "Any specific comments?",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          )),
      Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: TextField(
            controller: _comment,
            autofocus: true,
          )),
      FirebaseAuth.instance.currentUser!.uid == "0S8KYOLXPZVsLvdjAE6dTniogpi1"
          ? Text(
              'Hold Add Rating button to enable admin',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            )
          : Container(),
      admin
          ? Padding(
              padding: EdgeInsets.only(top: 0, bottom: 0),
              child: Text(
                "display name",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ))
          : Container(),
      admin
          ? Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                controller: _name,
              ),
            )
          : Container(),
      admin
          ? Padding(
              padding: EdgeInsets.only(top: 0, bottom: 0),
              child: Text(
                "grade",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ))
          : Container(),
      admin
          ? Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: CupertinoSlidingSegmentedControl<int>(
                groupValue: grade,
                onValueChanged: (int? value) {
                  if (value != null) {
                    setState(() {
                      grade = value;
                    });
                  }
                },
                backgroundColor:
                    Theme.of(context).colorScheme.surfaceTint.withAlpha(38),
                thumbColor: Theme.of(context).colorScheme.primary.withAlpha(50),
                children: <int, Widget>{
                  9: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      '9th',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                  ),
                  10: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      '10th',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                  ),
                  11: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      '11th',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                  ),
                  12: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      '12th',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                  ),
                },
              ))
          : Container(),
      admin
          ? Padding(
              padding: EdgeInsets.only(top: 0, bottom: 0),
              child: Text(
                "varsity?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ))
          : Container(),
      admin
          ? Switch(
              value: varsity,
              onChanged: (bool vars) {
                setState(() {
                  varsity = vars;
                });
              })
          : Container(),
      Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              onLongPress: () {
                print(FirebaseAuth.instance.currentUser!.photoURL!);
                if (FirebaseAuth.instance.currentUser!.uid ==
                    "0S8KYOLXPZVsLvdjAE6dTniogpi1") {
                  setState(() {
                    admin = !admin;
                  });
                }
              },
              onPressed: () {
                if (!clicked) {
                  clicked = true;
                  ratings = days[widget.index][am ? "AM" : "PM"]['ratings'];
                  ratings.add({
                    'name': !admin
                        ? FirebaseAuth.instance.currentUser!.displayName
                        : _name.text,
                    'rating': holiday,
                    'comment': _comment.text,
                    'v': !admin
                        ? FirebaseAuth.instance.currentUser!.photoURL!
                                        .split(' ')[1] ==
                                    "true" ||
                                FirebaseAuth.instance.currentUser!.photoURL!
                                        .split('%20')[1] ==
                                    "true"
                            ? true
                            : false
                        : varsity,
                    'uid': !admin ? FirebaseAuth.instance.currentUser!.uid : '',
                    'grade': !admin
                        ? int.parse(FirebaseAuth.instance.currentUser!.photoURL!
                            .split(' ')[0]
                            .split('%20')[0]
                            .replaceAll('[', '')
                            .replaceAll(',', ''))
                        : grade,
                  });
                  FirebaseFirestore.instance
                      .collection("days")
                      .doc(days[widget.index]['date'].toString())
                      .update({
                    am ? "AM" : "PM": {
                      'avgRating': ((days[widget.index][am ? "AM" : "PM"]
                                      ['avgRating'] *
                                  days[widget.index][am ? "AM" : "PM"]
                                      ["numOfRatings"] +
                              holiday) /
                          (days[widget.index][am ? "AM" : "PM"]
                                  ['numOfRatings'] +
                              1)),
                      'numOfRatings': days[widget.index][am ? "AM" : "PM"]
                              ["numOfRatings"] +
                          1,
                      "jv": days[widget.index][am ? "AM" : "PM"]['jv'],
                      "v": days[widget.index][am ? "AM" : "PM"]['v'],
                      "ratings": ratings,
                    }
                  });
                  Navigator.pop(context);
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.add_circled_solid, size: 25),
                  Padding(
                      padding: EdgeInsets.only(right: 10, top: 25, bottom: 25)),
                  Text("Add Rating",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            )),
      ),
      Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.paddingOf(context).bottom +
                  MediaQuery.viewInsetsOf(context).bottom))
    ]);
  }
}
