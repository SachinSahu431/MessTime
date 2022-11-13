import 'package:client/pages/details/MessCard.dart';
import 'package:client/pages/details/MessCardDeck.dart';
import 'package:flutter/material.dart';
import 'pages/details/MessCard.dart';
import 'pages/details/MessCardDeck.dart';
import 'pages/Data/Nutrients.dart';

import 'pages/Data/NutritionX.dart';
import 'pages/DisplayMenu.dart';

void main() => runApp(MyHomePage(title: "Mess Time"));

class ClientApp extends StatelessWidget {
  const ClientApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //should contain title Mess time,display messCardDeck and a button to display the menu routing to displaymenu

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mess Time',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Mess Time'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const MessCardDeck(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DisplayMenu()),
                );
              },
              child: const Text('Display Menu'),
            ),
          ],
        ),
      ),
    );
  }
}
