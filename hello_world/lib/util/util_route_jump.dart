import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

push(BuildContext context, route) {
  return Navigator.push(context,
      new MaterialPageRoute(builder: (BuildContext context) {
    return route;
  }));
}

pop<T>(BuildContext context, {T obj}) {
  if (Navigator.canPop(context)) {
    if (obj != null) {
      return Navigator.pop(context, obj);
    }
    return Navigator.pop(context);
  }
  return false;
}

reset(BuildContext context, route) {
  return Navigator.of(context)
      .pushReplacement(new MaterialPageRoute(builder: (BuildContext context) {
    return route;
  }));
}

///...未完
