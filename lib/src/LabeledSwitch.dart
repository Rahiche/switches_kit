import 'package:flutter/material.dart';

enum TextTransitionTypes { ROTATE, SCALE, FADE, SIZE }

class LabeledToggle extends StatefulWidget {
  final Widget child;
  final String onText;
  final String offText;
  final Color onTextColor;
  final Color offTextColor;
  final Color onThumbColor;
  final Color offThumbColor;
  final Color onBorderColor;
  final Color offBorderColor;
  final Color onBkColor;
  final Color offBkColor;
  final bool value;
  final double thumbSize;
  final double borderSize;
  final Duration duration;
  final Curve curve;
  final ValueChanged<bool> onChanged;
  final bool forceWidth;
  final bool rounded;
  final TextTransitionTypes transitionType;
  final bool rotationAnimation;

  const LabeledToggle(
      {Key key,
        this.value = false,
        this.onText = "",
        this.offText = "",
        this.onThumbColor,
        this.offThumbColor,
        this.onBorderColor,
        this.offBorderColor,
        this.onBkColor,
        this.offBkColor,
        this.onChanged,
        @required this.thumbSize,
        this.duration = const Duration(milliseconds: 400),
        this.curve = Curves.linear,
        this.forceWidth = false,
        this.onTextColor = Colors.black,
        this.offTextColor = Colors.black,
        this.rounded = true,
        this.borderSize = 1.0,
        this.transitionType = TextTransitionTypes.SCALE,
        this.rotationAnimation = false,
        this.child})
      : assert(thumbSize != null),
        super(key: key);

  const LabeledToggle.theme(
      {Key key,
        this.value = false,
        this.onText = "",
        this.offText = "",
        @required onColor,
        @required offColor,
        this.onChanged,
        @required this.thumbSize,
        this.duration = const Duration(milliseconds: 400),
        this.curve = Curves.linear,
        this.forceWidth = false,
        this.rounded = true,
        this.borderSize = 1.0,
        this.transitionType = TextTransitionTypes.SCALE,
        this.rotationAnimation = false,
        this.child})
      : assert(thumbSize != null),
        onThumbColor = offColor,
        onBorderColor = offColor,
        onBkColor = onColor,
        offThumbColor = onColor,
        offBorderColor = onColor,
        offBkColor = offColor,
        onTextColor = offColor,
        offTextColor = onColor,
        super(key: key);

  @override
  _LabeledToggleState createState() => _LabeledToggleState();
}

class _LabeledToggleState extends State<LabeledToggle>
    with SingleTickerProviderStateMixin {
  bool _value;
  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
    animationController =
        AnimationController(vsync: this, duration: widget.duration);
    CurvedAnimation curvedAnimation =
    CurvedAnimation(parent: animationController, curve: widget.curve);
    animation = Tween<double>(begin: 0.0, end: 180.0).animate(curvedAnimation)
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
  void didUpdateWidget(LabeledToggle oldWidget) {
    super.didUpdateWidget(oldWidget);
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged == null ? print("") : widget.onChanged(!_value);
        if (widget.rotationAnimation) {
          if (animationController.status == AnimationStatus.completed) {
            animationController.reverse();
          } else {
            animationController.forward();
          }
        }
      },
      child: Opacity(
        opacity: widget.onChanged == null ? 0.3 : 1.0,
        child: AnimatedContainer(
          duration: widget.duration,
          height: widget.thumbSize,
          width: widget.forceWidth ? widget.thumbSize * 2 : null,
          child: Stack(
            children: <Widget>[
              buildThumb(),
              buildLabel(),
            ],
          ),
          decoration: BoxDecoration(
              border: Border.all(
                  color: widget.onChanged == null
                      ? Color(0xFFD3D3D3)
                      : _value
                      ? (widget.onBorderColor ?? widget.onThumbColor)
                      : (widget.offBorderColor ?? widget.offThumbColor),
                  width: widget.borderSize),
              color: _value ? widget.onBkColor : widget.offBkColor,
              borderRadius:
              BorderRadius.circular(widget.rounded ? 100.0 : 0.0)),
        ),
      ),
    );
  }

  Widget buildLabel() {
    return Padding(
      padding: EdgeInsets.only(
          right: _value ? widget.thumbSize : 1.0,
          left: _value ? 1.0 : widget.thumbSize),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                height: widget.thumbSize,
                child: FittedBox(
                  child: Center(
                    child: AnimatedSwitcher(
                      duration: widget.duration,
                      switchInCurve: widget.curve,
                      switchOutCurve: widget.curve,
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        switch (widget.transitionType) {
                          case TextTransitionTypes.ROTATE:
                            {
                              return RotationTransition(
                                child: child,
                                turns: animation,
                              );
                            }
                            break;
                          case TextTransitionTypes.FADE:
                            {
                              return FadeTransition(
                                child: child,
                                opacity: animation,
                              );
                            }
                            break;

                          case TextTransitionTypes.SIZE:
                            {
                              return SizeTransition(
                                child: child,
                                sizeFactor: animation,
                                axisAlignment: widget.value ? -5.0 : 5.0,
                                axis: Axis.horizontal,
                              );
                            }
                            break;

                          case TextTransitionTypes.SCALE:
                            {
                              return ScaleTransition(
                                child: child,
                                scale: animation,
                              );
                            }
                            break;
                        }
                      },
                      child: Text(
                        _value ? widget.onText : widget.offText,
                        key: ValueKey<bool>(_value),
                        style: TextStyle(
                            color: _value
                                ? widget.onTextColor
                                : widget.offTextColor),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildThumb() {
    return AnimatedAlign(
      curve: widget.curve,
      alignment: _value ? Alignment.centerRight : Alignment.centerLeft,
      duration: widget.duration,
      child: RotationTransition(
        turns: AlwaysStoppedAnimation(animation.value / 360),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: AnimatedContainer(
            duration: widget.duration,
            width: widget.thumbSize,
            height: widget.thumbSize,
            child: widget?.child,
            decoration: BoxDecoration(
              shape: widget.rounded ? BoxShape.circle : BoxShape.rectangle,
              color: _value ? widget.onThumbColor : widget.offThumbColor,
            ),
          ),
        ),
      ),
    );
  }
}
