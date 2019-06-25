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
  WebSocket webSocket;
  String title = "message";

  @override
  void initState(){
    super.initState();
    WebSocket.connect('ws://mrmyyesterday.com:5000').then((ws){
      setState(() {
        this.webSocket = ws;        
      });
    });
  }

  @override
  Widget build(BuildContext context){
    if(this.isLoading()){
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
              MessageViewWidget(this.webSocket, widget.messages, widget.scrollController),
              MessageInputWidget(this.webSocket, widget.messages, refresh, widget.scrollController),
            ],
          ),
        ),
      );
    }
  }

  void refresh(){
    setState(() {});
  }

  bool isLoading(){
    if(this.webSocket == null || this.webSocket.readyState != WebSocket.open){
      return true;
    }else{
      return false;
    }
  }
}
