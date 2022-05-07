import 'dart:io';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recase/recase.dart';
import 'package:su_task7/screens/description.dart';
import 'package:su_task7/screens/login.dart';
import 'package:su_task7/utils/firebasescreen.dart';
import 'package:su_task7/utils/notelist.dart';
import '../utils/addtask.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late bool firebaseison;
  String? uid = '';
  void initState() {
    getuid();
    super.initState();
  }
  getuid() async{
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = await auth.currentUser;
      setState(() {
      uid = user?.uid;
    });
  }
  getconnectivity() async{
    bool result = await InternetConnectionChecker().hasConnection;
    if(result == true) {
      setState(() {
        firebaseison = true;
      });
    } else {
     setState(() {
       firebaseison = false;
     });

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff190e9c),
    appBar:AppBar(
      backgroundColor: Color(0xff0A0171),
      title: Text('hello there',
        style: TextStyle(
          fontFamily: 'Raleway',
          color: Colors.white,
          fontSize: 22,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.logout),
          onPressed: () {
            FirebaseAuth.instance.signOut();
          },
        )
      ],
    ),
      body: StreamBuilder(
        stream: InternetConnectionChecker().onStatusChange,
        builder: (context, usersnapshot) {
          if (usersnapshot.connectionState == ConnectionState.waiting) {
            // print(usersnapshot);
            return firebasebody(uid: uid!,);
          } else {
            print(usersnapshot);
            return NoteList();
          }
        },
      ),

    );
  }
}
