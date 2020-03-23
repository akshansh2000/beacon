import 'package:flutter/material.dart';

import '../screens/room_screen/bloc.dart';

class MemberListContainer extends StatelessWidget {
  const MemberListContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    var members = List<ListTile>();
    bloc.roomDetails.forEach((key, value) {
      if (key != "expiry")
        members.add(
          ListTile(
            title: Text(
              value["name"],
              style: textTheme.button.copyWith(color: Colors.black),
            ),
            trailing: value["mode"] == "host"
                ? Icon(
                    Icons.location_on,
                    color: Colors.redAccent,
                  )
                : null,
            onTap: () {},
          ),
        );
    });

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
          child: Padding(
            padding: EdgeInsets.all(30),
            child: ListView(
              children: members,
            ),
          ),
        ),
      ),
    );
  }
}
