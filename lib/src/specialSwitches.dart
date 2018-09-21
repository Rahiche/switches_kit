import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter/scheduler.dart';

class ToggleKitExamples extends StatefulWidget {
  @override
  _ToggleKitExamplesState createState() => _ToggleKitExamplesState();
}

class _ToggleKitExamplesState extends State<ToggleKitExamples>
    with SingleTickerProviderStateMixin {
  bool value = true;
  Duration _duration = Duration(milliseconds: 500);

  AnimationController animationController;
  Animation<double> animation;
  Animation<double> _likeAnimation;
  Animation<double> _dayNightAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: _duration);
    CurvedAnimation curvedAnimation =
    CurvedAnimation(parent: animationController, curve: Curves.linear);
    animation = Tween<double>(begin: -90.0, end: 90.0).animate(curvedAnimation)
      ..addListener(() {
        setState(() {});
      });

    _likeAnimation =
    Tween<double>(begin: 180.0, end: 0.0).animate(curvedAnimation)
      ..addListener(() {
        setState(() {});
      });
    _dayNightAnimation =
    Tween<double>(begin: 5.0, end: 1.3).animate(curvedAnimation)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          genderTogglePage(),
          likeTogglePage(),
          dayNightTogglePage(),
        ],
      ),
      backgroundColor: Color(0xFFA2A2FF),
    );
  }

  Widget dayNightTogglePage() {
    return Stack(
      children: <Widget>[
        AnimatedContainer(
          duration: _duration,
          decoration: BoxDecoration(
            boxShadow: [
              new BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10.0,
              ),
            ],
            color: value ? Colors.white : Colors.black38,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: GestureDetector(
              onTap: () {
                if (animationController.status == AnimationStatus.completed) {
                  animationController.reverse();
                } else {
                  animationController.forward();
                }
                setState(() {
                  value = !value;
                });
              },
              child: AnimatedContainer(
                duration: _duration,
                width: 250.0,
                height: 100.0,
                child: Stack(
                  children: <Widget>[
                    AnimatedAlign(
                      duration: _duration,
                      alignment:
                      value ? Alignment.centerRight : Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ClipPath(
                          clipper: DayNightClipper(_dayNightAnimation.value),
                          child: Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                              color: value ? Colors.orange : Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    boxShadow: [
                      new BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10.0,
                      ),
                    ],
                    color: value ? Colors.white : Colors.black38,
                    borderRadius: BorderRadius.circular(50.0)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget likeTogglePage() {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 200.0),
          child: Align(
            alignment: Alignment.topCenter,
            child: Text(
              "Like ?",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        likeToggle(),
      ],
    );
  }

  Widget likeToggle() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: GestureDetector(
          onTap: () {
            if (animationController.status == AnimationStatus.completed) {
              animationController.reverse();
            } else {
              animationController.forward();
            }
            setState(() {
              value = !value;
            });
          },
          child: AnimatedContainer(
            duration: _duration,
            width: 250.0,
            height: 100.0,
            decoration: BoxDecoration(
                color: value ? Colors.white : Color(0xFF3B5998),
                borderRadius: BorderRadius.circular(50.0)),
            child: Stack(
              children: <Widget>[
                AnimatedAlign(
                  duration: _duration,
                  alignment:
                  value ? Alignment.centerLeft : Alignment.centerRight,
                  child: RotationTransition(
                    turns: AlwaysStoppedAnimation(_likeAnimation.value / 360),
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: AnimatedContainer(
                        width: 100.0,
                        height: 100.0,
                        duration: _duration,
                        child: Icon(
                          Icons.thumb_up,
                          size: 40.0,
                          color: value ? Colors.white : Color(0xFF3B5998),
                        ),
                        decoration: BoxDecoration(
                          color: value ? Colors.grey : Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget genderTogglePage() {
    return Stack(
      children: <Widget>[
        buildTitle(),
        createGenderToggle(),
        buildMaleText(),
        buildFemaleText(),
      ],
    );
  }

  Widget buildTitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 200.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: Text(
          "GENDER",
          style: TextStyle(
              color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildFemaleText() {
    return AnimatedPositioned(
      duration: _duration,
      bottom: 100.0,
      right: value ? -MediaQuery.of(context).size.width : 0.0,
      left: value ? MediaQuery.of(context).size.width : 0.0,
      child: Container(
        height: 100.0,
        child: FittedBox(
          child: Text(
            "FEMALE",
            style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget buildMaleText() {
    return AnimatedPositioned(
      duration: _duration,
      bottom: 100.0,
      right: value ? 0.0 : MediaQuery.of(context).size.width,
      left: value ? 0.0 : -MediaQuery.of(context).size.width,
      child: Container(
        height: 100.0,
        child: FittedBox(
          child: Text(
            "MALE",
            style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Padding createGenderToggle() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: GestureDetector(
          onTap: () {
            if (animationController.status == AnimationStatus.completed) {
              animationController.reverse();
            } else {
              animationController.forward();
            }
            setState(() {
              value = !value;
            });
          },
          child: Container(
            width: 250.0,
            height: 100.0,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10.0,
                  ),
                ],
                border: Border.all(color: Color(0xFFA2A2FF), width: 1.0),
                color: Colors.white,
                borderRadius: BorderRadius.circular(50.0)),
            child: Stack(
              children: <Widget>[
                AnimatedAlign(
                  duration: _duration,
                  alignment:
                  value ? Alignment.centerLeft : Alignment.centerRight,
                  child: RotationTransition(
                    turns: AlwaysStoppedAnimation(animation.value / 360),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AnimatedContainer(
                        width: 100.0,
                        height: 100.0,
                        duration: _duration,
                        child: Stack(
                          children: <Widget>[
                            Padding(
                              padding:
                              const EdgeInsets.only(left: 25.0, top: 20.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xFFA2A2FF),
                                      shape: BoxShape.circle),
                                  width: 10.0,
                                  height: 10.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.only(right: 25.0, top: 20.0),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xFFA2A2FF),
                                      shape: BoxShape.circle),
                                  width: 10.0,
                                  height: 10.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: CustomPaint(
                                  painter: Mouth(),
                                  child: Container(
                                    width: 20.0,
                                    height: 10.0,
                                  ),
                                ),
                              ),
                            ),
                            AnimatedOpacity(
                              duration: _duration,
                              opacity: value ? 0.0 : 1.0,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    width: 30.0,
                                    height: 15.0,
                                    transform: Matrix4.rotationZ(-0.6),
                                    child: Image.asset(
                                      "assets/bow.png",
                                      fit: BoxFit.fill,
                                    )),
                              ),
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: Color(0xFFFFE4E7),
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Color(0xFFA2A2FF), width: 3.0)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Mouth extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = new Paint()
      ..color = Color(0xFFA2A2FF)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    Path path = Path();
    path.conicTo(size.width / 2, size.height, size.width, 0.0, 1.5);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class DayNightClipper extends CustomClipper<Path> {
  double value;

  DayNightClipper(this.value);

  @override
  Path getClip(Size size) {
    var path = Path();
    var pointX = size.width / value;
    var pointY = size.height / value;
    path.moveTo(size.width / 2, 0.0);
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.lineTo(0.0, pointY);
    path.conicTo(pointX, pointY, pointX, 0.0, 1.0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
