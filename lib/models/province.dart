class Province {
  var getProvinceResult;

  Province({this.getProvinceResult});

  Province.fromJson(Map<String, dynamic> json) {
    getProvinceResult = json['GetProvinceResult'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['GetProvinceResult'] = this.getProvinceResult;

    return data;
  }
}

class GetProvinceResult {
  String result;
  var value;

  GetProvinceResult({this.result, this.value});

  GetProvinceResult.fromJson(Map<String, dynamic> json) {
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

class ProvinceValue {
  String value;
  String label;

  ProvinceValue({this.value, this.label});

  ProvinceValue.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['label'] = this.label;
    return data;
  }
}
