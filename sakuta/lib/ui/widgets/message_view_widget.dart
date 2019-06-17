import 'package:flutter/material.dart';
import 'dart:io';

import 'chat_bubble_widget.dart';

class MessageViewWidget extends StatefulWidget{
  final Socket s;
  final List<Widget> messages;

  MessageViewWidget(this.s, this.messages);

  @override
  _MessageViewWidgetState createState() => _MessageViewWidgetState(this.s, this.messages, ScrollController());
}

class _MessageViewWidgetState extends State<MessageViewWidget>{
  Socket s;
  List<Widget> messages;
  ScrollController _scrollController;

  _MessageViewWidgetState(this.s, this.messages, this._scrollController);

  @override
  void initState(){
    super.initState();
    s.listen((data) {
      String message = new String.fromCharCodes(data).trim();
      setState(() {
        this.messages.insert(0, ChatBubbleWidget(message));
        scrollToBottom();
      });
    },
    onDone: () {
      s.destroy();
    });
  }

  @override
  Widget build(BuildContext context){
    return Expanded(
      child: ListView(
        reverse: true,
        controller: this._scrollController,
        children: List.from(this.messages),
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
