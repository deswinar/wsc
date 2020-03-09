import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wsc/providers/device_provider.dart';
import 'package:wsc/screens/dashboard.dart';
import 'package:wsc/screens/device_details.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp app = await FirebaseApp.configure(
    name: 'esp32',
    options: Platform.isIOS
        ? const FirebaseOptions(
            googleAppID: '1:317684419728:ios:420e96cd81c603c4b11c15',
            gcmSenderID: '317684419728',
            databaseURL: 'https://esp32-37adf.firebaseio.com',
          )
        : const FirebaseOptions(
            googleAppID: '1:317684419728:android:dfe98a932b761049b11c15',
            apiKey: 'AIzaSyBY5wicLz5Bo6J0v-cenKrUzGcpVWyg6dY',
            databaseURL: 'https://esp32-37adf.firebaseio.com',
          ),
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<DeviceProvider>(create: (context) => DeviceProvider()),
      ],
      child: MaterialApp(
        title: "Wireless Stop Contact",
        theme: ThemeData(      
          brightness: Brightness.dark,
          primaryColor: Colors.lightBlue[800],
          accentColor: Colors.cyan[600],
          
          fontFamily: 'Georgia',
          textTheme: TextTheme(
            headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
            body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          ),
        ),
        initialRoute: DashboardScreen.routeName,
        routes: <String, WidgetBuilder>{
          DashboardScreen.routeName: (context) => DashboardScreen(),
          DeviceDetailsScreen.routeName: (context) => DeviceDetailsScreen(),
        },
      ),
    )
  );
}
