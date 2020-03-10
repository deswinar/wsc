import 'package:flutter/material.dart';

class DeviceCard extends StatelessWidget {
  DeviceCard({@required this.onTap, @required this.title, @required this.description, @required this.status});
  final GestureTapCallback onTap;
  final title;
  final description;
  final status;

  @override
  Widget build(BuildContext context) {
    return Card(      
      color: Colors.blue,
      child: InkWell(
        splashColor: Colors.blueAccent,
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
                      color: status == true ? Colors.green : Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(status == true ? "On" : "Off", style: TextStyle(color: Colors.white, fontSize: 12),),
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