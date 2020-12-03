class Login {
  var loginResult;

  Login({this.loginResult});

  Login.fromJson(Map<String, dynamic> json) {
    loginResult =  json['loginResult'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loginResult'] = this.loginResult.toJson();
    return data;
  }
}

class LoginResult {
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

  LoginResult(
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

  LoginResult.fromJson(Map<String, dynamic> json) {
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