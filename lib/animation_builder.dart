import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimationBuilderPage extends StatefulWidget {
  @override
  _AnimationBuilderPageState createState() => _AnimationBuilderPageState();
}

class _AnimationBuilderPageState extends State<AnimationBuilderPage> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: Duration(seconds: 5),
        vsync: this
    );

    final curvedAnimation = CurvedAnimation(
        parent: animationController,
        curve: Curves.bounceIn,
        reverseCurve: Curves.easeOut
    );

    animation = Tween<double>(
        begin: 0,
        end: 2* math.pi
    ).animate(curvedAnimation)
    /*..addListener(() {
        setState(() {});
      })*/
      ..addStatusListener((status) {
        if(status == AnimationStatus.completed) {
          animationController.reverse();
        } else if(status == AnimationStatus.dismissed) {
          animationController.forward();
        }
      });
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RotatingTransition(
            angle: animation,
            child: IrisImage()
        )
    );
  }
}

class RotatingTransition extends StatelessWidget {

  final Widget child;
  final Animation<double> angle;

  RotatingTransition({
    @required this.angle,
    @required this.child
});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: angle,
      child: child,
      builder: (context, child) {
        return Transform.rotate(
          angle: angle.value,
          child: child
        );
      },
    );
  }
}


class IrisImage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(20),
        child: Image.asset('assets/fb_iris.png')
    );
  }
}

