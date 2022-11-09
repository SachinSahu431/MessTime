import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return Card(
        elevation: 1.0,
        color: _color,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
        child: Container(
            height: 200,
            width: 500,
            padding:
                const EdgeInsets.only(left: 10.0, right: 16.0, bottom: 22.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 16.0, left: 10.0, right: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.restaurant,
                        color: _textColor,
                        size: 30.0,
                      ),
                      Icon(
                        Icons.credit_card_rounded,
                        color: _textColor,
                        size: 30.0,
                      ),
                    ],
                  ),
                ),
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
                )
              ],
            )));
  }
}
