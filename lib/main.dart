import 'package:flutter/material.dart';
import 'package:jarvisgpt/frontend/ChatPage.dart';
import 'package:provider/provider.dart';
import 'backend/messageStream.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (_) => SteamMessage(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Color.fromARGB(255, 28, 78, 72),
      home: FutureBuilder(
          future: _initialization,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print('error$snapshot');
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return ChatPage();
            }
            return Scaffold(
              backgroundColor: Colors.black12,
              body: Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 128, 0, 17),
                ),
              ),
            );
          }),
    );
  }
}
