import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recase/recase.dart';
import 'package:su_task7/screens/description.dart';
import '../utils/addtask.dart';
class firebasebody extends StatefulWidget {
  final String uid;
  const firebasebody({Key? key, required this.uid}) : super(key: key);

  @override
  _firebasebodyState createState() => _firebasebodyState();
}

class _firebasebodyState extends State<firebasebody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color: Color(0xff190e9c),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(5),
      child: StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance
          .collection('password')
          .doc(widget.uid)
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
