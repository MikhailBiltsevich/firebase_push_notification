import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessaging.instance.requestPermission();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Token(),
          ),
        ),
      ),
    );
  }
}

class Token extends StatefulWidget {
  const Token({super.key});

  @override
  State<Token> createState() => _TokenState();
}

class _TokenState extends State<Token> {
  String token = '';

  @override
  void initState() {
    super.initState();

    FirebaseMessaging.instance.getToken().then((value) {
      token = value ?? 'Unable to get token';
      setState(() {});
      print(token);
    });

    FirebaseMessaging.instance.onTokenRefresh.listen((receivedToken) {
      token = receivedToken;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(token);
  }
}
