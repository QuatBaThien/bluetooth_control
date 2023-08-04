library send_messagee;

import 'dart:async';
import 'dart:convert';

import 'dart:typed_data';
import 'package:buzzer_arduino/control.dart';
import 'package:buzzer_arduino/speech.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class ChatPage extends StatefulWidget {
  final BluetoothDevice? server;
  const ChatPage({
    Key? key,
    this.server,
    this.lcdMessage,
  }) : super(key: key);
  final String? lcdMessage;

  @override
  _ChatPageState createState() => _ChatPageState();
}

var hadi;

class _ChatPageState extends State<ChatPage>
    with SingleTickerProviderStateMixin {
  TabController? _controller;

  BluetoothConnection? connection;

  final ScrollController listScrollController = ScrollController();

  bool isConnecting = true;

  bool get isConnected => connection != null && connection!.isConnected;

  bool isDisconnecting = false;
  @override
  @override
  List<Color> _colorlist = [];
  List<Color> genrateColorslist() {
    List<Color> _colorslist = [];
    for (int i = 0; i < (8 * 8); i++) {
      _colorslist.add(Colors.black);
    }
    return _colorslist;
  }

  void initState() {
    super.initState();

    _colorlist = genrateColorslist();
    _controller = TabController(length: 3, vsync: this, initialIndex: 0);

    BluetoothConnection.toAddress(widget.server!.address).then((_connection) {
      connection = _connection;

      setState(() {
        isConnecting = false;
        isDisconnecting = false;
      });
    });
  }

  void dispose() {
    if (isConnected) {
      isDisconnecting = true;
      connection?.dispose();
      connection = null;
      mineController.close();
    }
    super.dispose();
  }

  bool btnColor = false;

  StreamController<String> mineController =
      StreamController<String>.broadcast();
  Stream<String> myStream() async* {
    connection?.input?.listen((Uint8List data) {
      print(ascii.decode(data));

      mineController.add(ascii.decode(data));
    });
  }

  Widget build(BuildContext context) {
    mineController.addStream(myStream());

    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Control Mode'),
        bottom: TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          controller: _controller,
          tabs: [
            Tab(
              text: "Remote Control",
            ),
            Tab(
              text: "Voice Control",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 95),
              child: buzzerPage(
                sendDataLeft: () => _sendMessage('l'),
                sendDataForward: () => _sendMessage('w'),
                sendDataBackward: () => _sendMessage('b'),
                sendDataRight: () => _sendMessage('r'),
                sendDataStop: () => _sendMessage('i'),
                sendDataAutoFind: () => _sendMessage('n'),
              )),
          Align(
            alignment: Alignment.center,
            child: ledPage(
              sendDataLeft: () => _sendMessage('l'),
              sendDataForward: () => _sendMessage('w'),
              sendDataBackward: () => _sendMessage('b'),
              sendDataRight: () => _sendMessage('r'),
              sendDataStop: () => _sendMessage('i'),
              sendDataAutoFind: () => _sendMessage('n'),
            ),
          ),
          // Align(
          //   alignment: Alignment.center,
          //   child: Padding(
          //     padding: EdgeInsets.symmetric(
          //         horizontal: MediaQuery.of(context).size.width / 10),
          //     child: SingleChildScrollView(
          //       physics: ClampingScrollPhysics(),
          //       child: Column(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             TextField(
          //               controller: lcdController,
          //               decoration: InputDecoration(
          //                 hintText: "Nhập tin nhắn",
          //               ),
          //             ),
          //             IconButton(
          //                 onPressed: () {
          //                   _sendMessage('x' + lcdController.text);
          //                 },
          //                 icon: Icon(Icons.send)),
          //             IconButton(
          //                 onPressed: () {
          //                   _sendMessage('t');
          //                 },
          //                 icon: Icon(Icons.clear))
          //           ]),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  btnColorChange() {
    setState(() {
      btnColor = !btnColor;
    });
  }

  _sendMessage(String text) async {
    text = text.trim();
    print("Sending: "+ text);
    if (text.length > 0) {
      try {
        connection!.output.add(Uint8List.fromList(utf8.encode(text)));

        await connection!.output.allSent;
      } catch (e) {
        // Ignore error, but notify state

      }
    }
  }

  _receiveMessage() {
    connection!.input!.listen((Uint8List data) {
      print('Data incoming: ${ascii.decode(data)}');
      void deneme = ascii.decode(data);

      return deneme;
    });
  }
}
