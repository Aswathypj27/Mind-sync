import 'dart:math';
import 'package:flutter/material.dart';

class PlayDashboardScreen extends StatefulWidget {
  @override
  _PlayDashboardScreenState createState() => _PlayDashboardScreenState();
}

class _PlayDashboardScreenState extends State<PlayDashboardScreen> {
  String selectedGame = "Football";
  String matchResult = "";

  // 🎓 Dummy Student Data
  final List<Map<String, String>> dummyStudents = [
    {"name": "Arjun", "game": "Football", "level": "Beginner", "time": "5 PM"},
    {
      "name": "Meera",
      "game": "Cricket",
      "level": "Intermediate",
      "time": "6 PM",
    },
    {"name": "Rahul", "game": "Football", "level": "Advanced", "time": "7 PM"},
    {
      "name": "Ananya",
      "game": "Badminton",
      "level": "Intermediate",
      "time": "6 PM",
    },
    {"name": "Dev", "game": "Cricket", "level": "Beginner", "time": "5 PM"},
    {"name": "Sneha", "game": "Badminton", "level": "Advanced", "time": "7 PM"},
  ];

  void findMatch() {
    var matches = dummyStudents
        .where((student) => student["game"] == selectedGame)
        .toList();

    if (matches.isNotEmpty) {
      var randomStudent = matches[Random().nextInt(matches.length)];

      setState(() {
        matchResult =
            "🎉 Player Found!\n\n"
            "👤 Name: ${randomStudent["name"]}\n"
            "🎮 Game: ${randomStudent["game"]}\n"
            "⭐ Level: ${randomStudent["level"]}\n"
            "🕒 Available: ${randomStudent["time"]}\n\n"
            "Send match request? 🤝";
      });
    } else {
      setState(() {
        matchResult =
            "😢 No students found for $selectedGame.\nTry another game!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFAEDFF7), // Same as Study theme
      appBar: AppBar(
        title: Text("🎮 Play Dashboard"),
        backgroundColor: Color(0xFF87CEEB),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Your Game",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 15),

            DropdownButtonFormField<String>(
              value: selectedGame,
              items: ["Football", "Cricket", "Badminton"]
                  .map(
                    (game) => DropdownMenuItem(value: game, child: Text(game)),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedGame = value!;
                });
              },
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF87CEEB),
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: findMatch,
              child: Text("🔍 Find Player"),
            ),

            SizedBox(height: 30),

            if (matchResult.isNotEmpty)
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(matchResult, style: TextStyle(fontSize: 16)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
