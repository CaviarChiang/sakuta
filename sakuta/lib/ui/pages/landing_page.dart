import 'package:flutter/material.dart';
import 'dart:io';

import '../pages/layouts/layout.dart';

import '../pages/chats_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutWidget(
      title: Text('There is no place like home'),
      child: Column(
        children: <Widget>[
          Container(
            child: RaisedButton(
              child: Text('sakuta'),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ChatsPage(
                    title: '1',)
                  ),
                );
              },
            ),
          ),
          Container(
            child: RaisedButton(
              child: Text('caviar'),
              onPressed: () => {},
            ),
          ),
          Container(
            child: RaisedButton(
              child: Text('the other guy'),
              onPressed: () => {},
            ),
          )
        ],
      ),
    );
  }
}