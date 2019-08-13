import 'package:flutter/material.dart';

import 'package:sakuta/data/app_data.dart';
import 'package:sakuta/ui/widgets/message_page/chat_bubble_widget.dart';

class MessageInputWidget extends StatelessWidget{
  final AppData appData;
  final inputController = TextEditingController();
  final ScrollController scrollController;
  final Function onSend;

  MessageInputWidget({this.appData, this.onSend, this.scrollController});

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
    List<Widget> messages = this.appData.messageCache[this.appData.targetId];

    this.appData.webSocket.add(this.appData.messageUtil.formatMessage(this.inputController.text, this.appData.targetId));
    messages.insert(0, ChatBubbleWidget(
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

  void formatMessage(){
    
  }
}
