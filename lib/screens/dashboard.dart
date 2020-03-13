import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:wsc/arguments/device_details_args.dart';
import 'package:wsc/icons/my_icons.dart';
import 'package:wsc/models/device.dart';
import 'package:wsc/networks/database_service.dart';
import 'package:wsc/screens/device_details.dart';
import 'package:wsc/widgets/device_card.dart';
import 'package:wsc/widgets/dialog_add_device.dart';

class DashboardScreen extends StatefulWidget {
  static const routeName = '/dashboard';

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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
      floatingActionButton: SpeedDial(
        // both default to 16
        marginRight: 18,
        marginBottom: 20,
        animatedIcon: AnimatedIcons.add_event,
        animatedIconTheme: IconThemeData(size: 22.0),
        // this is ignored if animatedIcon is non null
        // child: Icon(Icons.add),
        visible: true,
        // If true user is forced to close dial manually 
        // by tapping main button and overlay is not rendered.
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        onOpen: () => print('Add Device'),
        onClose: () => print('Close'),
        tooltip: 'Add Device',
        heroTag: 'speed-dial-hero-tag',
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 8.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
            child: Icon(Icons.text_fields),
            backgroundColor: Colors.blue,
            label: 'Manual',
            labelStyle: TextStyle(fontSize: 18.0, color: Colors.black),
            onTap: () {
              print('Enter Device Code Manually');
              showDialog(
                context: context,
                builder: (context) => DialogAddDevice(
                  title: "Enter device code",
                )
              );
            }
          ),
          SpeedDialChild(
            child: Icon(MyIcons.qrcode_1),
            backgroundColor: Colors.blue,
            label: 'QR Code',
            labelStyle: TextStyle(fontSize: 18.0, color: Colors.black),
            onTap: () => print('QR Code'),
          ),
        ],
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