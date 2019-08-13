import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:io';

import 'package:sakuta/data/app_data.dart';
import 'package:sakuta/ui/widgets/message_page/chat_bubble_widget.dart';
import 'package:sakuta/ui/widgets/layout_widget.dart';
import 'package:sakuta/ui/widgets/message_page/message_input_widget.dart';
import 'package:sakuta/ui/widgets/message_page/message_view_widget.dart';


class MessagePage extends StatefulWidget{
  final AppData appData;
  final scrollController = ScrollController();
  MessagePage({this.appData});

  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage>{
  @override
  void initState(){
    super.initState();
    List<Widget> messages = widget.appData.messageCache[widget.appData.targetId];

    if(messages.isEmpty){
      widget.appData.dataManager.loadHistory(widget.appData.userId, widget.appData.targetId).then(handleLoadHistory);
    }
  }

  @override
  Widget build(BuildContext context){
    return LayoutWidget(
      isLoading: this.isLoading(),
      child: Column(
        children: <Widget>[
          MessageViewWidget(
            appData: widget.appData,
            scrollController: widget.scrollController,
          ),
          MessageInputWidget(
            appData: widget.appData,
            onSend: refresh,
            scrollController: widget.scrollController
          )
        ],
      ),
    );
  }

  void refresh(){
    setState(() {});
  }

  bool isLoading(){
    if(widget.appData.webSocket == null || widget.appData.webSocket.readyState != WebSocket.open){
      return true;
    }else{
      return false;
    }
  }

  void handleLoadHistory(Response response){
    var list = json.decode(response.body);
    List<Widget> messages = widget.appData.messageCache[widget.appData.targetId];
    setState(() {
      for(Map item in list){
        var data = item['fields'];
        messages.insert(0, ChatBubbleWidget(
            data['msg_content'],
            left: data['sender'].toString() == widget.appData.targetId,
        ));
      }
    });
  }
}
