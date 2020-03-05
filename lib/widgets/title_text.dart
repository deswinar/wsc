import 'package:flutter/material.dart';

class TitleText extends StatefulWidget {
  final Widget child;
  var text;
  var fontSize;
  TitleText({Key key, this.child, this.text, this.fontSize}) : super(key: key);

  TitleTextState createState() {
    TitleTextState();
  }

}

class TitleTextState extends State<TitleText> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        widget.text, 
        style: TextStyle(fontSize: widget.fontSize ?? 24)
      )
    );
  }
  
}