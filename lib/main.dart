import 'package:buzzer_arduino/send_message.dart';
import 'package:buzzer_arduino/connection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Robot Control',

      home: FutureBuilder(
        future: FlutterBluetoothSerial.instance.requestEnable(),
        builder: (BuildContext context, future) {
          return Home();
        },
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Robot Control"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Choose your bluetooth connection",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: SelectBondedDevicePage(
                onCahtPage: (device1) {
                  BluetoothDevice device = device1;
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ChatPage(
                      server: device,
                    );
                  }));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
