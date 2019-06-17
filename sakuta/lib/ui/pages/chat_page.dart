import 'package:flutter/material.dart';
import 'dart:io';

import '../widgets/chat_bubble_widget.dart';
import '../widgets/message_input_widget.dart';
import '../widgets/message_view_widget.dart';

class ChatPage extends StatefulWidget{
  final List<Widget> messages = List<ChatBubbleWidget>();
  _ChatPageState createState() => _ChatPageState(this.messages);
}

class _ChatPageState extends State<ChatPage>{
  Socket s;
  List<Widget> messages;
  String title = "message";

  _ChatPageState(this.messages);

  @override
  void initState(){
    super.initState();
    Socket.connect('mrmyyesterday.com', 5000).then((socket){
      setState(() {
        this.s = socket;
      });
    });
  }

  @override
  Widget build(BuildContext context){
    if(s == null){
      return Scaffold(
        appBar: AppBar(
          title: Text("LOADING"),
        ),
      );
    }else{
      return Scaffold(
        appBar: AppBar(
          title: Text(this.title),
        ),
        body: Material(
          child: Column(
            children: <Widget>[
              MessageViewWidget(s, this.messages),
              MessageInputWidget(s, this.messages, refresh),
            ],
          ),
        ),
      );
    }
  }

  void refresh(){
    setState(() {});
  }
}
