import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';

final _firestore =FirebaseFirestore.instance;
User LoggedInUser ;

class ChatScreen extends StatefulWidget {

  static String id='chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final messageTexrController =TextEditingController();
  final _auth =FirebaseAuth.instance;

  String messageText;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getCurrentUser();

  }


  void getCurrentUser()async{

    try {
      final user = await _auth.currentUser;

      if (user != null) {
        LoggedInUser = user;

        //print(LoggedInUser.email);
      }
    }catch(e){
      print(e);
    }

  }
/*

// not listen immedialty to firebase
_____________________________________________
  void getMessages()async{
    final messages=await _firestore.collection('messages').get();
    for( var message in messages.docs ){
      print(message.data());
    }
}

 */

  //listen immedialtly to changes to firebase // not used
  //______________________________________________

  void messagesStream() async{
   await for(var snapshot in _firestore.collection('messages').snapshots()){
     for( var message in snapshot.docs ){
     //  print(message.data());
     }
    }

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      appBar: AppBar(

        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
                //Implement logout functionality
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.red,
      ),
      body: SafeArea(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

           MessagesStream(),

            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTexrController,
                      onChanged: (value) {

                        messageText=value;
                        //Do something with the user input.
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),

                  TextButton(

                    onPressed: () {
                      messageTexrController.clear();
                      _firestore.collection('messages').add({
                      'text':messageText,
                        'sender':LoggedInUser.email,
                        'date': DateTime.now().toIso8601String().toString(),


                      });


                      //Implement send functionality.
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
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

class MessagesStream extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').orderBy('date').snapshots(),
      builder: (context, snapshot){

        if(!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.red,

            ),
          );

        }
        final messages =snapshot.data.docs.reversed;
        List<MessageBubble>messageBubbles=[];
        for(var message  in messages) {

          final messageText =message.data() as Map ;
          final messageText1 = messageText['text'];

          print(messageText1);

          final messageSender= message.data() as Map;
          final messageSender1 = messageSender['sender'];

          final currentUser = LoggedInUser.email;



          final messageBubble = MessageBubble(

              sender: messageSender1,
              text: messageText1,
            isMe: currentUser==messageSender1,

          );
          messageBubbles.add(messageBubble);

        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10 ,vertical: 20),
            children: messageBubbles,

          ),
        );

      },

    );
  }
}




class MessageBubble extends StatelessWidget {

  MessageBubble({this.sender , this.text , this.isMe});
final String sender;
final String text;
final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0.01 , top: 6),
      child: Column(
        crossAxisAlignment: isMe? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget> [

          //Text( sender , style: TextStyle(fontSize: 8.0, color: Colors.black,),),
          //Text( '' , style: TextStyle(fontSize: 1, color: Colors.black,),),


          Material(
            borderRadius:  isMe ? BorderRadius.only(topLeft: Radius.circular((30.0)) ,
                bottomLeft: Radius.circular(30) ,
                bottomRight: Radius.circular(30))

            : BorderRadius.only(topRight: Radius.circular((30.0)) ,
                bottomLeft: Radius.circular(30) ,
                bottomRight: Radius.circular(30)),

              color: isMe ? Colors.red : Colors.black12,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10 ,horizontal: 20),
                child: Text('$text' ,
                  style: TextStyle(
                      fontSize: 15,
                    color: isMe? Colors.white : Colors.black,

                  ),
                ),
              )
          ),
        ],
      ),

    );
  }
}




