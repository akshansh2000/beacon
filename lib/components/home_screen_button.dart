import 'package:flutter/material.dart';

class HomeScreenButton extends StatelessWidget {
  const HomeScreenButton({
    @required this.text,
    @required this.color,
    @required this.route,
    @required this.tag,
    Key key,
  }) : super(key: key);

  final String text;
  final Color color;
  final String route;
  final String tag;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Hero(
        tag: tag,
        child: Container(
          width: size.width / 3,
          height: size.width / 3,
          decoration: BoxDecoration(
            border: Border.all(color: color),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Material(
            color: theme.buttonColor,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              highlightColor: color,
              child: Center(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: textTheme.button,
                ),
              ),
              onTap: () => Navigator.of(context).pushNamed(route),
            ),
          ),
        ),
      ),
    );
  }
}
