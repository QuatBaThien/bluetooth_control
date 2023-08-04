import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class buzzerPage extends StatefulWidget {
  const buzzerPage({
    Key? key,
    required this.sendDataLeft,
    required this.sendDataForward,
    required this.sendDataBackward,
    required this.sendDataRight,
    required this.sendDataStop,
    required this.sendDataAutoFind,
  }) : super(key: key);
  final Function sendDataLeft;
  final Function sendDataForward;
  final Function sendDataBackward;
  final Function sendDataRight;
  final Function sendDataStop;
  final Function sendDataAutoFind;

  @override
  _buzzerPageState createState() => _buzzerPageState();
}

class _buzzerPageState extends State<buzzerPage> {
  static const timeDelay = Duration(milliseconds: 1000);
  Timer? _holdTimer;

  void _startHoldTimer(Function onPressed) {
    _holdTimer = Timer.periodic(timeDelay, (_) {
      onPressed();
    });
  }

  void _stopHoldTimer() {
    _holdTimer?.cancel();
  }

  AudioCache audioCache = AudioCache();

  late AudioPlayer audioPlayer;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    audioPlayer.dispose();
  }

  @override
  void dispose() {
    _stopHoldTimer();
    super.dispose();
  }
// Hàm chơi âm thanh dựa trên tên file âm thanh
  void playSound(String soundName) async {
    try {
      String path = '$soundName.mp3';
      audioPlayer.play(path as Source);
    } catch (e) {
      print('Error while playing audio: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    playSound('up');
                    widget.sendDataForward();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    overlayColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.hovered))
                          return Colors.blue.withOpacity(0.04);
                        if (states.contains(MaterialState.focused) ||
                            states.contains(MaterialState.pressed))
                          return Colors.blue.withOpacity(0.12);
                        return null; // Defer to the button's default.
                      },
                    ),
                  ),
                  child: Text('UP'),
                ),
                ElevatedButton(
                  onPressed: () {
                    playSound('up');
                    widget.sendDataForward();
                    Future.delayed(Duration(milliseconds: 300), () {
                      widget.sendDataStop();
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    overlayColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.hovered))
                          return Colors.blue.withOpacity(0.04);
                        if (states.contains(MaterialState.focused) ||
                            states.contains(MaterialState.pressed))
                          return Colors.blue.withOpacity(0.12);
                        return null; // Defer to the button's default.
                      },
                    ),
                  ),
                  child: Text('UP 1'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    playSound('left');
                    widget.sendDataLeft();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    overlayColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.hovered))
                          return Colors.blue.withOpacity(0.04);
                        if (states.contains(MaterialState.focused) ||
                            states.contains(MaterialState.pressed))
                          return Colors.blue.withOpacity(0.12);
                        return null; // Defer to the button's default.
                      },
                    ),
                  ),
                  child: Text('LEFT'),
                ),
                ElevatedButton(
                  onPressed: () {
                    playSound('left');
                    widget.sendDataLeft();
                    Future.delayed(Duration(milliseconds: 250), () {
                      widget.sendDataStop();
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    overlayColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.hovered))
                          return Colors.blue.withOpacity(0.04);
                        if (states.contains(MaterialState.focused) ||
                            states.contains(MaterialState.pressed))
                          return Colors.blue.withOpacity(0.12);
                        return null; // Defer to the button's default.
                      },
                    ),
                  ),
                  child: Text('LEFT 1'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    playSound('right');
                    widget.sendDataRight();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    overlayColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.hovered))
                          return Colors.blue.withOpacity(0.04);
                        if (states.contains(MaterialState.focused) ||
                            states.contains(MaterialState.pressed))
                          return Colors.blue.withOpacity(0.12);
                        return null; // Defer to the button's default.
                      },
                    ),
                  ),
                  child: Text('RIGHT'),
                ),
                ElevatedButton(
                  onPressed: () {
                    playSound('right');
                    widget.sendDataRight();
                    Future.delayed(Duration(milliseconds: 250), () {
                      widget.sendDataStop();
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    overlayColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.hovered))
                          return Colors.blue.withOpacity(0.04);
                        if (states.contains(MaterialState.focused) ||
                            states.contains(MaterialState.pressed))
                          return Colors.blue.withOpacity(0.12);
                        return null; // Defer to the button's default.
                      },
                    ),
                  ),
                  child: Text('RIGHT 1'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    playSound('down');
                    widget.sendDataBackward();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    overlayColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.hovered))
                          return Colors.blue.withOpacity(0.04);
                        if (states.contains(MaterialState.focused) ||
                            states.contains(MaterialState.pressed))
                          return Colors.blue.withOpacity(0.12);
                        return null; // Defer to the button's default.
                      },
                    ),
                  ),
                  child: Text('DOWN'),
                ),
                ElevatedButton(
                  onPressed: () {
                    playSound('down');
                    widget.sendDataBackward();
                    Future.delayed(Duration(milliseconds: 300), () {
                      widget.sendDataStop();
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    overlayColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.hovered))
                          return Colors.blue.withOpacity(0.04);
                        if (states.contains(MaterialState.focused) ||
                            states.contains(MaterialState.pressed))
                          return Colors.blue.withOpacity(0.12);
                        return null; // Defer to the button's default.
                      },
                    ),
                  ),
                  child: Text('DOWN 1'),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                widget.sendDataAutoFind();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                overlayColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.hovered))
                      return Colors.blue.withOpacity(0.04);
                    if (states.contains(MaterialState.focused) ||
                        states.contains(MaterialState.pressed))
                      return Colors.blue.withOpacity(0.12);
                    return null; // Defer to the button's default.
                  },
                ),
              ),
              child: Text('AutoFind'),
            ),
            ElevatedButton(
              onPressed: () {
                widget.sendDataStop();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                overlayColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.hovered))
                      return Colors.blue.withOpacity(0.04);
                    if (states.contains(MaterialState.focused) ||
                        states.contains(MaterialState.pressed))
                      return Colors.blue.withOpacity(0.12);
                    return null; // Defer to the button's default.
                  },
                ),
              ),
              child: Text('STOP'),
            ),
          ],
        ),
      ),
    );
  }
}
