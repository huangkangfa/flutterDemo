import 'dart:async';

import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

///注册事件
StreamSubscription registerEvent<T>(Function callback) {
  StreamSubscription streamSubscription = eventBus.on<T>().listen((event) {
    callback(event);
  });
  return streamSubscription;
}

///发送事件
sendEvent<T>(T obj) {
  eventBus.fire(obj);
}
