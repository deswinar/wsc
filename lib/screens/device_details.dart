import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:wsc/arguments/device_details_args.dart';
import 'package:wsc/networks/database_service.dart';
import 'package:wsc/providers/device_provider.dart';

class DeviceDetailsScreen extends StatelessWidget {
  static const routeName = '/device_details';
  const DeviceDetailsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DeviceDetailsScreenArguments args = ModalRoute.of(context).settings.arguments;
    final db = DatabaseService();
    
    return StreamProvider<DeviceProvider>(
      initialData: DeviceProvider.initialData(),
      create: (context) => db.getDevice(args.id),
      child: DeviceDetails(args.id),
    );
  }
}

class DeviceDetails extends StatelessWidget {
  String id;
  DeviceDetails(@required this.id);
  @override
  Widget build(BuildContext context) {
    final db = DatabaseService();
    final deviceProvider = Provider.of<DeviceProvider>(context);    
    if(deviceProvider == null) return Text('Loading...');
    print(id);

    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    
    titleController.text = deviceProvider.title;
    descriptionController.text = deviceProvider.description;

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
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
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
                          onSubmitted: (text) {
                            deviceProvider.setTitle(text);
                            db.updateDevice(id, {
                              'title': deviceProvider.title
                            });
                          },
                        ),
                        TextField(
                          controller: descriptionController,
                          decoration: InputDecoration(
                            labelText: 'Description',
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.lightBlue, width: 2.0)),
                          ),
                          onSubmitted: (text) {
                            deviceProvider.setDescription(text);
                            db.updateDevice(id, {
                              'description': deviceProvider.description
                            });
                          },
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
                              builder: (context, deviceTriggerTo, child) {
                                return Switch(
                                  value: deviceProvider.triggerTo,
                                  onChanged: (value) {
                                    deviceProvider.setTriggerTo(!deviceProvider.triggerTo);
                                    db.updateDevice(id, {
                                      'trigger_to': deviceProvider.triggerTo
                                    });
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
                                  // print('confirm $datetime');
                                  _date = '${datetime.year} - ${datetime.month} - ${datetime.day}';
                                  deviceProvider.setDate(_date);
                                  _time = '${datetime.hour} : ${datetime.minute} : ${datetime.second}';
                                  deviceProvider.setTime(_time);

                                  deviceProvider.setTriggerTime(datetime.toString());
                                  db.updateDevice(id, {
                                    'trigger_time': deviceProvider.triggerTime
                                  });
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
                                                deviceProvider.triggerTime.toString(),
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.0
                                                ),
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
                                    fontSize: 16.0
                                  ),
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
                    builder: (context, deviceStatus, child) => CircleAvatar(
                      radius: 30,
                      backgroundColor: deviceProvider.status == true ? Colors.green : Colors.red,
                      child: IconButton(
                        icon: Icon(Icons.settings_power, color: Colors.white,),
                        onPressed: () {
                          deviceProvider.setStatus(!deviceProvider.status);
                          print(!deviceProvider.status);
                          db.updateDevice(id, {
                            'status': deviceProvider.status,
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
        )
      )
    );
  }

}