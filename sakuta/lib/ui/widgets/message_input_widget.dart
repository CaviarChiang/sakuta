import 'package:flutter/material.dart';
import 'dart:io';

class MessageInputWidget extends StatelessWidget{
  final inputController = TextEditingController();
  final Socket s;
  MessageInputWidget(this.s);

  @override 
  Widget build(BuildContext context){
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            child: TextField(
                controller: inputController,
                decoration: InputDecoration(
                  helperText: "write something ..."
                ),
            ),
          ),
          IconButton(
            onPressed: sendMessage,
            icon: Icon(Icons.send),
          ),
        ],
      ),
    );
  }
  void sendMessage(){
    s.write(this.inputController.text);
    this.inputController.clear();
  }
}
