class Zipcode {
  var getZipcodeResult;

  Zipcode({this.getZipcodeResult});

  Zipcode.fromJson(Map<String, dynamic> json) {
    getZipcodeResult = json['GetZipcodeResult'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['GetZipcodeResult'] = this.getZipcodeResult;

    return data;
  }
}

class GetZipcodeResult {
  String result;
  var value;

  GetZipcodeResult({this.result, this.value});

  GetZipcodeResult.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['value'] = this.value;
    return data;
  }
}
