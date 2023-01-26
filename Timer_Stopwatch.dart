import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyWidget());
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          title: const Text("Flutter Timer"),
        ),
        body: const StreamBuilderExample(),
      ),
    );
  }
}

class StreamBuilderExample extends StatefulWidget {
  const StreamBuilderExample({super.key});

  @override
  StreamBuilderExampleState createState() => StreamBuilderExampleState();
}

class StreamBuilderExampleState extends State<StreamBuilderExample> {
  int _timerValue = 0;
  bool _paused = true;

  final Stream<int> _periodicStream =
      Stream.periodic(const Duration(seconds: 1), (i) => i);

  int _previousStreamValue = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(10),
      child: StreamBuilder(
        stream: this._periodicStream,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != this._previousStreamValue) {
              print('Latest snapshot from stream: ${snapshot.data}');
              this._previousStreamValue = snapshot.data!;
              if (!_paused) {
                this._timerValue++;
              }
            }
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                "",
              ),
              Card(child: _buildTimerUI()),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTimerUI() {
    return Column(
      children: <Widget>[
        Text(
          '$_timerValue',
          style: Theme.of(context).textTheme.headline4,
        ),
        ButtonBar(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: Icon(this._paused ? Icons.play_arrow : Icons.pause),
              onPressed: () => setState(() => this._paused = !this._paused),
            ),
            IconButton(
              icon: const Icon(Icons.stop),
              onPressed: () => setState(
                () {
                  this._timerValue = 0;
                  this._paused = true;
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
