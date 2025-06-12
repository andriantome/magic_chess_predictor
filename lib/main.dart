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
      for (int i = 0; i < 4; i++) {
        int player1 = (round + i) % 8;
        int player2 = (round + 7 - i) % 8;
        thisRound.add("${playerNames[player1]} vs ${playerNames[player2]}");
      }
      predictions.add(thisRound);
    }
    setState(() {
      predictedOpponents = predictions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Magic Chess Predictor'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Enter Player Names:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            for (int i = 0; i < playerNames.length; i++)
              TextField(
                decoration: InputDecoration(labelText: 'Player ${i + 1}'),
                onChanged: (value) {
                  setState(() {
                    playerNames[i] = value;
                    _updatePredictions();
                  });
                },
              ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Current Round: $currentRound'),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: currentRound > 1
                          ? () {
                              setState(() {
                                currentRound--;
                                _updatePredictions();
                              });
                            }
                          : null,
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: currentRound < 8
                          ? () {
                              setState(() {
                                currentRound++;
                                _updatePredictions();
                              });
                            }
                          : null,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Predicted Opponents:',
              style: TextStyle(fontWeight: FontWeight.bold),
