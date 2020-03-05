import 'package:flutter/material.dart';

class DeviceCard extends StatelessWidget {
  DeviceCard({@required this.onTap, @required this.title, @required this.description});
  final GestureTapCallback onTap;
  final title;
  final description;

  @override
  Widget build(BuildContext context) {
    return Card(      
      color: Colors.blueGrey,
      child: InkWell(
        splashColor: Colors.black.withAlpha(30),
        onTap: onTap,
        child: Container(          
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Text(title, style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),
                Divider(color: Colors.black87),
                Text(description, style: TextStyle(color: Colors.white),),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Card(
                      color: Colors.green,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text('ON', style: TextStyle(color: Colors.white, fontSize: 12),),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}