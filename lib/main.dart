import 'package:flutter/material.dart';
import 'package:log/src/dashboard.dart';
import 'package:log/src/validation.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Log in page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: login(),
    );
  }
}

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String errorMsg = " ";

  void _login(BuildContext context) async {
    String eml = email.text;
    String pwd = password.text;
    String? ml;
    String? pw;
    if (eml != "" || pwd != "") {
      ml = Validation().isLogin(eml);
      pw = Validation().isPassword(pwd);
    }

    if (ml == 'Invalid Mail Id  contain all type of chars' ||
        pw == 'password should contain digits') {
      setState(() {
        errorMsg =
            'Invalid Mail Id  contain all type of chars or password should contain digits';
      });
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', ml!);
      await prefs.setString('password', pw!);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: const Text(" Login page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: email,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: password,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            Text(
              errorMsg,
              style: const TextStyle(color: Colors.red),
            ),
            ElevatedButton(
              onPressed: () => _login(context),
              child: const Text("Log in"),
            ),
          ],
        ),
      ),
    );
  }
}
