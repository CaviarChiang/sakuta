import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart';
import 'package:sakuta/utils/data_manager.dart' as prefix0;

import 'layouts/layout.dart';
import '../../utils/data_manager.dart';
import '../pages/chat_page.dart';
import '../widgets/chats_page/chat_item_widget.dart';

class ChatsPage extends StatefulWidget {
  final String title;
  final chats = List<ChatItemWidget>();
  final messageCache = Map<String, List<Widget>>();

  ChatsPage({this.title = "Default chats page"}){
    DataManager.userId = title;
  }

  _ChatsPageState createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  WebSocket webSocket;
  Stream webSocketStream;
  @override
  void initState() { 
    super.initState();

    DataManager.loadChats(widget.title).then(loadChatsHandler);

    WebSocket.connect('ws://mrmyyesterday.com:5000').then((ws){
      setState(() {
        this.webSocket = ws;    
        this.webSocketStream = ws.asBroadcastStream();    
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutWidget(
      title: Text(widget.title),
      isLoading: isLoading(),
      child: ListView(
        //controller: widget.scrollController,
        children: List.from(widget.chats),
      ),
    );
  }

  bool isLoading(){
    return widget.chats.length == 0 || webSocket == null;
  }

  void loadChatsHandler(Response response){
    var list = json.decode(response.body);
    setState(() {
      for(int item in list['chatlist_userids']){
        widget.messageCache[item.toString()] = List<Widget>();
        widget.chats.add(ChatItemWidget(
          name: item.toString(), 
          callback: getTapHandler(item),
        ));
      }
    });
  }

  Function getTapHandler(int item){
    return () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChatPage(
          title: item.toString(), 
          messages: widget.messageCache[item.toString()], 
          webSocket: this.webSocket,
          webSocketStream: this.webSocketStream)
        ),
      );
    };
  }
}
