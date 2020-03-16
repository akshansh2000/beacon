import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({
    @required this.title,
    @required this.textEditingController,
    @required this.onTap,
    Key key,
  }) : super(key: key);

  final String title;
  final TextEditingController textEditingController;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Column(
        children: <Widget>[
          Spacer(flex: 2),
          Text(
            title,
            textAlign: TextAlign.center,
            style: textTheme.headline,
          ),
          Spacer(flex: 3),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Material(
              color: Colors.transparent,
              child: TextFormField(
                textAlign: TextAlign.center,
                style: textTheme.button,
                controller: textEditingController,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          Spacer(),
          Material(
            color: Colors.transparent,
            child: IconButton(
              icon: Icon(
                Icons.check,
                size: 40,
              ),
              onPressed: onTap,
            ),
          ),
          Spacer(flex: 2),
        ],
      ),
    );
  }
}
