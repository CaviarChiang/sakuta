import 'package:flutter/material.dart';
import 'package:sakuta/data/app_data.dart';

import 'chat_bubble_widget.dart';

class MessageViewWidget extends StatefulWidget{
  final AppData appData;
  final ScrollController scrollController;

  MessageViewWidget({this.appData, this.scrollController});

  @override
  _MessageViewWidgetState createState() => _MessageViewWidgetState();
}

class _MessageViewWidgetState extends State<MessageViewWidget>{
  _MessageViewWidgetState();

  @override
  void initState(){
    super.initState();
    List<Widget> messages = widget.appData.messageCache[widget.appData.targetId];
    widget.appData.webSocketStream.listen((data){
      setState(() {
        messages.insert(0, ChatBubbleWidget(data));
        scrollToBottom();
      });
    });
  }

  @override
  Widget build(BuildContext context){
    List<Widget> messages = widget.appData.messageCache[widget.appData.targetId];
    return Expanded(
      child: ListView(
        reverse: true,
        controller: widget.scrollController,
        children: List.from(messages),
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
