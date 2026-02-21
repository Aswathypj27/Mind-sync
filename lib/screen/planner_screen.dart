import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'student_dashboard_screen.dart';

class PlannerScreen extends StatefulWidget {
  final String username;
  PlannerScreen({required this.username});

  @override
  _PlannerScreenState createState() => _PlannerScreenState();
}

class _PlannerScreenState extends State<PlannerScreen> {
  final subjectsController = TextEditingController();
  final daysController = TextEditingController();
  final hoursController = TextEditingController();
  final sleepController = TextEditingController();
  final letterController = TextEditingController();
  final subjectNameController = TextEditingController();
  final studyTimeController = TextEditingController();

  String selectedLevel = "Beginner";
  DateTime? selectedDate;

  void generateDashboard() async {
    int subjects = int.tryParse(subjectsController.text) ?? 1;
    int days = int.tryParse(daysController.text) ?? 1;
    int hours = int.tryParse(hoursController.text) ?? 2;
    int sleep = int.tryParse(sleepController.text) ?? 6;
    int preferredTime = int.tryParse(studyTimeController.text) ?? 0;

    int xp = subjects * 50;
    int level = (xp ~/ 100) + 1;

    List<String> personalities = [
      "🧠 Supreme Overthinker",
      "🦸 Academic Avenger",
      "🐢 Chill Turtle",
      "🔥 Study Warrior",
    ];

    String personality = personalities[Random().nextInt(personalities.length)];

    List<String> schedule = [];
    for (int i = 1; i <= days; i++) {
      schedule.add(
        "📘 Day $i: Conquer Subject ${(i % subjects) + 1} for $hours hrs 💪",
      );
    }

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("username", widget.username);
    await prefs.setString("letter", letterController.text);
    await prefs.setInt("xp", xp);
    await prefs.setInt("level", level);
    await prefs.setString("personality", personality);
    await prefs.setStringList("schedule", schedule);

    if (selectedDate != null) {
      await prefs.setString("unlockDate", selectedDate!.toIso8601String());
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => StudentDashboardScreen()),
    );
  }

  InputDecoration inputStyle(String label) {
    return InputDecoration(labelText: label, border: UnderlineInputBorder());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFAEDFF7),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: 380,
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 15,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome, ${widget.username} 👋",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 25),

                  TextField(
                    controller: subjectsController,
                    decoration: inputStyle("Number of Subjects"),
                    keyboardType: TextInputType.number,
                  ),

                  TextField(
                    controller: daysController,
                    decoration: inputStyle("Days Until Exam"),
                    keyboardType: TextInputType.number,
                  ),

                  TextField(
                    controller: hoursController,
                    decoration: inputStyle("Study Hours per Day"),
                    keyboardType: TextInputType.number,
                  ),

                  TextField(
                    controller: sleepController,
                    decoration: inputStyle("Sleep Hours"),
                    keyboardType: TextInputType.number,
                  ),

                  SizedBox(height: 20),

                  TextField(
                    controller: subjectNameController,
                    decoration: inputStyle("Study Circle Subject"),
                  ),

                  TextField(
                    controller: studyTimeController,
                    decoration: inputStyle("Preferred Study Time"),
                    keyboardType: TextInputType.number,
                  ),

                  DropdownButtonFormField<String>(
                    value: selectedLevel,
                    items: ["Beginner", "Intermediate", "Advanced"]
                        .map(
                          (level) => DropdownMenuItem(
                            value: level,
                            child: Text(level),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedLevel = value!;
                      });
                    },
                    decoration: inputStyle("Skill Level"),
                  ),

                  SizedBox(height: 20),

                  TextField(
                    controller: letterController,
                    maxLines: 3,
                    decoration: inputStyle("Future Letter"),
                  ),

                  SizedBox(height: 15),

                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[200],
                        shape: StadiumBorder(),
                      ),
                      onPressed: () async {
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null) {
                          setState(() {
                            selectedDate = picked;
                          });
                        }
                      },
                      child: Text(
                        "Select Unlock Date",
                        style: TextStyle(color: Colors.black87),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF87CEEB),
                        shape: StadiumBorder(),
                        minimumSize: Size(double.infinity, 50),
                      ),
                      onPressed: generateDashboard,
                      child: Text("🎮 Generate Chaos Dashboard"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
