import 'package:flutter/material.dart';
import 'planner_screen.dart';
import 'play_dashboard_screen.dart';

class ModeSelectionScreen extends StatelessWidget {
  final String username;

  ModeSelectionScreen({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFAEDFF7),
      body: Center(
        child: Container(
          width: 350,
          padding: EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Welcome $username 👋",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 10),

              Text("Choose Your Mode"),

              SizedBox(height: 30),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF87CEEB),
                  shape: StadiumBorder(),
                  minimumSize: Size(double.infinity, 50),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PlannerScreen(username: username),
                    ),
                  );
                },
                child: Text("🎓 Study Mode"),
              ),

              SizedBox(height: 15),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 108, 139, 158),
                  shape: StadiumBorder(),
                  minimumSize: Size(double.infinity, 50),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => PlayDashboardScreen()),
                  );
                },
                child: Text("🎮 Play Mode"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
