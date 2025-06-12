import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MagicChessHomePage(),
    );
  }
}

class MagicChessHomePage extends StatefulWidget {
  @override
  _MagicChessHomePageState createState() => _MagicChessHomePageState();
}

class _MagicChessHomePageState extends State<MagicChessHomePage> {
  List<String> playerNames = List.generate(8, (index) => '');
  int currentRound = 1;

  List<List<String>> predictedOpponents = [];

  @override
  void initState() {
    super.initState();
    _updatePredictions();
  }

  void _updatePredictions() {
    List<List<String>> predictions = [];
    for (int round = currentRound; round <= 8; round++) {
      List<String> thisRound = [];
      for (int i = 0
