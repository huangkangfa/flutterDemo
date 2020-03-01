import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

push(BuildContext context, route) {
  Navigator.push(context,
      new MaterialPageRoute(builder: (BuildContext context) {
    return route;
  }));
}

pop(BuildContext context) {
  Navigator.pop(context);
}

reset(BuildContext context, route) {
  Navigator.of(context)
      .pushReplacement(new MaterialPageRoute(builder: (BuildContext context) {
    return route;
  }));
}

///...未完
