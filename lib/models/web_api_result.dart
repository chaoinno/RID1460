class WebApiResult {
  var collectionResult;

  WebApiResult({this.collectionResult});

  WebApiResult.fromJson(Map<String, dynamic> json, String collectionName) {
    collectionResult = json[collectionName];
  }

  Map<String, dynamic> toJson(String collectionName) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[collectionName] = this.collectionResult.toJson();
    return data;
  }
}

class CollectionResult {
  String result;
  String msg;

  CollectionResult({this.result, this.msg});

  CollectionResult.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['msg'] = this.msg;
    return data;
  }
}