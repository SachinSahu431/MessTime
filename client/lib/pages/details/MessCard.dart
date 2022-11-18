import 'package:client/pages/details/Breakfast.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Dinner.dart';
import 'Lunch.dart';
import 'NutrientChart.dart';

// ignore: must_be_immutable
class MessCard extends StatefulWidget {
  String name = 'STUDENT NAME';
  String rollno = 'XXYYBZZZ';
  String month = 'JANUARY';
  String year = '2022';

  MessCard(this.name, this.rollno, this.month, this.year, {Key? key})
      : super(key: key);

  @override
  State<MessCard> createState() => _MessCardState();
}

class _MessCardState extends State<MessCard> {
  final Color _color = Color.fromARGB(204, 0, 0, 0);

  final Color _textColor = Colors.white;

  int breakfastMarked = 0;

  int lunchMarked = 0;

  int dinnerMarked = 0;

  //calculate wheter today is even or odd
  int today = DateTime.now().day % 2;

  @override
  void initState() {
    super.initState();
    loadMarked(0);
    loadMarked(1);
    loadMarked(2);
  }

  //load breakfast marked from shared preferences
  Future<void> loadMarked(int x) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (x == 0) {
      int temp = 0;
      if (today == 1) {
        temp = prefs.getInt("BreakFast1") ?? 0;
      } else {
        temp = prefs.getInt("BreakFast0") ?? 0;
      }

      if (temp == 0) {
        setState(() {
          breakfastMarked = 0;
        });
      } else {
        setState(() {
          breakfastMarked = 1;
        });
      }
    } else if (x == 1) {
      int temp = 0;
      if (today == 1) {
        temp = prefs.getInt("Lunch1") ?? 0;
      } else {
        temp = prefs.getInt("Lunch0") ?? 0;
      }

      if (temp == 0) {
        setState(() {
          lunchMarked = 0;
        });
      } else {
        setState(() {
          lunchMarked = 1;
        });
      }
    } else {
      int temp = 0;
      if (today == 1) {
        temp = prefs.getInt("Dinner1") ?? 0;
      } else {
        temp = prefs.getInt("Dinner0") ?? 0;
      }

      if (temp == 0) {
        setState(() {
          dinnerMarked = 0;
        });
      } else {
        setState(() {
          dinnerMarked = 1;
        });
      }
    }
  }

  //save breakfast marked to shared preferences
  Future<void> saveMarked(int x) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (x == 0) {
      if (today == 1) {
        prefs.setInt("BreakFast1", 1);
      } else {
        prefs.setInt("BreakFast0", 1);
      }
    } else if (x == 1) {
      if (today == 1) {
        prefs.setInt("Lunch1", 1);
      } else {
        prefs.setInt("Lunch0", 1);
      }
    } else {
      if (today == 1) {
        prefs.setInt("Dinner1", 1);
      } else {
        prefs.setInt("Dinner0", 1);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    var day = date.weekday - 1;
    var hour = date.hour;
    // print("hour is ${hour}");
    //get the data of isBreakfast marked from shared preferences

    return Card(
        elevation: 1.0,
        color: _color,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
        child: Container(
            height: 170,
            width: 500,
            padding: const EdgeInsets.only(
                left: 10.0, right: 16.0, top: 15.0, bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Padding(
                //   padding:
                //       const EdgeInsets.only(top: 16.0, left: 10.0, right: 10.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Icon(
                //         Icons.restaurant,
                //         color: _textColor,
                //         size: 30.0,
                //       ),
                //       Icon(
                //         Icons.credit_card_rounded,
                //         color: _textColor,
                //         size: 30.0,
                //       ),
                //     ],
                //   ),
                //
                // ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.name.toUpperCase(),
                          style: GoogleFonts.inconsolata(
                              textStyle: TextStyle(
                            color: _textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ))),
                      Text(widget.rollno.toUpperCase(),
                          style: GoogleFonts.inconsolata(
                              textStyle: TextStyle(
                            color: _textColor,
                            fontSize: 16,
                          ))),
                      Text(
                          "${widget.month.toUpperCase()} ${widget.year.toUpperCase()}",
                          style: GoogleFonts.inconsolata(
                              textStyle: TextStyle(
                            color: _textColor,
                            fontSize: 16,
                          ))),
                    ],
                  ),
                ),

                Padding(
                  padding:
                      const EdgeInsets.only(top: 16.0, left: 10.0, right: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          if (hour >= 8) {
                            if (breakfastMarked == 0) {
                              setState(() {
                                breakfastMarked = 1;
                              });
                              saveMarked(0);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Breakfast(day: day, meal: 0)),
                              );
                            } else {
                              // show popup it cannot be opened
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: const Text("Breakfast Already Done"),
                                  content: const Text(
                                      "You have already marked your breakfast"),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                      },
                                      child: Container(
                                        color: Colors.white,
                                        padding: const EdgeInsets.all(14),
                                        child: const Text("okay"),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                          } else {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text("Breakfast Not Started"),
                                content: const Text(
                                    "Breakfast has not started yet. You can only fill it after 08:00"),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                    child: Container(
                                      color: Colors.white,
                                      padding: const EdgeInsets.all(14),
                                      child: const Text("Okay"),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        child: Icon(
                          Icons.breakfast_dining,
                          //color green if breakfast is marked
                          color:
                              breakfastMarked == 0 ? _textColor : Colors.green,
                          size: 50.0,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // starting time of lunch is 1 PM
                          if (hour >= 13) {
                            if (lunchMarked == 0) {
                              setState(() {
                                lunchMarked = 1;
                              });
                              saveMarked(1);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Lunch(day: day, meal: 1)),
                              );
                            } else {
                              // show popup it cannot be opened
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: const Text("Lunch Already Done"),
                                  content: const Text(
                                      "You have already marked your lunch"),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                      },
                                      child: Container(
                                        color: Colors.white,
                                        padding: const EdgeInsets.all(14),
                                        child: const Text("okay"),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                          } else {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text("Lunch Not Started"),
                                content: const Text(
                                    "Lunch has not started yet. You can only fill it after 13:00"),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                    child: Container(
                                      color: Colors.white,
                                      padding: const EdgeInsets.all(14),
                                      child: const Text("Okay"),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        child: Icon(
                          Icons.lunch_dining,
                          color:
                              lunchMarked == 0 ? _textColor : Colors.green,
                          size: 50.0,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // starting time of dinner is 8 PM
                          if (hour >= 20) {
                            if (dinnerMarked == 0) {
                              setState(() {
                                dinnerMarked = 1;
                              });
                              saveMarked(2);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Dinner(day: day, meal: 2)),
                              );
                            } else {
                              // show notification that it cannot be opened
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: const Text("Dinner Already Done"),
                                  content: const Text(
                                      "You have already marked your dinner"),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                      },
                                      child: Container(
                                        color: Colors.white,
                                        padding: const EdgeInsets.all(14),
                                        child: const Text("okay"),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                          } else {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text("Dinner Not Started"),
                                content: const Text(
                                    "Dinner has not started yet. You can only fill it after 20:00"),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                    child: Container(
                                      color: Colors.white,
                                      padding: const EdgeInsets.all(14),
                                      child: const Text("Okay"),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        child: Icon(
                          Icons.dinner_dining,
                          color:
                              dinnerMarked == 0 ? _textColor : Colors.green,
                          size: 50.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }
}
