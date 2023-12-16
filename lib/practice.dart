import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:praaccc/addRating.dart';
import 'package:praaccc/home.dart';

class PracticePage extends StatefulWidget {
  const PracticePage({super.key, required this.index});
  final int index;

  @override
  State<PracticePage> createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage> {
  var am = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        border: Border.all(width: 0, color: Colors.transparent),
        middle: Text(
          "${days[widget.index]['weekday']}, ${months[days[widget.index]["month"] - 1]} ${days[widget.index]["day"].toString() + numberEndings[days[widget.index]["day"] % 10 - 1]}",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        previousPageTitle: 'Home',
      ),
      body: ListView.builder(
          itemCount: (3 +
              (days[widget.index][am ? 'AM' : "PM"]['ratings'].length)) as int,
          itemBuilder: (context, index) {
            if (index == 0) {
              if (days[widget.index]['PM']['jv'] == true ||
                  days[widget.index]['PM']['v'] == true) {
                return Row(
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
                );
              } else {
                return Container();
              }
            } else if (index == 1) {
              return Padding(
                  padding: const EdgeInsets.only(left: 15.0, top: 5),
                  child: Text(
                    "${am ? 'AM' : 'PM'} Rating: ${days[widget.index][am ? "AM" : "PM"]["avgRating"].toStringAsFixed(2)}/10",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ));
            } else if (index == 2) {
              return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          showDragHandle: true,
                          useSafeArea: true,
                          constraints: BoxConstraints.expand(),
                          isScrollControlled: true,
                          builder: (context) {
                            return AddRating(
                              am: am,
                              index: widget.index,
                              pmExists:
                                  days[widget.index]['PM']['jv'] == true ||
                                          days[widget.index]['PM']['v'] == true
                                      ? true
                                      : false,
                            );
                          }).then((value) {
                        setState(() {});
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(CupertinoIcons.add_circled_solid, size: 25),
                        Padding(
                            padding: EdgeInsets.only(
                                right: 10, top: 25, bottom: 25)),
                        Text("Add Rating",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ));
            } else {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                child: ElevatedButton(
                  onPressed: () {},
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: IntrinsicHeight(
                      child: Stack(
                        children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    "${days[widget.index][am ? "AM" : "PM"]["ratings"][index - 3]['name']}",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold)),
                              )),
                          Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 50, left: 10, bottom: 10),
                                child: Text(
                                    days[widget.index][am ? "AM" : "PM"]
                                                ["ratings"][index - 3]['rating']
                                            .toString() +
                                        '/10' +
                                        "${days[widget.index][am ? "AM" : "PM"]["ratings"][index - 3]['comment'] != '' ? ': ' + days[widget.index][am ? "AM" : "PM"]["ratings"][index - 3]['comment'] : ''}",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal)),
                              )),
                          Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 18, right: 10, bottom: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    days[widget.index][am ? "AM" : "PM"]
                                                ["ratings"][index - 3]['v'] ==
                                            true
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Container(
                                              color: Colors.purple[900],
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
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
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Container(
                                              color: Colors.blue[900],
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 2.0,
                                                        horizontal: 10),
                                                child: Text(
                                                  "JV",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            )),
                                    Padding(padding: EdgeInsets.only(right: 8)),
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Container(
                                          color: Colors.orange[900],
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 2.0, horizontal: 10),
                                            child: Text(
                                              days[widget.index][am
                                                              ? "AM"
                                                              : "PM"]["ratings"]
                                                          [index - 3]['grade']
                                                      .toString() +
                                                  'th',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              );
              // return Text(
              //     "${days[widget.index][am ? "AM" : "PM"]["ratings"][index - 3]['name']}: ${days[widget.index][am ? "AM" : "PM"]["ratings"][index - 3]['rating']}/10");
            }
          }),
    );
  }
}
