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

    DateTime triggerTime;
    String _date = "Not set";
    String _time = "Not set";
    bool triggerTo;
    bool status;
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Device Details"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.save, color: Colors.white,
        ),
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.of(context).pop();
          db.updateDevice(args.id, {
            'title': titleController.text,
            'description': descriptionController.text,
            'trigger_time': triggerTime,
            'trigger_to': triggerTo,
          });
        }
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: StreamBuilder(
          stream: db.getDevice(args.id),
          builder: (context, snapshot) {
            if(!snapshot.hasData) return const Text("Loading...");

            triggerTime = snapshot.data['trigger_time'].toDate();
            triggerTo = snapshot.data['trigger_to'];
            status = snapshot.data['status'];
            print(triggerTime.toString());

            titleController.text = snapshot.data['title'];
            descriptionController.text = snapshot.data['description'];
            return SingleChildScrollView(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 20.0, right: 15.0, left: 15.0),
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
                        padding: const EdgeInsets.only(top: 10.0, bottom: 20.0, right: 15.0, left: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Trigger", style: TextStyle(fontSize: 20,),),
                            Divider(color: Colors.grey,),
                            Text("To :", style: TextStyle(fontSize: 16),),
                            SizedBox(height: 6.0,),
                            Row(
                              children: <Widget>[
                                Text("Off"),
                                Selector<DeviceProvider, bool>(
                                  selector: (context, device) => device.triggerTo,
                                  builder: (context, device, child) {
                                    return Switch(
                                      value: deviceProvider.triggerTo,
                                      onChanged: (value) {
                                        deviceProvider.setTriggerTo(value);
                                        triggerTo = deviceProvider.triggerTo;
                                      },
                                      activeTrackColor: Colors.lightGreenAccent, 
                                      activeColor: Colors.green,
                                    );
                                  }
                                ),
                                Text("On"),
                              ],
                            ),
                            SizedBox(height: 6.0,),
                            Text("At :", style: TextStyle(fontSize: 16),),
                            SizedBox(height: 6.0,),
                            RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              elevation: 4.0,
                              onPressed: () {
                                DatePicker.showDateTimePicker(context,
                                    theme: DatePickerTheme(
                                      containerHeight: 210.0,
                                    ),
                                    showTitleActions: true,
                                    minTime: DateTime.now(),
                                    maxTime: DateTime.now().add(new Duration(days: 30)), onConfirm: (datetime) {
                                      print('confirm $datetime');
                                      _date = '${datetime.year} - ${datetime.month} - ${datetime.day}';
                                      deviceProvider.setDate(_date);
                                      _time = '${datetime.hour} : ${datetime.minute} : ${datetime.second}';
                                      deviceProvider.setTime(_time);

                                      triggerTime = datetime;
                                    }, currentTime: DateTime.now(), locale: LocaleType.id);
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
                                                    triggerTime.toString(),
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
                    SizedBox(height: 10.0,),
                    Center(
                      child: Selector<DeviceProvider, bool>(
                        selector: (context, device) => device.status,
                        builder: (context, device, child) => CircleAvatar(
                          radius: 30,
                          backgroundColor: deviceProvider.status == true ? Colors.green : Colors.red,
                          child: IconButton(
                            icon: Icon(Icons.settings_power, color: Colors.white,),
                            onPressed: () {
                              // if(deviceProvider.status == true) {
                              //   status = false;
                              // }else {
                              //   status = true;
                              // }
                              deviceProvider.setStatus(!deviceProvider.status);
                              status = deviceProvider.status;
                              db.updateDevice(args.id, {
                                'status': status,
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0,),
                  ],
                ),
              ),
            );
          }
        ),
      )
    );
  }

}