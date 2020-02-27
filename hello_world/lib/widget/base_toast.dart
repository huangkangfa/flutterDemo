import 'package:fluttertoast/fluttertoast.dart';

cancelToast(){
  Fluttertoast.cancel();
}

showToast(msg){
  cancelToast();
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      fontSize: 16.0
  );
}