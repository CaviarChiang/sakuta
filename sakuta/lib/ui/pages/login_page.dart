import 'package:flutter/material.dart';
import 'package:sakuta/data/app_data.dart';
import 'package:sakuta/data/app_state.dart';
import 'package:sakuta/ui/pages/chats_page.dart';
import 'package:sakuta/ui/widgets/layout_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppData appState = AppState.of(context).appData;
    return LayoutWidget(
      isLoading: false,
      child: Column(
        children: <Widget>[
          Container(
            child: RaisedButton(
              child: Text('sakuta'),
              onPressed: () {
                appState.userId = '1';
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatsPage(
                    appData: appState,
                  )),
                );
              },
            ),
          ),
          Container(
            child: RaisedButton(
              child: Text('caviar'),
              onPressed: () {
                appState.userId = '2';
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatsPage(
                    appData: appState,
                  )),
                );
              },
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