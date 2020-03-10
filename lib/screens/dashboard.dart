import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wsc/arguments/device_details_args.dart';
import 'package:wsc/models/device.dart';
import 'package:wsc/networks/database_service.dart';
import 'package:wsc/screens/device_details.dart';
import 'package:wsc/widgets/device_card.dart';

class DashboardScreen extends StatelessWidget {
  static const routeName = '/dashboard';

  @override
  Widget build(BuildContext context) {
    final deviceTitle = [];
    final deviceDescription = [];

    final db = DatabaseService();
    
    return Scaffold(
      body: Container(
        color: Colors.black12,
        padding: EdgeInsets.all(16.0),
        child: StreamBuilder(
          stream: db.getDevices(),
          builder: (context, snapshot) {
            if(!snapshot.hasData) return const Text("Loading...");
            return GridView.builder(
              itemCount: snapshot.data.documents.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
              itemBuilder: (BuildContext context, int index) {                
                DocumentSnapshot dataDocuments = snapshot.data.documents[index];
                print(dataDocuments['status']);
                return DeviceCard(
                  title: dataDocuments['title'],
                  description: dataDocuments['description'],
                  status: dataDocuments['status'],
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      DeviceDetailsScreen.routeName,
                      arguments: DeviceDetailsScreenArguments(
                        dataDocuments.documentID,
                      ),
                    );
                  },
                );
              }
            );
          }
        ),
      ),
      bottomNavigationBar: MyBottomNavigationBar(),
    );
  }
}

class MyBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {    
    return Container(
      height: 55.0,
      child: BottomAppBar(
        color: Color.fromRGBO(58, 66, 86, 1.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.blur_on, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.hotel, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.account_box, color: Colors.white),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }

}