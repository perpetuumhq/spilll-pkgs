import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_network_monitor/flutter_network_monitor.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  bool isConnected = true;
  StreamSubscription<bool>? _subscription;

  @override
  void initState() {
    _subscription = FlutterNetworkMonitor.onConnectivityChanged.listen((status) {
      if (mounted) {
        setState(() {
          isConnected = status;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Network Monitor')),
        body: Center(
          child: Text(
            isConnected ? 'Connected' : 'No Internet',
            style: TextStyle(fontSize: 24, color: isConnected ? Colors.green : Colors.red),
          ),
        ),
      ),
    );
  }
}
