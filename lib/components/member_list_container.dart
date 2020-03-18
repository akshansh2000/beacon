import 'package:flutter/material.dart';

class MemberListContainer extends StatelessWidget {
  const MemberListContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: size.width,
        height: size.height / 2.5,
        child: Material(
          elevation: 10,
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(50),
          ),
        ),
      ),
    );
  }
}
