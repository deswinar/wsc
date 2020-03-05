import 'package:flutter/material.dart';
import 'package:wsc/widgets/title_text.dart';

class DeviceDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0, bottom: 50.0, right: 20.0, left: 20.0),
          child: Column(
            children: <Widget>[
              TitleText(text: "Device Details"),
              SizedBox(height: 10.0),
              
            ],
          ),
        ),
      )
    );
  }

}