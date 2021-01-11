class ServiceCaseDetail {
  var getServiceDetailResult;

  ServiceCaseDetail({this.getServiceDetailResult});

  ServiceCaseDetail.fromJson(Map<String, dynamic> json) {
    getServiceDetailResult = json['getServiceDetailResult'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['getServiceDetailResult'] = this.getServiceDetailResult.toJson();
    return data;
  }
}

class GetServiceDetailResult {
  var service;
  var lsAttach;
  String result;
  String msg;

  GetServiceDetailResult({this.service, this.lsAttach, this.result, this.msg});

  GetServiceDetailResult.fromJson(Map<String, dynamic> json) {
    service = json['service'];
    lsAttach = json['lsAttach'];
    result = json['result'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service'] = this.service;
    data['lsAttach'] = this.lsAttach;
    data['result'] = this.result;
    data['msg'] = this.msg;
    return data;
  }
}

class LsAttach {
  String id;
  String name;
  String description;
  String type;
  String newname;
  String remark;

  LsAttach(
      {this.id,
      this.name,
      this.description,
      this.type,
      this.newname,
      this.remark});

  LsAttach.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    type = json['type'];
    newname = json['newname'];
    remark = json['remark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['type'] = this.type;
    data['newname'] = this.newname;
    data['remark'] = this.remark;
    return data;
  }
}
