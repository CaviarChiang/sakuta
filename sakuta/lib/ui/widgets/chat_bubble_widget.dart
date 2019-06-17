import 'package:flutter/material.dart';

class ChatBubbleWidget extends StatelessWidget{
  bool left;
  String message;
  ChatBubbleWidget(this.message, {
    this.left:true, 
  });

  Widget build(BuildContext context){
    return Container(
      alignment: this.left ? Alignment.centerLeft : Alignment.centerRight,
      //height: 100,
      child: Container(
        margin: EdgeInsets.only(
          left: 10,
          right: 10,
          bottom: 5
        ),
        padding: EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: this.left ? Colors.blue[200] : Colors.red[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          this.message,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}