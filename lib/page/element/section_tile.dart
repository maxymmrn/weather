import 'package:flutter/material.dart';

class SectionTile extends StatelessWidget {

  SectionTile({this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        text,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

}