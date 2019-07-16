import 'package:flutter/material.dart';

class LayoutWidget extends StatelessWidget {
  final Widget title;
  final Widget child;
  final bool isLoading;

  const LayoutWidget({Key key, 
    this.child,
    this.title, 
    this.isLoading = false, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(isLoading){
      return Scaffold(
        appBar: AppBar(
          title: Text('loading'),
        ),
      );
    }else{
      return Scaffold(
        appBar: AppBar(
          title: this.title
        ),
        body: Material(
          child: this.child,
        ),
      );
    }
  }
}