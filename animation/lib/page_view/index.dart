import 'package:animation/components/age_widget.dart';
import 'package:animation/components/fitness.dart';
import 'package:animation/components/gender_widget.dart';
import 'package:animation/components/heightWidget.dart';
import 'package:animation/home/index.dart';
import 'package:flutter/material.dart';

class PageHome extends StatefulWidget {
  _PageHomeState createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> with TickerProviderStateMixin {
  PageController pageController;
  AnimationController controller;
  AnimationController moveUp;
  Animation<double> up;
  Animation<double> animation;
  Animation<double> animationTwo;
  Animation<double> animationThree;
  Animation<double> animationFour;
  List<Widget> widgets = [
    GenderWidget(),
    AgeWidget(),
    HeightWidget(),
    FitnessWidget()
  ];
  int index = 0;
  List<String> text1 = [
    "Choose Your Gender",
    "How Old Are You?",
    "How Tall Are You?",
    "What Is your fitness goal?",
    "das"
  ];
  List<String> text2 = [
    "This Will Help Us to Adjust reps, weighs and plans for you.",
    "This is used to provied you with more suitable workout plans an to let you track your progress.",
    "This is used to provied you with more suitable workout plans an to let you track your progress.",
    "This is used to provied you with more suitable workout plans an to let you track your progress.",
    "This is used to provied you with more suitable workout plans an to let you track your progress.",
  ];
  @override
  void initState() {
    super.initState();
    pageController = PageController(keepPage: true);
    pageController.addListener(() {
      print(pageController.page);
      setState(() {});
    });
    moveUp =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    up = new Tween<double>(begin: 0.0, end: 1.0).animate(moveUp);
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    animation = new Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 0.5, curve: Curves.easeInQuint)));
    animationTwo = new Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: controller,
            curve: Interval(0.7, 1.0, curve: Curves.easeOutQuint)));
    animationThree = new Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, 0.5, curve: Curves.easeOutExpo)));
    animationFour = new Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: controller,
            curve: Interval(0.5, 1.0, curve: Curves.easeOutExpo)));
    controller.addListener(() {
      setState(() {});
    });
    moveUp.addListener(() => setState(() {}));
    moveUp.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    moveUp.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromRGBO(37, 41, 45, 1),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: size.width * 2,
        child: Stack(
          children: [
            Positioned(
              left: controller.value <= 0.5
                  ? -size.width * animation.value
                  : null,
              right: controller.value > 0.5
                  ? -size.width + size.width * animationTwo.value
                  : null,
              top: 70 + 100 * (1 - up.value),
              child: Container(
                width: size.width,
                padding: EdgeInsets.only(left: 18, right: 18),
                child: Center(
                  child: Text(
                    text1[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white.withOpacity(up.value),
                        fontWeight: FontWeight.w500,
                        fontSize: 22),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 110 + 200 * (1 - up.value),
              left: controller.value <= 0.5
                  ? -size.width * animationThree.value
                  : null,
              right: controller.value > 0.5
                  ? size.width * animationFour.value - size.width
                  : null,
              child: Container(
                width: size.width,
                padding: EdgeInsets.only(left: 18, right: 18),
                child: Center(
                  child: Text(
                    text2[index],
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white.withOpacity(up.value * up.value),
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 60 + (1 - up.value) * 100,
                ),
                Center(
                  child: Opacity(
                    opacity: controller.isAnimating ? 0 : 1,
                    child: Container(
                        margin: controller.isAnimating
                            ? EdgeInsets.only(
                                right: size.width * 2 * animation.value)
                            : null,
                        child: widgets[index]),
                  ),
                ),
                Opacity(
                  opacity: up.value,
                  child: Container(
                      padding: EdgeInsets.only(
                          left: 60, right: 60, top: 20, bottom: 20),
                      width: size.width,
                      child: Container(
                        height: 140,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Material(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(30),
                                onTap: () async {
                                  if (index > 0) {
                                    controller.reverse(from: 1.0);
                                    await Future.delayed(
                                        Duration(milliseconds: 500));
                                    setState(() {
                                      index = index - 1;
                                    });
                                  }
                                },
                                child: Container(
                                  child: Icon(
                                    Icons.keyboard_arrow_left,
                                    color: Colors.white,
                                  ),
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(
                                        color: Colors.red, width: 2.0),
                                  ),
                                ),
                              ),
                            ),
                            Material(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(30),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(30),
                                onTap: () async {
                                  if (index < 3) {
                                    controller.reset();
                                    controller.forward();
                                    await Future.delayed(
                                        Duration(milliseconds: 500));
                                    setState(() {
                                      index = index + 1;
                                    });
                                  } else if (index == 3) {
                                    Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                            pageBuilder: (_, a, b) => Home(),
                                            transitionDuration:
                                                Duration(seconds: 0)));
                                  }
                                },
                                child: Container(
                                  child: Icon(
                                    Icons.keyboard_arrow_right,
                                    color: Colors.white,
                                  ),
                                  width: 60,
                                  height: 60,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
