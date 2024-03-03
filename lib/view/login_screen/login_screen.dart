import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharepref_sample/view/home_page/home_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController c1 = TextEditingController();
  TextEditingController c2 = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Check if the user has already logged in
    checkAutoLogin();
  }

  void checkAutoLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? savedUsername = preferences.getString("username");
    String? savedPswd = preferences.getString("pswd");

    if (savedUsername != null && savedPswd != null) {
      // Auto login if credentials are saved
      c1.text = savedUsername;
      c2.text = savedPswd;
      autoLogin();
    }
  }

  void autoLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? savedUsername = preferences.getString("username");
    String? savedPswd = preferences.getString("pswd");

    if (c1.text == savedUsername && c2.text == savedPswd) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green, content: Text("Auto login success")));
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ... (rest of your UI remains unchanged)
              ElevatedButton(
                  onPressed: () async {
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();
                    String? savedUsername = preferences.getString("username");
                    String? savedPswd = preferences.getString("pswd");

                    if (c1.text == savedUsername && c2.text == savedPswd) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.green,
                          content: Text("Login success")));
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                          (route) => false);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          content: Text("Login failed")));
                    }
                  },
                  child: Text("Login")),
            ],
          ),
        ),
      ),
    );
  }
}
