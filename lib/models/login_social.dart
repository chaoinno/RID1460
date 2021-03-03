class LogInSocialResult {
  var loginSocialResult;

  LogInSocialResult({this.loginSocialResult});

  LogInSocialResult.fromJson(Map<String, dynamic> json) {
    loginSocialResult = json['login_socialResult'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['login_socialResult'] = this.loginSocialResult.toJson();
    return data;
  }
}

class LoginSocialResult {
  String userID;
  String sessionID;
  String role;
  String firstname;
  String lastname;
  String email;
  String telephone;
  String tokenID;
  String result;
  String msg;

  LoginSocialResult(
      {this.userID,
      this.sessionID,
      this.role,
      this.firstname,
      this.lastname,
      this.email,
      this.telephone,
      this.tokenID,
      this.result,
      this.msg});

  LoginSocialResult.fromJson(Map<String, dynamic> json) {
    userID = json['User_ID'];
    sessionID = json['Session_ID'];
    role = json['Role'];
    firstname = json['Firstname'];
    lastname = json['Lastname'];
    email = json['Email'];
    telephone = json['Telephone'];
    tokenID = json['Token_ID'];
    result = json['result'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['User_ID'] = this.userID;
    data['Session_ID'] = this.sessionID;
    data['Role'] = this.role;
    data['Firstname'] = this.firstname;
    data['Lastname'] = this.lastname;
    data['Email'] = this.email;
    data['Telephone'] = this.telephone;
    data['Token_ID'] = this.tokenID;
    data['result'] = this.result;
    data['msg'] = this.msg;
    return data;
  }
}
