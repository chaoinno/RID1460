class Broadcast {
  GetBroadcastResult getBroadcastResult;

  Broadcast({this.getBroadcastResult});

  Broadcast.fromJson(Map<String, dynamic> json) {
    getBroadcastResult = json['getBroadcastResult'] != null
        ? new GetBroadcastResult.fromJson(json['getBroadcastResult'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.getBroadcastResult != null) {
      data['getBroadcastResult'] = this.getBroadcastResult.toJson();
    }
    return data;
  }
}

class GetBroadcastResult {
  List<BoardcastList> list;
  String result;
  String msg;

  GetBroadcastResult({this.list, this.result, this.msg});

  GetBroadcastResult.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = new List<BoardcastList>();
      json['list'].forEach((v) {
        list.add(new BoardcastList.fromJson(v));
      });
    }
    result = json['result'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    data['result'] = this.result;
    data['msg'] = this.msg;
    return data;
  }
}

class BoardcastList {
  String id;
  String title;
  String detail;

  BoardcastList({this.id, this.title, this.detail});

  BoardcastList.fromJson(Map<String, dynamic> json) {
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