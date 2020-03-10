import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            AnimatedContainer(
              duration: Duration(
                milliseconds: 500,
              ),
              width: size.width / 4,
              height: size.width / 4,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(500),
              ),
              child: Center(child: Text("HOST")),
            ),
            AnimatedContainer(
              duration: Duration(
                milliseconds: 500,
              ),
              width: size.width / 4,
              height: size.width / 4,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(500),
              ),
              child: Center(child: Text("TRACK")),
            ),
          ],
        ),
      ),
    );
  }
}
