import 'package:flutter/material.dart';

class ProductFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: Colors.blue,
        constraints: BoxConstraints(maxHeight: 48),
        child: Row(
          children: <Widget>[
            Center(),
          ],
        ),
      ),
    );
  }
}
