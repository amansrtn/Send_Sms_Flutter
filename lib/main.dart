// ignore_for_file: avoid_print, unused_element, library_private_types_in_public_api

import 'package:background_sms/background_sms.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  _getPermission() {
    return Permission.sms.request();
  }

  Future<bool> _isPermissionGranted() {
    return Permission.sms.status.isGranted;
  }
  //  bool isPermissionAndSupportGranted = await requestSmsPermissionAndCheckSupport();
  // Future<bool> requestSmsPermissionAndCheckSupport() async {
  //   var smsPermissionStatus = await Permission.sms.request();
  //   bool isPermissionGranted = smsPermissionStatus.isGranted;
  //   bool? supportsCustomSim = await BackgroundSms.isSupportCustomSim;
  //   return isPermissionGranted && (supportsCustomSim ?? false);
  // }

  _sendMessage(String phoneNumber, String message, int simSlot) async {
    var result = await BackgroundSms.sendMessage(
        phoneNumber: phoneNumber, message: message, simSlot: 1);
    if (result == SmsStatus.sent) {
      print("Sent");
    } else {
      print("Failed");
    }
  }

  Future<bool?> get _supportCustomSim {
    return BackgroundSms.isSupportCustomSim;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Send Sms'),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.send),
          onPressed: () async {
            if (await _isPermissionGranted()) {
              _sendMessage("+917002066177", "Hello", 1);
            } else {
              _getPermission();
            }
          },
        ),
      ),
    );
  }
}
