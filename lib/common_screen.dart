import 'package:flutter/material.dart';

GlobalKey<ScaffoldState> scaffoldState;

class CommonScreen extends StatefulWidget {
  CommonScreen({
    Key key,
    @required this.color,
    @required this.tag,
    this.child,
  }) : super(key: key);

  final Color color;
  final String tag;
  final Widget child;

  @override
  _CommonScreenState createState() => _CommonScreenState();
}

class _CommonScreenState extends State<CommonScreen> {
  Size size;

  _CommonScreenState() {
    scaffoldState = GlobalKey<ScaffoldState>();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Scaffold(
      key: scaffoldState,
      body: Stack(
        children: <Widget>[
          Center(
            child: Hero(
              tag: widget.tag,
              child: Container(
                decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: BorderRadius.circular(20),
                ),
                width: size.width / 1.1,
                height: size.height / 1.2,
                child: widget.child,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.all(15),
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
