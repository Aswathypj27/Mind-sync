import 'package:flutter/material.dart';
import 'mode_selection_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFAEDFF7),
      body: Center(
        child: Container(
          width: 360,
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
            mainAxisSize: MainAxisSize.min,
            children: [
              // TITLE
              Text(
                "Welcome to MindSync",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 5),

              Text(
                "Here you log in securely",
                style: TextStyle(color: Colors.grey[600]),
              ),

              SizedBox(height: 30),

              // EMAIL FIELD
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: UnderlineInputBorder(),
                ),
              ),

              SizedBox(height: 15),

              // PASSWORD FIELD WITH EYE ICON
              TextField(
                controller: passwordController,
                obscureText: obscurePassword,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: UnderlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscurePassword ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                  ),
                ),
              ),

              SizedBox(height: 30),

              // LOGIN BUTTON
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF87CEEB),
                  shape: StadiumBorder(),
                  minimumSize: Size(double.infinity, 50),
                ),
                onPressed: () {
                  String username = emailController.text.split("@")[0];

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ModeSelectionScreen(username: username),
                    ),
                  );
                },
                child: Text("Log In"),
              ),

              SizedBox(height: 15),

              // SIGNUP BUTTON
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => SignUpScreen()),
                  );
                },
                child: Text("Sign Up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
