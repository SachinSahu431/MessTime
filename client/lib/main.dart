import 'package:client/pages/details/MessCard.dart';
import 'package:client/pages/details/MessCardDeck.dart';
import 'package:flutter/material.dart';
import 'pages/details/MessCard.dart';
import 'pages/details/MessCardDeck.dart';

import 'pages/Data/NutritionX.dart';

void main() => runApp(ClientApp());

class ClientApp extends StatelessWidget {
  const ClientApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Client App',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(child: MessCardDeck()),
      ),
    );
  }
}
