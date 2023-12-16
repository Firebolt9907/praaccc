import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:praaccc/home.dart';

class AddPractice extends StatefulWidget {
  const AddPractice({super.key});

  @override
  State<AddPractice> createState() => _AddPracticeState();
}

Map<String, List<bool>> practiceSchedule = {
  // Sunday is last
  'jvAM': [false, false, true, false, false, true, false],
  'vAM': [true, true, false, true, true, true, false],
  'jvPM': [true, true, true, true, true, false, false],
  'vPM': [true, true, true, true, true, false, false],
};
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

class _AddPracticeState extends State<AddPractice> {
  bool holiday = false;
  var clicked = false;
  List<bool> varsit = [false, true];
  var date = 0;
  var dateName = '';
  DateTime rawDate = DateTime.fromMillisecondsSinceEpoch(0);
  bool exists = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        border: Border.all(width: 0, color: Colors.transparent),
        middle: Text(
          'Add Practice',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        previousPageTitle: 'Home',
      ),
      body: ListView(children: [
        Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Text(
              "What is day was it on?",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )),
        Row(
          children: [
            date == 0
                ? Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 5),
                    child: SizedBox(
                        width: MediaQuery.sizeOf(context).width / 2 - 15,
                        child: ElevatedButton(
                            onPressed: () {
                              rawDate = DateTime.now();
                              date = (rawDate.year * 10000) +
                                  (rawDate.month * 100) +
                                  rawDate.day;
                              dateName = ((rawDate.month * 1000000) +
                                      (rawDate.day * 10000) +
                                      rawDate.year)
                                  .toString();
                              setState(() {});
                            },
                            child: Text(
                              "Today",
                              textAlign: TextAlign.center,
                            ))),
                  )
                : Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 5),
                    child: SizedBox(
                        width: MediaQuery.sizeOf(context).width / 2 - 15,
                        child: Text(
                          "${rawDate.month}/${rawDate.day}/${rawDate.year}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.normal),
                        ))),
            Padding(
              padding: const EdgeInsets.only(right: 10.0, left: 5),
              child: SizedBox(
                  width: MediaQuery.sizeOf(context).width / 2 - 15,
                  child: ElevatedButton(
                      onPressed: () async {
                        rawDate = (await showDatePicker(
                              context: context,
                              currentDate: DateTime.now(),
                              initialDate: rawDate.year < 2020
                                  ? DateTime.now()
                                  : rawDate,
                              firstDate: DateTime(2020), // Start date
                              lastDate: DateTime(2050), // End date
                            )) ??
                            rawDate;
                        date = (rawDate.year * 10000) +
                            (rawDate.month * 100) +
                            rawDate.day;
                        dateName = ((rawDate.month * 1000000) +
                                (rawDate.day * 10000) +
                                rawDate.year)
                            .toString();
                        setState(() {});
                      },
                      child: Text(
                        date == 0 ? "Pick Day" : "Change Day",
                        textAlign: TextAlign.center,
                      ))),
            ),
          ],
        ),
        Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Text(
              "What schedule is this on?",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )),
        Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: CupertinoSlidingSegmentedControl<bool>(
              groupValue: holiday,
              onValueChanged: (bool? value) {
                if (value != null) {
                  setState(() {
                    holiday = value;
                  });
                }
              },
              backgroundColor:
                  Theme.of(context).colorScheme.surfaceTint.withAlpha(38),
              thumbColor: Theme.of(context).colorScheme.primary.withAlpha(50),
              children: <bool, Widget>{
                false: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'Regular',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                ),
                true: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'Holiday',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                ),
              },
            )),
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 70),
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (rawDate.year >= 2020 && !clicked) {
                          clicked = true;
                          for (var i in days) {
                            if (i != "placeholder" &&
                                i != 'logout' &&
                                i != 'uid') {
                              if (i['date'] == date) {
                                //     Navigator.pushReplacement(
                                // context,
                                // CupertinoPageRoute(
                                //   builder: (context) => AddPractice(),
                                // ));
                                exists = true;
                              }
                            }
                          }
                          if (!exists) {
                            if (holiday == false) {
                              FirebaseFirestore.instance
                                  .collection("days")
                                  .doc(date.toString())
                                  .set({
                                'AM': {
                                  'avgRating': 0,
                                  'jv': practiceSchedule['jvAM']![
                                      rawDate.weekday - 1],
                                  'numOfRatings': 0,
                                  'ratings': [],
                                  'v': practiceSchedule['vAM']![
                                      rawDate.weekday - 1],
                                },
                                'PM': {
                                  'avgRating': 0,
                                  'jv': practiceSchedule['jvPM']![
                                      rawDate.weekday - 1],
                                  'numOfRatings': 0,
                                  'ratings': [],
                                  'v': practiceSchedule['vPM']![
                                      rawDate.weekday - 1],
                                },
                                'date': date,
                                'day': rawDate.day,
                                'month': rawDate.month,
                                'year': rawDate.year,
                                'holiday': false,
                                'weekday': weekdays[rawDate.weekday],
                              }).then((value) => Navigator.pop(context));
                            } else {
                              clicked = true;
                              FirebaseFirestore.instance
                                  .collection("days")
                                  .doc(date.toString())
                                  .set({
                                'AM': {
                                  'avgRating': 0,
                                  'jv': true,
                                  'numOfRatings': 0,
                                  'ratings': [],
                                  'v': true,
                                },
                                'PM': {
                                  'avgRating': 0,
                                  'jv': false,
                                  'numOfRatings': 0,
                                  'ratings': [],
                                  'v': false,
                                },
                                'date': date,
                                'day': rawDate.day,
                                'month': rawDate.month,
                                'year': rawDate.year,
                                'holiday': true,
                                'weekday': weekdays[rawDate.weekday],
                              }).then((value) => Navigator.pop(context));
                            }
                          } else {
                            Navigator.pop(context);
                          }
                        }
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
                    )),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
