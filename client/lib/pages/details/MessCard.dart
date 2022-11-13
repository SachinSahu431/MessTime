import 'package:client/pages/details/Breakfast.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Dinner.dart';
import 'Lunch.dart';
import 'NutrientChart.dart';

// ignore: must_be_immutable
class MessCard extends StatelessWidget {
  String name = 'STUDENT NAME';
  String rollno = 'XXYYBZZZ';
  String month = 'JANUARY';
  String year = '2022';


  final Color _color = Color.fromARGB(204, 0, 0, 0);
  final Color _textColor = Colors.white;

  MessCard(this.name, this.rollno, this.month, this.year, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    var day = date.weekday-1;
    var hour = date.hour;
    // print("hour is ${hour}");
    var isBreakfastCalled = 0;
    var isLunchCalled = 0;
    var isDinnerCalled = 0;
    return Card(
        elevation: 1.0,
        color: _color,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
        child: Container(
            height: 170,
            width: 500,
            padding:
                const EdgeInsets.only(left: 10.0, right: 16.0, top: 15.0, bottom: 20.0),
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
                      Text(name.toUpperCase(),
                          style: GoogleFonts.inconsolata(
                              textStyle: TextStyle(
                                color: _textColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ))),
                      Text(rollno.toUpperCase(),
                          style: GoogleFonts.inconsolata(
                              textStyle: TextStyle(
                                color: _textColor,
                                fontSize: 16,
                              ))),
                      Text("${month.toUpperCase()} ${year.toUpperCase()}",
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
                          if(hour >= 8){
                          if(isBreakfastCalled == 0 ){
                            isBreakfastCalled = 1;
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Breakfast(day: day, meal:0 )),
                          );
                          }
                          else
                            {
                              // show popup it cannot be opened
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: const Text("Breakfast Already Done"),
                                  content: const Text("You have already marked your breakfast"),
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
                            }}
                          else
                            {
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: const Text("Breakfast Not Started"),
                                  content: const Text("Breakfast has not started yet. You can only fill it after 08:00"),
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
                          color: _textColor,
                          size: 50.0,

                        ),
                      ),

                      InkWell(
                        onTap: () {
                          // starting time of lunch is 1 PM
                        if(hour >= 13){
                          if(isLunchCalled == 0 ){
                            isLunchCalled = 1;
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Lunch(day: day, meal:1 )),
                          );
                          }
                          else
                          {
                            // show popup it cannot be opened
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text("Lunch Already Done"),
                                content: const Text("You have already marked your lunch"),
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
                          }}
                        else
                          {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text("Lunch Not Started"),
                                content: const Text("Lunch has not started yet. You can only fill it after 08:00"),
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
                          color: _textColor,
                          size: 50.0,

                        ),
                      ),

                      InkWell(
                        onTap: () {
                          // starting time of dinner is 8 PM
                          if(hour>=20){
                          if(isDinnerCalled == 0 ){
                            isDinnerCalled = 1;
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Dinner(day: day, meal:2 )),
                            );
                          }
                          else
                          {
                            // show notification that it cannot be opened
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text("Dinner Already Done"),
                                content: const Text("You have already marked your dinner"),
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


                          }}
                          else
                            {
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: const Text("Dinner Not Started"),
                                  content: const Text("Dinner has not started yet. You can only fill it after 08:00"),
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
                          color: _textColor,
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
