class AccountDetail {
  var getAccountDetailResult;

  AccountDetail({this.getAccountDetailResult});

  AccountDetail.fromJson(Map<String, dynamic> json) {
    getAccountDetailResult = json['getAccountDetailResult'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['getAccountDetailResult'] = this.getAccountDetailResult;
  }
}

class GetAccountDetailResult {
  var account;
  var lsInfo;
  String result;
  String msg;

  GetAccountDetailResult({this.account, this.lsInfo, this.result, this.msg});

  GetAccountDetailResult.fromJson(Map<String, dynamic> json) {
    account = json['account'];
    lsInfo = json['lsInfo'];
    result = json['result'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['account'] = this.account;
    data['lsInfo'] = this.lsInfo;
    data['result'] = this.result;
    data['msg'] = this.msg;
    return data;
  }
}

class Account {
  String id;
  String title;
  String firstname;
  String lastname;
  String gender;
  String citizenid;
  String address;
  String province;
  String district;
  String subdistrict;
  String zipcode;
  String phone;

  Account(
      {this.id,
      this.title,
      this.firstname,
      this.lastname,
      this.gender,
      this.citizenid,
      this.address,
      this.province,
      this.district,
      this.subdistrict,
      this.zipcode,
      this.phone});

  Account.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    gender = json['gender'];
    citizenid = json['citizenid'];
    address = json['address'];
    province = json['province'];
    district = json['district'];
    subdistrict = json['subdistrict'];
    zipcode = json['zipcode'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['gender'] = this.gender;
    data['citizenid'] = this.citizenid;
    data['address'] = this.address;
    data['province'] = this.province;
    data['district'] = this.district;
    data['subdistrict'] = this.subdistrict;
    data['zipcode'] = this.zipcode;
    data['phone'] = this.phone;
    return data;
  }
}
