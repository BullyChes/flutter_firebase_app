import 'package:flutter/material.dart';
import 'package:flutter_app/models/user.dart';

class Body extends StatelessWidget {
  final User user;
  Body({@required this.user});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0, -1 / 3),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(user.email),
          const SizedBox(height: 4.0),
        ],
      ),
    );
  }
}
