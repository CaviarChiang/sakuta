import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:io';

import 'package:sakuta/data/app_data.dart';
import 'package:sakuta/ui/pages/message_page.dart';
import 'package:sakuta/ui/widgets/chats_page/chat_item_widget.dart';
import 'package:sakuta/ui/widgets/layout_widget.dart';
import 'package:sakuta/utils/data_manager.dart';


class ChatsPage extends StatefulWidget {
  final AppData appData;
  ChatsPage({this.appData});

  _ChatsPageState createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  @override
  void initState() { 
    super.initState();
    DataManager dataManager = widget.appData.dataManager;
    String userId = widget.appData.userId;
    dataManager.loadChats(userId).then(loadChatsHandler);

    //ws://mrmyyesterday.com:5000
    WebSocket.connect(dataManager.relayServer).then((ws){
      setState(() {
        widget.appData.webSocket = ws;
        widget.appData.webSocketStream = ws.asBroadcastStream();
        ws.add(widget.appData.messageUtil.formatLogIn(userId));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutWidget(
      isLoading: isLoading(),
      child: ListView(
        //controller: widget.scrollController,
        children: List.from(widget.appData.chats),
      ),
    );
  }

  bool isLoading(){
    return widget.appData.chats.length == 0 || widget.appData.webSocket == null;
  }

  void loadChatsHandler(Response response){
    var list = json.decode(response.body);
    widget.appData.chats.clear();
    setState(() {
      for(int item in list['chatlist_userids']){
        widget.appData.messageCache[item.toString()] = List<Widget>();
        widget.appData.chats.add(ChatItemWidget(
          name: item.toString(), 
          callback: getTapHandler(item),
        ));
      }
    });
  }

  Function getTapHandler(int item){
    return () {
      widget.appData.targetId = item.toString();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MessagePage(
          appData: widget.appData,
        ),
      ));
    };
  }
}
