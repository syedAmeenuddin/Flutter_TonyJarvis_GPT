import 'package:flutter/material.dart';
import 'package:jarvisgpt/backend/Jarvis_engine.dart';
import '../backend/messageStream.dart';
import 'JarvisChannel.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final messageFeild = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final messageStreamProvider = Provider.of<SteamMessage>(context);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 59, 31, 31),
      appBar: AppBar(
        elevation: 0,
        title: Container(
          alignment: Alignment.center,
          child: Image.asset(
            'images/jarvis_logo.png',
            height: 30,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(126, 0, 0, 0),
      ),
      body: Column(
        children: [
          const Flexible(child: JarvisChannel()),
          Row(
            children: [
              Expanded(
                child: sendmessage(
                  TextContorller: messageFeild,
                  OnPress: () async {
                    String message = messageFeild.text;
                    if (message != '') {
                      setState(() {
                        messageStreamProvider.appendConvo(
                            'tony', messageFeild.text);
                        messageFeild.clear();
                      });
                      Map<String, dynamic> response =
                          await ApiService().getDataFromJarvis(message);

                      String reply = response['choices'][0]['text']
                          .toString()
                          .substring(2);
                      setState(() {
                        messageStreamProvider.appendConvo('jarvis', reply);
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class sendmessage extends StatelessWidget {
  sendmessage({Key? key, @required this.TextContorller, @required this.OnPress})
      : super(key: key);
  final TextContorller;
  final OnPress;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 17, bottom: 6, top: 6),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 6, 7, 24),
        borderRadius: BorderRadius.circular(40.0),
      ),
      child: TextFormField(
        controller: TextContorller,
        cursorColor: Color.fromARGB(255, 128, 0, 17),
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: OnPress,
            icon: Icon(Icons.send),
            color: Color.fromARGB(255, 128, 0, 17),
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          hintStyle: TextStyle(color: Colors.white),
          hintText: 'Message.....',
        ),
      ),
    );
  }
}
