import 'package:flutter/material.dart';
import 'dart:io';
import '../widgets/chat_bubble_widget.dart';

class ChatPage extends StatefulWidget{
  var messages = List<ChatBubbleWidget>();
  _ChatPageState createState() => _ChatPageState(this.messages, ScrollController());
}


class _ChatPageState extends State<ChatPage>{
  Socket s;
  String title = "message";
  List<Widget> messages;
  ScrollController _scrollController;
  _ChatPageState(this.messages, this._scrollController);

  @override
  void initState(){
    super.initState();
    Socket.connect('mrmyyesterday.com', 5000).then((socket){
      this.s = socket;
      socket.listen((data) {
        String message = new String.fromCharCodes(data).trim();
        //print(message);
        setState(() {
          this.messages.insert(0, ChatBubbleWidget(message));  
          scrollToBottom();
        });
      },
      onDone: () {
        socket.destroy();
      });
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: Material(
        child: ListView(
          reverse: true,
          controller: this._scrollController,
          children: List.from(this.messages),
        ),
      ),
    );
  }
  void scrollToBottom(){
    this._scrollController.animateTo(
      0.0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
  }
}
