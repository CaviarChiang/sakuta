import 'package:flutter/material.dart';

class LayoutWidget extends StatefulWidget {
  final Widget child;
  final bool isLoading;
  LayoutWidget({this.child, this.isLoading = true});

  _LayoutWidgetState createState() => _LayoutWidgetState();
}

class _LayoutWidgetState extends State<LayoutWidget> {
  @override
  Widget build(BuildContext context) {
    if(widget.isLoading){
      return Text("Is Loading");
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Messenger"),
      ),
      body: Material(
       child: widget.child,
      )
    );
  }
}