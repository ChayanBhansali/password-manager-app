import 'package:flutter/material.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff190e9c),
    appBar:AppBar(
      backgroundColor: Color(0xff0A0171),
      title: Text('hello user',
        style: TextStyle(
          fontFamily: 'Raleway',
          color: Colors.white,
          fontSize: 22,
        ),
      ),
    ),
    );
  }
}
