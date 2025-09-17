import 'package:flutter/material.dart';
import 'package:flutter_animations/hero_animation.dart';
import 'package:animations/animations.dart';

class AnimatedScreen extends StatefulWidget {
  const AnimatedScreen({super.key});

  @override
  State<AnimatedScreen> createState() => _AnimatedScreenState();
}

class _AnimatedScreenState extends State<AnimatedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Animated widget"),),
      body: Center(
        child: Text("animated screen"),

        
      ),




       floatingActionButton: FloatingActionButton(
          onPressed: () {
           Navigator.of(context).push(
  PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => HeroAnimation(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeThroughTransition(
        animation: animation,
        secondaryAnimation: secondaryAnimation,
        child: child,
      );
    },
  ),
);
          },
          child: Icon(Icons.add), 
          backgroundColor: Colors.blue, 
        ),
    );
  }
}