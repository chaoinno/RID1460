class Broadcast {
  var getBroadcastResult;

  Broadcast({this.getBroadcastResult});

  Broadcast.fromJson(Map<String, dynamic> json) {
    getBroadcastResult = json['getBroadcastResult'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['getBroadcastResult'] = this.getBroadcastResult;
    return data;
  }
}

class GetBroadcastResult {
  var list;
  String result;
  String msg;

  GetBroadcastResult({this.list, this.result, this.msg});

  GetBroadcastResult.fromJson(Map<String, dynamic> json) {
    list = json['list'];
    result = json['result'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['list'] = this.list;
    data['result'] = this.result;
    data['msg'] = this.msg;
    return data;
  }
}

class BroadcastList {
  String id;
  String title;
  String detail;

  BroadcastList({this.id, this.title, this.detail});

  BroadcastList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    detail = json['detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['detail'] = this.detail;
    return data;
  }
}
