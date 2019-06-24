import 'package:flutter/material.dart';
import 'dart:io';

import 'chat_bubble_widget.dart';

class MessageInputWidget extends StatelessWidget{
  final inputController = TextEditingController();
  final scrollController;
  final List<Widget> messages;
  final WebSocket webSocket;
  final Function onSend;

  MessageInputWidget(this.webSocket, this.messages, this.onSend, this.scrollController);

  @override
  Widget build(BuildContext context){
    return Row(
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                left: 10
              ),
              padding: EdgeInsets.fromLTRB(7, 5, 5, 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  width: 1
                )
              ),
              alignment: Alignment.center,
              child: TextField(
                style: TextStyle(
                  fontSize: 20,
                  height: 1
                ),
                controller: inputController,
                decoration: InputDecoration.collapsed(
                  hintText: "write something ...",
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: sendMessage,
            icon: Icon(Icons.send),
          ),
        ],
    );
  }

  void sendMessage(){
    this.webSocket.add(this.inputController.text);
    this.messages.insert(0, ChatBubbleWidget(
      this.inputController.text,
      left: false,
    ));
    this.inputController.clear();
    this.onSend();
    this.scrollController.animateTo(
      0.0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
  }
}
