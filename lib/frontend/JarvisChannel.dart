import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../backend/messageStream.dart';

class JarvisChannel extends StatefulWidget {
  const JarvisChannel({Key? key}) : super(key: key);

  @override
  State<JarvisChannel> createState() => _JarvisChannelState();
}

class _JarvisChannelState extends State<JarvisChannel> {
  Timer? _timer;
  final _controller = ScrollController();
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        _controller.animateTo(0,
            duration: Duration(seconds: 120), curve: Curves.fastOutSlowIn);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final messageStreamProvider = Provider.of<SteamMessage>(context);
    Map chattu = messageStreamProvider.conversation;
    List<Map<String, String>> originalChattu = chattu['children'];
    List<Map<String, String>> reversedChattu = originalChattu.reversed.toList();
    return ListView.builder(
      reverse: true,
      controller: _controller,
      itemCount: reversedChattu.length,
      itemBuilder: (context, index) {
        return reversedChattu[index]['author'] == 'jarvis'
            ? JarvisReply(
                message: reversedChattu[index]['info'].toString(),
              )
            : Tonymessage(
                message: reversedChattu[index]['info'].toString(),
              );
      },
    );
  }
}

class JarvisReply extends StatelessWidget {
  const JarvisReply({Key? key, required this.message}) : super(key: key);
  final String message;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(
          'images/jarvis_logo.png',
          height: 30,
        ),
        Flexible(
          flex: 1,
          child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(left: 6, right: 70, top: 10, bottom: 10),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 128, 0, 17),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(4),
                  bottomRight: Radius.circular(4),
                  topLeft: Radius.circular(10),
                )),
            child: Text(
              message,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

class Tonymessage extends StatelessWidget {
  const Tonymessage({Key? key, required this.message}) : super(key: key);
  final String message;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          flex: 1,
          child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(left: 70, right: 6, top: 10, bottom: 10),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 19, 19, 19),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(4),
                  topLeft: Radius.circular(4),
                )),
            child: Text(
              message,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        Image.asset(
          'images/tony_logo.png',
          height: 30,
        ),
      ],
    );
  }
}
