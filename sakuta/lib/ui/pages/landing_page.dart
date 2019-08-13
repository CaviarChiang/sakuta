import 'package:flutter/material.dart';
import 'package:sakuta/ui/widgets/layout_widget.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutWidget(
      child: Text("Layout page"),
      isLoading: false,
    );
  }
}
