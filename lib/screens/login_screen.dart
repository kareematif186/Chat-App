import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/roundedbutton.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'chat_screen.dart';

class LoginScreen extends StatefulWidget {

  static String id='login_screen';


  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  final _auth =FirebaseAuth.instance;
  bool showSpinner =false;
  String email;
  String password;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.black54,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 300.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(

                onChanged: (value) {
                  email=value;
                  //Do something with the user input.
                },


                  ///////////////////////////////copywith
                decoration:kTextFiledDecoration.copyWith(hintText: 'Enter ur email')
                //copy with means to change just something in a function u did not map it


              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                onChanged: (value) {
                  password=value;
                  //Do something with the user input.
                },


                  ///////////////////////////////copywith
                  decoration:kTextFiledDecoration.copyWith(hintText: 'Enter ur password')
                //copy with means to change just something in a function u did not map it


              ),
              SizedBox(
                height: 24.0,
              ),

              RoundedButton( title: 'Log In',color: Colors.red ,

                  onPressed: () async{
                    setState(() {
                      showSpinner=true;
                    });

                try {
                  final newUser = await _auth.signInWithEmailAndPassword(email: email, password: password);

                  if(newUser!=null){
                    Navigator.pushNamed(context, ChatScreen.id);
                  }
                  setState(() {
                    showSpinner=false;
                  });
                }
                catch(e){
                  print(e);
                }









              }),
            ],
          ),
        ),
      ),
    );
  }
}
