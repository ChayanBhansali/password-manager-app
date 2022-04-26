import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_password_generator/random_password_generator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  bool userpassword = false;
TextEditingController platformcontr = new TextEditingController();
TextEditingController usernamecontr = new TextEditingController();
TextEditingController passwordcontr = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(

        decoration: BoxDecoration(
            color: Color(0xff2BC990),
          borderRadius : BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30)
          )


        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Text('Add New Password',
                style: TextStyle(
                  fontFamily: 'Raleway',
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25 , 16,16,0),
              child: Row(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Enter platform name',
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 2, 16, 0),
              child: TextFormField(
                controller: platformcontr,
                decoration: InputDecoration(
                  enabledBorder:  OutlineInputBorder(
                    borderSide:  BorderSide(color: Colors.white38, width: 0.0),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  // labelText: "Enter email",
                  // labelStyle: TextStyle(
                  //   color: Colors.white,
                  // ),
                  hintText: "facebook..",
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w200,
                  )

                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25 , 16,16,0),
              child: Row(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Enter Username',
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 2, 16, 0),
              child: TextFormField(
                controller: usernamecontr,
                decoration: InputDecoration(
                    enabledBorder:  OutlineInputBorder(
                      borderSide:  BorderSide(color: Colors.white38, width: 0.0),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    // labelText: "Enter email",
                    // labelStyle: TextStyle(
                    //   color: Colors.white,
                    // ),
                    hintText: "lukedanes..",
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w200,
                    )

                ),
              ),
            ),
            if(userpassword)
            Padding(
              padding: const EdgeInsets.fromLTRB(25 , 16,16,0),
              child: Row(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Enter Password',
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            if(userpassword)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 2, 16, 0),
                child: TextFormField(
                  obscureText: true,
                  controller: passwordcontr,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.white38, width: 0.0),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      // labelText: "Enter email",
                      // labelStyle: TextStyle(
                      //   color: Colors.white,
                      // ),
                      hintText: "Password..",
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w200,
                      )

                  ),
                ),
              ),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width:  MediaQuery.of(context).size.width*0.45,
                    decoration: BoxDecoration(
                      color:Color(0xf21643e7),
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        setState(() {
                          userpassword = !userpassword;
                        });
                      },
                      child: Text(
                        'Add Password Manually',
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          color: Colors.white,
                          fontSize: 15,

                        ),
                        textAlign: TextAlign.center,

                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width*0.45,
                    decoration: BoxDecoration(
                        color: Color(0xf21643e7),
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        if(platformcontr.text.isNotEmpty && usernamecontr.text.isNotEmpty) {
                          final password = RandomPasswordGenerator();
                          String newPassword = password.randomPassword();
                          passwordcontr.text = newPassword;
                          Fluttertoast.showToast(msg: 'Password Generated');
                          print(passwordcontr.text);
                        }else if(platformcontr.text.isEmpty && usernamecontr.text.isNotEmpty){
                          Fluttertoast.showToast(msg: 'Add Platform name');
                        }else if(platformcontr.text.isNotEmpty && usernamecontr.text.isEmpty){
                          Fluttertoast.showToast(msg: 'Add Username');
                        }else if(platformcontr.text.isEmpty && usernamecontr.text.isEmpty){
                          Fluttertoast.showToast(msg: 'Above entries cannot be empty');
                        }

                      },
                      child: Text(
                        'Auto Generate Password',
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          color: Colors.white,
                          fontSize: 15,

                        ),
                        textAlign: TextAlign.center,

                      ),
                    ),
                  ),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(12)
                ),
                child: MaterialButton(
                  onPressed: () async {
                    if(platformcontr.text.isNotEmpty && usernamecontr.text.isNotEmpty) {
                      addtofirebase adding = new addtofirebase();
                      adding.username = usernamecontr.text;
                      adding.platform = platformcontr.text;
                      adding.password = passwordcontr.text;
                      await adding.addToFirebase();
                    }else if(platformcontr.text.isEmpty && usernamecontr.text.isNotEmpty){
                      Fluttertoast.showToast(msg: 'Add Platform name');
                    }else if(platformcontr.text.isNotEmpty && usernamecontr.text.isEmpty){
                      Fluttertoast.showToast(msg: 'Add Username');
                    }else if(platformcontr.text.isEmpty && usernamecontr.text.isEmpty){
                      Fluttertoast.showToast(msg: 'Above entries cannot be empty');
                    }
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Add ',
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      color: Colors.white,
                      fontSize: 22,

                    ),
                    textAlign: TextAlign.center,

                  ),
                ),
              ),
            ),

          ],
        ),
    );
  }
}
class addtofirebase {
String platform = '';
String username = ' ';
String password = '';
  addToFirebase() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user =  await auth.currentUser;
    String? uid = user?.uid ;
    var time = DateTime.now();
    await FirebaseFirestore.instance
        .collection('password')
        .doc(uid)
        .collection('mypassword')
        .doc(time.toString())
        .set({
      'platform': platform,
      'username': username,
      'time': time.toString(),
      'timestamp': time,
      'password' : password,
    });
    Fluttertoast.showToast(msg: 'Added Successfully!');

  }

}