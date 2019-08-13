import 'package:flutter/material.dart';
import 'package:sakuta/data/app_data.dart';

class AppState extends InheritedWidget {
  final AppData appData = AppData();

  AppState({Key key, this.child}) : super(key: key, child: child);

  final Widget child;
  static AppState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(AppState)as AppState);
  }

  @override
  bool updateShouldNotify( AppState oldWidget) {
    return true;
  }
}