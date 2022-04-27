import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool isLoginPage = false ;
  signin(String email , String password) async{
    final auth = FirebaseAuth.instance;
    Center(child: CircularProgressIndicator());
    try {
      if(!isLoginPage) {
        UserCredential userCredential = await auth
            .createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        String? uid = userCredential.user?.uid;
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .set({'email': email});
        print('done');
      }else{
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,

        );
      }
    }catch(e){
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    double weigh = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xff0A0171),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding:  EdgeInsets.fromLTRB(weigh*0.5 - 88.5, 90, weigh*0.5 - 88.5, .0),
              child: Image.asset('assets/image.png'),
            ),
            SizedBox(height: 40,),
             Center(
               child: Text('Welcome!',
                style: TextStyle(
                      fontFamily: 'Raleway',
                      color: Colors.white,
                      fontSize: 24,
                ),

                ),
             ),

SizedBox(height: 25,),
             Center(
               child: isLoginPage? Text( 'Login into your personal password manager :)',
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w300
                  ),
                ):  Text( 'Sign in into your personal password manager :)',
                 style: TextStyle(
                     fontFamily: 'Raleway',
                     color: Colors.white,
                     fontSize: 16,
                     fontWeight: FontWeight.w300
                 ),
               ),
             ),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 25, 16, 20),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,

                key: ValueKey('password'),
                validator: (value) {
                  if (value?.isEmpty ?? false ){
                    print('Email cannot be empty');
                  }else {
                    return null;
                  };
                },

                controller: emailController,
                decoration: InputDecoration(
                  enabledBorder:  OutlineInputBorder(
                    borderSide:  BorderSide(color: Colors.white, width: 0.0),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  labelText: "Enter email",
                  labelStyle: TextStyle(
                      color: Colors.white,
                  ),

                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
              child: TextFormField(
                obscureText: true,
                key: ValueKey('password'),
                validator: (value) {
                  if (value?.isEmpty ?? false ){
                   print('Password cannot be empty');
                  }else {
                    return null;
                  };
                },


                controller: passwordcontroller ,
                decoration: InputDecoration(
                  enabledBorder:  OutlineInputBorder(
                    borderSide:  BorderSide(color: Colors.white, width: 0.0),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  labelText: "Enter Password",
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),

                ),
              ),
              
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
              child: Container(
                width: weigh,
                height : 58,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color(0xff2BC990),
                ),
                child: MaterialButton(
                  onPressed: (){
                   signin(emailController.text, passwordcontroller.text);
print(passwordcontroller.text);
                  },
                  child: Text(isLoginPage? 'Login':'Sign In',
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              child: TextButton(onPressed: () {
                setState(() {
                  isLoginPage = !isLoginPage;
                });
              },child: isLoginPage? Text('Not a member?') : Text('Already a member?'),),)
          ],
        ),
      ),
    );
  }
}
