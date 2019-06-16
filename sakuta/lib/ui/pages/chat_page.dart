import 'package:flutter/material.dart';
import 'dart:io';
import '../widgets/chat_bubble_widget.dart';

class ChatPage extends StatefulWidget{
  var messages = List<ChatBubbleWidget>();
  _ChatPageState createState() => _ChatPageState(this.messages);
}


class _ChatPageState extends State<ChatPage>{
  Socket s;
  List<ChatBubbleWidget> messages;

  _ChatPageState(this.messages);

  @override
  void initState(){
    super.initState();
    print("THIS HAS RAN");
    Socket.connect('mrmyyesterday.com', 5000).then((socket){
      print("THIS HAS CONNECTED");
      this.s = socket;
      socket.listen((data) {
        print(new String.fromCharCodes(data).trim());
        this.messages.add(ChatBubbleWidget(String.fromCharCodes(data).trim()));
      },
      onDone: () {
        print("Done");
        socket.destroy();
      });
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Chatting with server?'),
      ),
      body: Material(
        child: ListView(
          reverse: true,
          children: this.messages
          ,
        ),
      ),
    );
  }}