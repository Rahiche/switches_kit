import 'package:flutter/material.dart';


import 'package:switches_kit/src/LabeledSwitch.dart';

class LabeledSwitch extends StatefulWidget {
  @override
  _RotatingToggleState createState() => _RotatingToggleState();
}

class _RotatingToggleState extends State<LabeledSwitch> {
  bool switchValue = true;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Switch Theme"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: buildRow1(Colors.pinkAccent),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: buildRow1(Colors.teal),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: buildRow1(Colors.indigo),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: buildRow1(Colors.deepOrange),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: buildRow1(Colors.red),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: buildRow1(Colors.deepPurpleAccent),
          ),
        ],
      ),
    );
  }

  Row buildRow1(Color color) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: LabeledToggle.theme(
              thumbSize: 50.0,
              rounded: false,
              onText: "ON",
              offText: "OFF",
              borderSize: 1.5,
              value: switchValue,
              onChanged: (v) {
                setState(() {
                  switchValue = v;
                });
              },
              offColor: Colors.white,
              onColor: color,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: LabeledToggle.theme(
              thumbSize: 50.0,
              onText: "ON",
              offText: "OFF",
              borderSize: 1.5,
              value: !switchValue,
              onChanged: (v) {
                setState(() {
                  switchValue = v;
                });
              },
              offColor: Colors.white,
              onColor: color,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: LabeledToggle.theme(
              thumbSize: 50.0,
              onText: "ON",
              offText: "OFF",
              borderSize: 1.5,
              value: !switchValue,
              offColor: Colors.white,
              onColor: color,
            ),
          ),
        ),
      ],
    );
  }
}





