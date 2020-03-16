import 'package:flutter/material.dart';

class CommonContainer extends StatelessWidget {
  const CommonContainer({
    @required this.heightFactor,
    @required this.color,
    @required this.child,
    Key key,
  }) : super(key: key);

  final double heightFactor;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Center(
      child: Container(
        width: size.width / 1.1,
        height: size.height / heightFactor,
        decoration: BoxDecoration(
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(20),
        ),
        child: child,
      ),
    );
  }
}
