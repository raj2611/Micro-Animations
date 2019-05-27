import 'package:flutter/material.dart';

class AgeWidget extends StatefulWidget {
  @override
  _AgeWidgetState createState() => _AgeWidgetState();
}

class _AgeWidgetState extends State<AgeWidget>
    with SingleTickerProviderStateMixin {
  FixedExtentScrollController _controller;
  Animation _animation1;
  Animation _animation2;
  AnimationController _animationController;
  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
    _controller = FixedExtentScrollController(initialItem: 2);
    _animationController =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    Animation curve1 = CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.1,
        0.7,
        curve: Curves.ease,
      ),
    );
    Animation curve2 = CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.7,
        1.0,
        curve: Curves.ease,
      ),
    );
    _animation1 = new Tween(begin: 0.0, end: 1.0).animate(curve1);
    _animation2 = new Tween(begin: 0.0, end: 1.0).animate(curve2)
      ..addListener(() {
        setState(() {});
      });
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 100.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 500,
        child: Stack(
          children: <Widget>[
            Positioned(
              width: MediaQuery.of(context).size.width,
              top: ((1 - _animation2.value) * 50) + 200,
              child: Center(
                child: Container(
                  height: _animation2.value * 100,
                  width: _animation1.value * 200,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.blue),
                      top: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
              ),
            ),
            Opacity(
              opacity: _animation2.value,
              child: ListWheelScrollView(
                diameterRatio: 10,
                controller: _controller,
                physics: FixedExtentScrollPhysics(),
                useMagnifier: false,
                itemExtent: 100,
                children: List.generate(
                  50,
                  (index) {
                    return Container(
                      height: 100,
                      child: Center(
                        child: Text(
                          (index + 18).toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
