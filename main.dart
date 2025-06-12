
import 'package:flutter/material.dart';

void main() {
  runApp(MagicChessPredictor());
}

class MagicChessPredictor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magic Chess Opponent Predictor',
      home: PredictorHomePage(),
    );
  }
}

class PredictorHomePage extends StatefulWidget {
  @override
  _PredictorHomePageState createState() => _PredictorHomePageState();
}

class _PredictorHomePageState extends State<PredictorHomePage> {
  List<String> playerNames = List.generate(8, (index) => '');
  List<String> pastOpponents = [];
  String? predictedOpponent;

  void predictNextOpponent() {
    final recent = pastOpponents.take(3).toList();
    final available = playerNames.where((p) => !recent.contains(p) && p.isNotEmpty).toList();
    if (available.isEmpty) {
      predictedOpponent = 'Any player (all recently played)';
    } else {
      available.shuffle();
      predictedOpponent = available.first;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Opponent Predictor')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Enter Player Names:', style: TextStyle(fontWeight: FontWeight.bold)),
            ...List.generate(8, (index) {
              return TextField(
                decoration: InputDecoration(labelText: 'Player ${index + 1}'),
                onChanged: (value) => playerNames[index] = value,
              );
            }),
            SizedBox(height: 20),
            Text('Select Opponent You Just Fought:'),
            Wrap(
              spacing: 8,
              children: playerNames
                  .where((name) => name.isNotEmpty)
                  .map((name) => ElevatedButton(
                        onPressed: () {
                          setState(() {
                            pastOpponents.insert(0, name);
                            if (pastOpponents.length > 10) {
                              pastOpponents = pastOpponents.sublist(0, 10);
                            }
                            predictNextOpponent();
                          });
                        },
                        child: Text(name),
                      ))
                  .toList(),
            ),
            SizedBox(height: 20),
            if (predictedOpponent != null)
              Text('🔮 Next Likely Opponent: $predictedOpponent',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
