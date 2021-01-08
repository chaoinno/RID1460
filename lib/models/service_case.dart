class ServiceCase {
  var getAllServiceResult;

  ServiceCase({this.getAllServiceResult});

  ServiceCase.fromJson(Map<String, dynamic> json) {
    getAllServiceResult = json['getAllServiceResult'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['getAllServiceResult'] = this.getAllServiceResult.toJson();
    return data;
  }
}

class GetAllServiceResult {
  var list;
  String result;
  String msg;

  GetAllServiceResult({this.list, this.result, this.msg});

  GetAllServiceResult.fromJson(Map<String, dynamic> json) {
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

class ServiceCaseList {
  String srid;
  String code;
  String phone;
  String detail;
  String summary;
  String result;
  String catagoryName;
  String catagoryId;
  String statusName;
  String statusId;
  String openDate;
  String closeDate;
  String notify;

  ServiceCaseList(
      {this.srid,
      this.code,
      this.phone,
      this.detail,
      this.summary,
      this.result,
      this.catagoryName,
      this.catagoryId,
      this.statusName,
      this.statusId,
      this.openDate,
      this.closeDate,
      this.notify});

  ServiceCaseList.fromJson(Map<String, dynamic> json) {
    srid = json['srid'];
    code = json['code'];
    phone = json['phone'];
    detail = json['detail'];
    summary = json['summary'];
    result = json['result'];
    catagoryName = json['catagory_name'];
    catagoryId = json['catagory_id'];
    statusName = json['status_name'];
    statusId = json['status_id'];
    openDate = json['open_date'];
    closeDate = json['close_date'];
    notify = json['notify'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['srid'] = this.srid;
    data['code'] = this.code;
    data['phone'] = this.phone;
    data['detail'] = this.detail;
    data['summary'] = this.summary;
    data['result'] = this.result;
    data['catagory_name'] = this.catagoryName;
    data['catagory_id'] = this.catagoryId;
    data['status_name'] = this.statusName;
    data['status_id'] = this.statusId;
    data['open_date'] = this.openDate;
    data['close_date'] = this.closeDate;
    data['notify'] = this.notify;
    return data;
  }
}
