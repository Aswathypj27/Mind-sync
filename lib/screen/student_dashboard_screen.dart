import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentDashboardScreen extends StatefulWidget {
  @override
  _StudentDashboardScreenState createState() => _StudentDashboardScreenState();
}

class _StudentDashboardScreenState extends State<StudentDashboardScreen> {
  String username = "";
  String roast = "";
  String personality = "";
  String buddyMessage = "";
  int xp = 0;
  int level = 1;

  List<String> schedule = [];

  Timer? timer;
  int seconds = 0;
  int totalStudySeconds = 0;
  bool isRunning = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  // ================= LOAD DATA =================
  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      username = prefs.getString("username") ?? "";
      roast = prefs.getString("roast") ?? "";
      personality = prefs.getString("personality") ?? "";
      buddyMessage = prefs.getString("buddyMessage") ?? "";
      xp = prefs.getInt("xp") ?? 0;
      level = prefs.getInt("level") ?? 1;
      schedule = prefs.getStringList("schedule") ?? [];
      totalStudySeconds = prefs.getInt("totalStudySeconds") ?? 0;
    });

    checkFutureLetter();
  }

  // ================= FUTURE LETTER POPUP =================
  Future<void> checkFutureLetter() async {
    final prefs = await SharedPreferences.getInstance();

    String? savedLetter = prefs.getString("letter");
    String? unlockDateString = prefs.getString("unlockDate");

    if (savedLetter != null && unlockDateString != null) {
      DateTime unlockDate = DateTime.parse(unlockDateString);

      if (DateTime.now().isAfter(unlockDate)) {
        Future.delayed(Duration(milliseconds: 500), () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: Text("💌 Future Letter Unlocked!"),
              content: Text(savedLetter),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Close"),
                ),
              ],
            ),
          );
        });

        await prefs.remove("letter");
        await prefs.remove("unlockDate");
      }
    }
  }

  // ================= TIMER =================
  void startTimer() {
    if (isRunning) return;

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        seconds++;
      });
    });

    setState(() {
      isRunning = true;
    });
  }

  void stopTimer() async {
    if (timer != null) timer!.cancel();

    totalStudySeconds += seconds;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("totalStudySeconds", totalStudySeconds);

    setState(() {
      seconds = 0;
      isRunning = false;
    });
  }

  String formatTime(int secs) {
    int hrs = secs ~/ 3600;
    int mins = (secs % 3600) ~/ 60;
    int sec = secs % 60;
    return "$hrs h $mins m $sec s";
  }

  // ================= STUDY LEVEL ANALYTICS =================
  String getStudyLevel() {
    int minutes = totalStudySeconds ~/ 60;

    if (minutes < 10) return "😴 Beginner Mode";
    if (minutes < 30) return "🚀 Focused Mode";
    if (minutes < 60) return "🔥 Deep Work Mode";
    return "👑 Study Beast Mode";
  }

  double getStudyPercent() {
    return (totalStudySeconds % 3600) / 3600;
  }

  String getEmojiStatus() {
    if (!isRunning) return "😴 Idle Mode";
    if (seconds < 600) return "🚀 Just Started!";
    if (seconds < 1800) return "🔥 In Focus Mode";
    if (seconds < 3600) return "🧠 Deep Focus";
    return "👑 Productivity Master";
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFAEDFF7),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              // MAIN WHITE CARD
              Container(
                padding: EdgeInsets.all(25),
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
                      "Welcome, $username 👋",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 10),

                    Text("🏆 Level $level Academic Warrior"),
                    Text("⭐ XP: $xp"),
                    SizedBox(height: 10),

                    Text("🎭 Personality: $personality"),
                    Text(roast),
                    Text("🤝 $buddyMessage"),

                    Divider(height: 30),

                    // TIMER
                    Center(
                      child: Column(
                        children: [
                          Text(
                            "Live Study Timer",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 10),

                          Text(
                            formatTime(seconds),
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 10),

                          Text(getEmojiStatus()),

                          SizedBox(height: 15),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF87CEEB),
                                  shape: StadiumBorder(),
                                ),
                                onPressed: startTimer,
                                child: Text("Start"),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey[400],
                                  shape: StadiumBorder(),
                                ),
                                onPressed: stopTimer,
                                child: Text("Stop"),
                              ),
                            ],
                          ),

                          SizedBox(height: 10),

                          Text(
                            "Total Study Time: ${formatTime(totalStudySeconds)}",
                          ),
                        ],
                      ),
                    ),

                    Divider(height: 30),

                    // ANALYTICS SECTION
                    Center(
                      child: Column(
                        children: [
                          Text(
                            "📊 Study Analytics",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 20),

                          SizedBox(
                            height: 140,
                            width: 140,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                CircularProgressIndicator(
                                  value: getStudyPercent(),
                                  strokeWidth: 12,
                                ),
                                Text(
                                  "${(getStudyPercent() * 100).toInt()}%",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 15),

                          Text(
                            getStudyLevel(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Divider(height: 30),

                    Text(
                      "📚 Study Schedule",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 10),

                    ...schedule.map(
                      (day) => ListTile(
                        leading: Icon(Icons.check_circle_outline),
                        title: Text(day),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
