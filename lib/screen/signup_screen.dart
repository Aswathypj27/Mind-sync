import 'package:flutter/material.dart';
import 'planner_screen.dart';

class SignUpScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

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
                "🚀 Join StudySphere",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),

              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: "Email"),
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: "Password"),
              ),
              TextField(
                controller: confirmController,
                obscureText: true,
                decoration: InputDecoration(labelText: "Confirm Password"),
              ),

              SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  if (passwordController.text == confirmController.text) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PlannerScreen(
                          username: emailController.text.split("@")[0],
                        ),
                      ),
                    );
                  }
                },
                child: Text("Start the Madness"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
