import 'package:flutter/material.dart';
import 'dart:io';
import 'package:sakuta/ui/widgets/chats_page/chat_item_widget.dart';
import 'package:sakuta/utils/data_manager.dart';
import 'package:sakuta/utils/message_util.dart';

class AppData{
  String hello = 'hello';
  String userId;
  String targetId;

  WebSocket webSocket;
  Stream webSocketStream;
  final DataManager dataManager = new DataManager();
  final MessageUtil messageUtil = new MessageUtil();

  var chats = List<ChatItemWidget>();
  var messageCache = Map<String, List<Widget>>();
}