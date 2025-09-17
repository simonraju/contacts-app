import 'package:flutter/material.dart';
import 'package:flutter_animations/animated_screen.dart';
import 'package:flutter_animations/model.dart';

class ListviewAnimation extends StatefulWidget {
  const ListviewAnimation({super.key});

  @override
  State<ListviewAnimation> createState() => _ListviewAnimationState();
}

class _ListviewAnimationState extends State<ListviewAnimation> {

  double width = 0;
  bool myAnimation = false;
  @override
  void initState(){
     super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        myAnimation = true;

      });
    },);
  }
   @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return  Scaffold(
      backgroundColor: Color.fromARGB(255, 33, 33, 33),
      body: SafeArea(
        child: ListView(
           physics: ClampingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 10),
          children: [
            Center(
              child: Text("List view Animation", style: TextStyle(
                fontWeight: FontWeight.bold, 
                color: Colors.white, 
                fontSize: 25),) ,
            ),
            SizedBox(height: 20,),
            ListView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: users.length,
              
              itemBuilder: (context, index ){
                final myUser = users[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: AnimatedContainer(
                  decoration: BoxDecoration(  
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  duration: Duration(milliseconds: 100 + (index *250)),
                  curve: Curves.fastOutSlowIn,
                  transform: Matrix4.translationValues(myAnimation?0:width, 0, 0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundImage: NetworkImage(myUser.image ),
                        ),
                        SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        
                            Text(
                              myUser.name, 
                              style: TextStyle(
                                fontSize: 18, 
                                fontWeight: FontWeight.bold, 
                                ),),
                  
                                Text(
                                  myUser.userName,
                                ),
                  
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
                SizedBox(height: 50),
              
          ],
        )
      ),


        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => AnimatedScreen(),

                 transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return RotationTransition(
                  turns: animation,
                  child: ScaleTransition(
                    scale: animation,
                    child: child,
                  ));
                }
                  ));
                },
          child: Icon(Icons.add), 
          backgroundColor: Colors.blue, 
        ),
    );
  }
}