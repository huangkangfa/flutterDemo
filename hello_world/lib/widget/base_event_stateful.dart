import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hello_world/util/util_event.dart';

abstract class EventStateful<T extends StatefulWidget, K> extends State<T>
    with WidgetsBindingObserver {
  StreamSubscription streamSubscription;
  AppLifecycleState lastLifecycleState;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    streamSubscription = registerEvent<K>((data) {
      if (data is K && data != null) {
        doThingsForEvent(data);
      }
    });
  }

  void doThingsForEvent(K data);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    lastLifecycleState = state;
    //需要用到原生生命周期可以重写这个方法
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    streamSubscription.cancel();
  }
}
