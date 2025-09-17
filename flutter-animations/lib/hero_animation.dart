import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';

class HeroAnimation extends StatefulWidget {
  const HeroAnimation({super.key});

  @override
  State<HeroAnimation> createState() => _HeroAnimationState();
}

class _HeroAnimationState extends State<HeroAnimation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hero Animation"),),

      body: Container(
        color: Colors.black,
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20,),
              AnimatedButton(
                backgroundColor: Colors.blue,
                height: 60,
                width: 200,
               
                
                onPress: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("AnimatedButton Pressed!")),
                  );
                }, text:  
                  "Press Me",
                  textStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                
                ),
              ),
          SizedBox(height: 20,),
              AnimatedButton(
                  width: 200,
                  height: 60,
                  borderRadius: 50,
                  text: 'SUBMIT',
                  selectedTextColor: Colors.black,
                  transitionType: TransitionType.	CENTER_ROUNDER,
                  textStyle: TextStyle(
                      fontSize: 28,
                      letterSpacing: 5,
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.w300), onPress: () {  },
                ),

                SizedBox(height: 20,),
                
            ],
          ),
          
        ),
      )
        
        
    );
  }
}