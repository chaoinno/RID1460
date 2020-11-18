class ChildArea {
  var getChildAreaResult;

  ChildArea({this.getChildAreaResult});

  ChildArea.fromJson(Map<String, dynamic> json) {
    getChildAreaResult = json['GetChildAreaResult'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['GetChildAreaResult'] = this.getChildAreaResult;

    return data;
  }
}

class GetChildAreaResult {
  String result;
  var value;

  GetChildAreaResult({this.result, this.value});

  GetChildAreaResult.fromJson(Map<String, dynamic> json) {
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

class ChildAreaValue {
  String value;
  String label;

  ChildAreaValue({this.value, this.label});

  ChildAreaValue.fromJson(Map<String, dynamic> json) {
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
