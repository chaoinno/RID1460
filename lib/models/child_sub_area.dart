class ChildSubArea {
  var getChildSubAreaResult;

  ChildSubArea({this.getChildSubAreaResult});

  ChildSubArea.fromJson(Map<String, dynamic> json) {
    getChildSubAreaResult = json['GetSubdistrictResult'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['GetSubdistrictResult'] = this.getChildSubAreaResult;

    return data;
  }
}

class GetChildSubAreaResult {
  String result;
  var value;

  GetChildSubAreaResult({this.result, this.value});

  GetChildSubAreaResult.fromJson(Map<String, dynamic> json) {
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

class ChildSubAreaValue {
  String value;
  String label;

  ChildSubAreaValue({this.value, this.label});

  ChildSubAreaValue.fromJson(Map<String, dynamic> json) {
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
