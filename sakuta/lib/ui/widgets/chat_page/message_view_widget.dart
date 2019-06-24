import 'package:flutter/material.dart';
import 'dart:io';

import 'chat_bubble_widget.dart';

class MessageViewWidget extends StatefulWidget{
  final WebSocket webSocket;
  final List<Widget> messages;
  final scrollController;

  MessageViewWidget(this.webSocket, this.messages, this.scrollController);

  @override
  _MessageViewWidgetState createState() => _MessageViewWidgetState();
}

class _MessageViewWidgetState extends State<MessageViewWidget>{
  _MessageViewWidgetState();

  @override
  void initState(){
    super.initState();
    widget.webSocket.listen((data){
      setState(() {
        widget.messages.insert(0, ChatBubbleWidget(data));
        scrollToBottom();
      });
    });
  }

  @override
  Widget build(BuildContext context){
    return Expanded(
      child: ListView(
        reverse: true,
        controller: widget.scrollController,
        children: List.from(widget.messages),
      ),
    );
  }

  void scrollToBottom(){
    widget.scrollController.animateTo(
      0.0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
  }
}
