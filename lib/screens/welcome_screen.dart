import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';

import '../components/roundedbutton.dart';

class WelcomeScreen extends StatefulWidget {

  static String id='welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with TickerProviderStateMixin {
  AnimationController controller;
  Animation animation;





  @override
  void initState() {

    // TODO: implement initState
    super.initState();

    controller=AnimationController(
      duration: Duration(seconds: 2),
        vsync: this,
        //upperBound: 100
    );

    animation=ColorTween(begin: Colors.blueAccent, end: Colors.white).animate(controller);



    controller.forward();
        controller.addListener(() {
      setState(() {});
     // print(controller.value);

    });




        //make user log in always--------------







  }


  //destroy the animation because it takes resourses
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();



  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(


      //backgroundColor: Colors.red.withOpacity(controller.value),

      //impotant-----------------------------
      //backgroundColor: animation.value,

      backgroundColor: Colors.white,




      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            Column(
              children: [
                SizedBox(
                  width: 250.0,
                  child: TextLiquidFill(
                    text: 'Flash',
                    waveColor: Colors.red,
                    boxBackgroundColor: Colors.white,
                    textStyle: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow
                    ),
                    boxHeight:45.0,
                    loadDuration: Duration(seconds: 10),


                  ),
                )


              ],




            ),
            SizedBox(height: 30,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      child: Image.asset('images/logo.png'),

                      // height: controller.value,
                      height: 170,
                      //height: 60,

                    ),
                  ),
                ),
/*

        SizedBox(
          width: 250.0,
          child: TextLiquidFill(
            text: 'Rumsh❤️Kimoo',
            waveColor: Colors.red,
            boxBackgroundColor: Colors.white,
            textStyle: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              color: Colors.black
            ),
            boxHeight:70.0,

          ),
        )

 */
/*
      AnimatedTextKit(
                    animatedTexts: [

                       TyperAnimatedText('Flash Chat_', textStyle: TextStyle(
                           fontSize: 35,
                           fontWeight: FontWeight.w900,
                           color: Colors.black,
                         fontFamily: 'Canterbury',
                       ),
                       //speed: Duration(seconds: 1),

                       ),

               ]
      ),

 */



              ],
            ),
            SizedBox(
              height: 48.0,
            ),


            RoundedButton(title: 'Login', color: Colors.red, onPressed: (){

              Navigator.pushNamed(context, LoginScreen.id);
            },),
            RoundedButton(title: 'Register', color: Colors.red, onPressed: (){
              Navigator.pushNamed(context, RegistrationScreen.id);
            },

            ),
                    //Go to registration screen.






          ],
        ),
      ),
    );
  }
}

