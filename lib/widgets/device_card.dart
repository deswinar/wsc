import 'package:flutter/material.dart';

class DeviceCard extends StatelessWidget {
  DeviceCard({
    @required this.onTap,
    @required this.title,
    @required this.description,
    @required this.triggerTime,
    @required this.triggerTo,
    @required this.status
  });
  
  final GestureTapCallback onTap;
  final title;
  final description;
  final triggerTime;
  final triggerTo;
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Card(
                      color: triggerTo == true ? Colors.green : Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(triggerTo == true ? "On" : "Off", style: TextStyle(color: Colors.white, fontSize: 12),),
                      ),
                    ),
                    Text('after'),
                  ],
                ),
                Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(triggerTime, style: TextStyle(color: Colors.black, fontSize: 10),),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text("Current :"),
                        Card(
                          color: status == true ? Colors.green : Colors.red,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(status == true ? "On" : "Off", style: TextStyle(color: Colors.white, fontSize: 12),),
                          ),
                        ),
                      ],
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