import 'package:flutter/material.dart';

class CommonScreen extends StatefulWidget {
  CommonScreen({
    Key key,
    @required this.color,
    @required this.tag,
  }) : super(key: key);

  final Color color;
  final String tag;

  @override
  _CommonScreenState createState() => _CommonScreenState();
}

class _CommonScreenState extends State<CommonScreen> {
  Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Scaffold(
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
                width: size.width / 1.2,
                height: size.height / 1.2,
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
