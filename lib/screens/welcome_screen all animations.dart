import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen2 extends StatefulWidget {

  static String id='welcome_screen2';

  @override
  _WelcomeScreen2State createState() => _WelcomeScreen2State();
}

class _WelcomeScreen2State extends State<WelcomeScreen2> with TickerProviderStateMixin {
  AnimationController controller;
  Animation animation;


  AnimationController controller2;


  AnimationController controller3;
  Animation animation2;



  @override
  void initState() {


    // TODO: implement initState
    super.initState();

    controller=AnimationController(
      duration: Duration(seconds: 10),
        vsync: this,
        //upperBound: 100
    );

    controller2=AnimationController(
      duration: Duration(seconds: 10),
      vsync: this,
      upperBound: 100
    );


    controller3=AnimationController(
        duration: Duration(seconds: 10),
        vsync: this,
        upperBound: 100
    );



    animation=CurvedAnimation(parent: controller, curve:Curves.decelerate);
    controller.forward();
    animation.addStatusListener((status) {
      print(status);
      if(status ==AnimationStatus.completed){
        controller.reverse(from: 1.0);
      }
      else if(status ==AnimationStatus.dismissed){
        controller.forward();
      }
    });

    controller.addListener(() {
      setState(() {});
     // print(controller.value);
      print(animation.value);
    });



    //controller2//////////////////////////////////////////////////////////////////////////////////
    controller2.forward();
    controller2.addListener(() {
      setState(() {});
      // print(controller.value);
      print(controller2.value);
    });


    //animation scafold///////////////////////////////////////////

    animation2=ColorTween(begin: Colors.black, end: Colors.white).animate(controller3);
    controller3.forward();
    controller3.addListener(() {
      setState(() {});
      // print(controller.value);
      print(animation2.value);
    });



  }


  //destroy the animation because it takes resourses
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
    controller2.dispose();
    controller3.dispose();
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //backgroundColor: Colors.red.withOpacity(controller.value),
      backgroundColor: animation2.value,



      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  child: Image.asset('images/logo.png'),

                  // height: controller.value,
                  height: animation.value*100,
                  //height: 60,

                ),

      AnimatedTextKit(
                    animatedTexts: [
                       TyperAnimatedText('Flash Chat', textStyle: TextStyle(
                           fontSize: 20.0,
                           fontWeight: FontWeight.w900,
                           color: Colors.black54
                       ),
                       speed: Duration(seconds: 1),

                       ),

               ]
      ),



              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                elevation: 5.0,
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  onPressed: () {
                    //Go to login screen.

                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Log In',
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(30.0),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () {
                    //Go to registration screen.

                    Navigator.pushNamed(context, RegistrationScreen.id);
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Register',
                  ),


                ),
              ),
            ),



            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child:
              Row(
                children: <Widget>[

              Hero(
              tag: 'logo',
                child: Container(
                  child: Image.asset('images/logo.png'),

                   height: controller2.value,

                ),
              ),
              Text(
                'Flash Chat ${controller2.value.toInt() }%',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w900,
                    color: Colors.black54
                ),
              ),
              ],



            ),
            ),
          ],
        ),
      ),
    );
  }
}
