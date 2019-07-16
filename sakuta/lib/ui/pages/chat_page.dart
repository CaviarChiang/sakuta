import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:io';

import 'layouts/layout.dart';
import '../../utils/data_manager.dart';
import '../widgets/chat_page/message_input_widget.dart';
import '../widgets/chat_page/message_view_widget.dart';
import '../widgets/chat_page/chat_bubble_widget.dart';

class ChatPage extends StatefulWidget{
  final String title;
  final List<Widget> messages;
  final WebSocket webSocket;
  final Stream webSocketStream;

  final scrollController = ScrollController();

  ChatPage({this.title = "Default chat page", this.messages, this.webSocket, this.webSocketStream});

  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>{
  @override
  void initState(){
    super.initState();
    if(widget.messages.isEmpty){
      DataManager.loadHistory(widget.title).then(handleLoadHistory);
    }
  }

  @override
  Widget build(BuildContext context){
    return LayoutWidget(
      isLoading: this.isLoading(),
      title: Text(widget.title),
      child: Column(
        children: <Widget>[
          MessageViewWidget(widget.webSocketStream, widget.messages, widget.scrollController),
          MessageInputWidget(widget.webSocket, widget.messages, refresh, widget.scrollController),
        ],
      ),
    );
  }

  void refresh(){
    setState(() {});
  }

  bool isLoading(){
    if(widget.webSocket == null || widget.webSocket.readyState != WebSocket.open){
      return true;
    }else{
      return false;
    }
  }

  void handleLoadHistory(Response response){
    var list = json.decode(response.body);
    setState(() {
      for(Map item in list){
        var data = item['fields'];
        widget.messages.insert(0, ChatBubbleWidget(
            data['msg_content'],
            left: data['sender'].toString() == widget.title,
        ));
      }
    });
  }
}
