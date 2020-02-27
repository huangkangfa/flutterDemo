class ResultData {
  var result;
  bool success;
  int code;
  String error;
  var headers;

  ResultData(this.result, this.success, this.code,this.error,{this.headers});

}