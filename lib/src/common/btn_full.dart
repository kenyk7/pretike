import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BtnFull extends StatelessWidget {
  const BtnFull({
    Key? key,
    required this.title,
    this.color = Colors.blue,
    this.onPressed,
  }) : super(key: key);
  final String title;
  final Color color;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 15),
      child: CupertinoButton(
        color: color,
        borderRadius: BorderRadius.circular(30),
        onPressed: onPressed,
        child: Text(
          title,
        ),
      ),
    );
  }
}
