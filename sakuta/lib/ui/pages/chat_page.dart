import 'package:flutter/material.dart';
import 'dart:io';

import '../widgets/chat_page/chat_bubble_widget.dart';
import '../widgets/chat_page/message_input_widget.dart';
import '../widgets/chat_page/message_view_widget.dart';

class ChatPage extends StatefulWidget{
  final List<Widget> messages = List<ChatBubbleWidget>();
  final scrollController = ScrollController();

  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>{
  Socket s;
  String title = "message";

  @override
  void initState(){
    super.initState();
    Socket.connect('mrmyyesterday.com', 5001).then((socket){
      setState(() {
        this.s = socket;
      });
    });
  }

  @override
  Widget build(BuildContext context){
    if(this.s == null){
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
              MessageViewWidget(this.s, widget.messages, widget.scrollController),
              MessageInputWidget(this.s, widget.messages, refresh, widget.scrollController),
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
