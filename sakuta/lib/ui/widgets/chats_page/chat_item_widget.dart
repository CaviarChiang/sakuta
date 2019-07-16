import 'dart:io';

import 'package:flutter/material.dart';

import '../../pages/chat_page.dart';

class ChatItemWidget extends StatefulWidget {
  final String name;
  final Function callback;
  ChatItemWidget({Key key, this.name = "Default Name", this.callback}) : super(key: key);

  _ChatItemWidgetState createState() => _ChatItemWidgetState();
}

class _ChatItemWidgetState extends State<ChatItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        title: Text(widget.name),
        onTap: widget.callback,
      ),
    );
  }
}