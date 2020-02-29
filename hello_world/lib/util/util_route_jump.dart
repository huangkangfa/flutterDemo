import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

push(BuildContext context, route) {
  Navigator.push(context,
      new MaterialPageRoute(builder: (BuildContext context) {
        return route;
      }));
}

pop(BuildContext context){
  Navigator.pop(context);
}

///...未完