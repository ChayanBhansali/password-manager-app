import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:recase/recase.dart';
import 'package:su_task7/screens/description.dart';
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
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        firebaseison = true;
      }
    } on SocketException catch (_) {
     firebaseison = false;
    }
    setState(() {
      uid = user?.uid;
    });
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
      body: Container(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    padding: EdgeInsets.all(5),
        child: StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance
            .collection('password')
            .doc(uid)
            .collection('mypassword')
            .snapshots(),
        builder: (context ,snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              };
              final doc = snapshot.data?.docs;

              return ListView.builder(
              itemCount: doc?.length,
                itemBuilder: (context, index){
                  var time = (doc![index]['timestamp'] as Timestamp).toDate();
                  ReCase sample = new ReCase(doc[index]['platform']);
                  return InkWell(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>Description(
                            password: doc[index]['password'],
                            platform: doc[index]['platform'],
                            time: doc[index]['time'],
                            username: doc[index]['username'],
                            uid: doc[index]['uid'],
                          )));
                      },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height*0.125,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color(0xffe30569),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(sample.titleCase,
                            style: TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 30
                            ),
                          ),
                        ),
                      ),
                    )
                  );
                },

              );
        },
        
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        showModalBottomSheet(context: context, builder: (context) {
          return AddTask();
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),


        );
      },
      child: Icon(Icons.add),
      ),
    );
  }
}
