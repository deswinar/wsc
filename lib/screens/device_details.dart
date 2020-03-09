import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:wsc/arguments/device_details_args.dart';
import 'package:wsc/networks/database_service.dart';
import 'package:wsc/providers/device_provider.dart';
import 'package:wsc/widgets/title_text.dart';

class DeviceDetailsScreen extends StatelessWidget {
  static const routeName = '/device_details';

  @override
  Widget build(BuildContext context) {
    final DeviceDetailsScreenArguments args = ModalRoute.of(context).settings.arguments;
    final db = DatabaseService();
    DeviceProvider deviceProvider = Provider.of<DeviceProvider>(context, listen: false);

    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    String _date = "Not set";
    String _time = "Not set";    
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Device Details"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('devices').document(args.id).snapshots(),
        builder: (context, snapshot) {
          if(!snapshot.hasData) return const Text("Loading...");

          DateTime triggerTime = snapshot.data['trigger_time'].toDate();
          print(triggerTime.toString());

          titleController.text = snapshot.data['title'];
          descriptionController.text = snapshot.data['description'];
          return SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 20.0, right: 20.0, left: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextField(
                            controller: titleController,
                            decoration: InputDecoration(
                              labelText: 'Title',
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.lightBlue, width: 2.0)),
                            ),
                          ),
                          TextField(
                            controller: descriptionController,
                            decoration: InputDecoration(
                              labelText: 'Description',
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.lightBlue, width: 2.0)),
                            ),
                          ),
                        ],
                      ),
                    )
                  ),
                  SizedBox(height: 20.0,),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Trigger", style: TextStyle(fontSize: 20,),),
                          Divider(color: Colors.grey,),
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            elevation: 4.0,
                            onPressed: () {
                              DatePicker.showDatePicker(context,
                                  theme: DatePickerTheme(
                                    containerHeight: 210.0,
                                  ),
                                  showTitleActions: true,
                                  minTime: DateTime.now(),
                                  maxTime: DateTime.now().add(new Duration(days: 30)), onConfirm: (date) {
                                    print('confirm $date');
                                    _date = '${date.year} - ${date.month} - ${date.day}';
                                    deviceProvider.setDate(_date);
                                    DatePicker.showTimePicker(context,
                                      theme: DatePickerTheme(
                                        containerHeight: 210.0,
                                      ),
                                      showTitleActions: true, onConfirm: (time) {
                                        print('confirm $time');
                                        _time = '${time.hour} : ${time.minute} : ${time.second}';
                                        deviceProvider.setTime(_time);
                                      }, currentTime: DateTime.now(), locale: LocaleType.en);
                                  }, currentTime: DateTime.now(), locale: LocaleType.en);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 50.0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        child: Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.date_range,
                                              size: 16.0,
                                              color: Colors.white,
                                            ),
                                            Selector<DeviceProvider, Tuple2<String, String>>(
                                              selector: (context, device) => Tuple2(device.date, device.time),
                                              builder: (context, data, child) {
                                                return Text(
                                                  data.item1.toString() + '   ' + data.item2.toString(),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 16.0),
                                                );
                                              }
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Text(
                                    "  Change",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0),
                                  ),
                                ],
                              ),
                            ),
                            color: Colors.black45,
                          ),
                        ],
                      ),
                    )
                  ),
                ],
              ),
            ),
          );
        }
      )
    );
  }

}