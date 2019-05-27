import 'package:animation/components/example.dart';
import 'package:animation/page_view/index.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  Animation<double> moveTop;
  double bottom = 110;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(0.4, 1.0, curve: Curves.easeOutExpo)));
    moveTop = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Interval(0.0, 0.4)));
    controller
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Navigator.push(
              context,
              PageRouteBuilder(
                  pageBuilder: (_, a, b) => PageHome(),
                  transitionDuration: Duration(seconds: 0)));
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromRGBO(37, 41, 45, 1),
      body: Stack(
        children: <Widget>[
          Container(
            width: 2000,
            height: 2000,
          ),
          Positioned(
            top: 85,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: size.width * 0.5 * (1 - moveTop.value * moveTop.value),
                height: size.width * 0.5 * (1 - moveTop.value * moveTop.value),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(52, 53, 60, 1),
                    borderRadius:
                        BorderRadius.circular((size.width * 0.5) / 2)),
                child: Center(
                  child: Icon(
                    Icons.check_circle_outline,
                    color: Colors.white,
                    size: size.width * 0.5 * (1 - moveTop.value),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: size.width * 0.5 + 150,
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Want Our Advice?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 26),
                ),
              ],
            ),
          ),
          Positioned(
            top: size.width * 0.5 + 150 + 60,
            left: 30,
            right: 30,
            child: Text(
              "We would like to ask you a few questions to adjust recommendations "
                  "we have for you",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
            ),
          ),
          Positioned(
            top: size.height - 150 - 100 * moveTop.value,
            bottom: 110 + 100 * moveTop.value,
            left: -300,
            right: -300,
            child: OverflowBox(
              maxWidth: 2000,
              maxHeight: 2000,
              child: Center(
                child: Container(
                  width:
                      moveTop.value < 1.0 ? 200 : 200 + 1500 * animation.value,
                  height: moveTop.value < 1.0
                      ? 40 + 160 * moveTop.value
                      : 200 + 1500 * animation.value,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        (controller.isAnimating ? 100 : 5) +
                            animation.value * 500),
                    color: Colors.red,
                  ),
                  child: controller.isDismissed
                      ? FlatButton(
                          splashColor: Colors.white,
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => Example()),
                            // );
                            controller.forward();
                          },
                          child: Text(
                            "LET'S DO IT",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ))
                      : Container(),
                ),
              ),
            ),
          ),
          controller.isDismissed
              ? Positioned(
                  bottom: 30,
                  left: 100,
                  right: 100,
                  child: FlatButton(
                      color: Colors.transparent,
                      onPressed: () {},
                      child: Text(
                        "DO IT LATER",
                        style: TextStyle(color: Colors.grey, fontSize: 20),
                      )),
                )
              : Container()
        ],
      ),
    );
  }
}
