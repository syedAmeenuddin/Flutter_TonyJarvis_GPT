import 'package:flutter/material.dart';

class SteamMessage with ChangeNotifier {
  Map _conversation = {
    'children': [
      {'author': 'jarvis', 'info': 'Welcome, How may i help you?'},
    ],
  };
  bool? _replied;
  Map get conversation => _conversation;
  bool? get replied => _replied;
  void appendConvo(String author, String info) {
    _conversation['children'].add({
      'author': author,
      'info': info,
    });
    notifyListeners();
  }

  void addReplied(bool rpy) {
    _replied = true;
    notifyListeners();
  }

  void sentmessage(bool snt) {
    _replied = false;
    notifyListeners();
  }
}
