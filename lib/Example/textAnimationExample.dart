import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter/services.dart';
import 'package:switches_kit/src/LabeledSwitch.dart';

class LabeledExample extends StatefulWidget {
  @override
  _RotatingToggleState createState() => _RotatingToggleState();
}

class _RotatingToggleState extends State<LabeledExample> {
  bool switchValue = true;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
                child: Text(
              "Label Animation",
              style: TextStyle(fontSize: 20.0),
            )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: LabeledToggle(
                borderSize: 10.0,
                rounded: false,
                duration: Duration(milliseconds: 500),
                forceWidth: true,
                value: switchValue,
                onChanged: (v) {
                  setState(() {
                    switchValue = v;
                  });
                },
                offBkColor: Colors.white,
                onBkColor: Colors.white,
                onBorderColor: Colors.green,
                offBorderColor: Colors.red,
                offText: "No",
                onText: "YES",
                offThumbColor: Colors.red,
                onThumbColor: Colors.green,
                thumbSize: 150.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: LabeledToggle(
                transitionType: TextTransitionTypes.SIZE,
                rounded: true,
                borderSize: 0.01,
                duration: Duration(milliseconds: 500),
                forceWidth: true,
                value: switchValue,
                onChanged: (v) {
                  setState(() {
                    switchValue = v;
                  });
                },
                offBkColor: Colors.indigo,
                onBkColor: Colors.teal,
                offText: "OFFLINE",
                onText: "ONLINE",
                offThumbColor: Colors.orange,
                onThumbColor: Colors.blue,
                thumbSize: 150.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: LabeledToggle(
                transitionType: TextTransitionTypes.ROTATE,
                rounded: false,
                duration: Duration(milliseconds: 500),
                forceWidth: true,
                value: switchValue,
                onChanged: (v) {
                  setState(() {
                    switchValue = v;
                  });
                },
                onText: "ON",
                offText: "OFF",
                offBkColor: Colors.white,
                onBkColor: Colors.white,
                offThumbColor: Colors.deepOrange,
                onThumbColor: Colors.cyan,
                thumbSize: 150.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: LabeledToggle(
                transitionType: TextTransitionTypes.FADE,
                rounded: true,
                borderSize: 5.0,
                duration: Duration(milliseconds: 500),
                forceWidth: true,
                value: switchValue,
                onChanged: (v) {
                  setState(() {
                    switchValue = v;
                  });
                },
                offBkColor: Colors.indigo,
                onBkColor: Colors.lightGreen,
                offText: "FALSE",
                onText: "TRUE",
                offThumbColor: Colors.lightGreen,
                onThumbColor: Colors.indigo,
                thumbSize: 150.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
