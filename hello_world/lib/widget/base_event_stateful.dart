import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hello_world/util/util_event.dart';

abstract class EventStateful<T extends StatefulWidget, K> extends State<T> {
  StreamSubscription streamSubscription;

  @override
  void initState() {
    super.initState();
    streamSubscription = registerEvent<K>((data) {
      if (data is K && data != null) {
        doThingsForEvent(data);
      }
    });
  }

  void doThingsForEvent(K data);

  @override
  void dispose() {
    super.dispose();
    streamSubscription.cancel();
  }
}
