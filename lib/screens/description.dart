import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recase/recase.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';


class Description extends StatefulWidget {
  final platform;
  final username;
  final password;
  final time;
  final uid;
  const Description({Key? key, required this.platform,required this.username,required this.uid ,required this.password,required this.time}) : super(key: key);

  @override
  _DescriptionState createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {



  @override
  Widget build(BuildContext context) {
    ReCase platform = new ReCase(widget.platform);
    return Scaffold(
      backgroundColor: Color(0xffc5c1f5),
      appBar: AppBar(
        backgroundColor: Color(0xff190e9c),
        title: Text(platform.titleCase + ' details',
        style: TextStyle(
          fontFamily: 'Raleway',
          fontSize: 20
        ),
        ),
      ),
        body: SafeArea(
            child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height*0.07,
                      decoration: BoxDecoration(
                          color: Color(0xffb7ceeb),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.black,
                              width: 1.2)

                      ),
                      child: Row(

                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Username:',
                              style: TextStyle(
                                  fontFamily: 'Raleway',
                                  fontSize: 18
                              ),),
                          ),
                          Text(widget.username,
                            style: TextStyle(
                                fontFamily: 'Raleway',
                                fontSize: 18
                            ),),
                          Spacer(),
                          IconButton(onPressed: (){
                            Clipboard.setData(ClipboardData(text: widget.username));
                            Fluttertoast.showToast(msg: 'username added to cliboard');

                          }, icon: Icon(Icons.copy))
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height*0.07,
                      decoration: BoxDecoration(
                          color: Color(0xffb7ceeb),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.black,
                              width: 1.2)

                      ),
                      child: Row(

                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Password:',
                            style: TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 18
                            ),),
                          ),
                          Text(widget.password,
                            style: TextStyle(
                                fontFamily: 'Raleway',
                                fontSize: 18
                            ),),
                          Spacer(),
                          IconButton(onPressed: (){
                            Clipboard.setData(ClipboardData(text: widget.password));
                            Fluttertoast.showToast(msg: 'password added to cliboard');
                          }, icon: Icon(Icons.copy))
                        ],
                      ),
                    ),
                  ),
             Padding(
               padding: const EdgeInsets.all(16.0),
               child: Container(
                 height: 50,
                 width: 210,
                 decoration: BoxDecoration(
                   color: Color(0xffb7ceeb),
                   borderRadius: BorderRadius.circular(15),
                     border: Border.all(color: Colors.black,
                     width: 1.2)

                 ),
                 child: MaterialButton(onPressed: () async{
                     await FirebaseFirestore.instance
                      .collection('password')
                     .doc(widget.uid)
                   .collection('mypassword')
                     .doc(widget.time.toString())
                      .delete();
                    Navigator.pop(context);
                   },
                           child: Row(
                             children: [
                               Text('Delete these details',style: TextStyle(
                                 fontFamily: 'Raleway',
                                 fontSize: 15
                               ),),
                               Spacer(),
                               Icon(Icons.delete),
                             ],
                           ),
                    ),
               ),
             ),

    ],
  ),
),
    );
  }
}
