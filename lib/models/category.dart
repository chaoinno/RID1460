class Category {
  var getCategoryResult;

  Category({this.getCategoryResult});

  Category.fromJson(Map<String, dynamic> json) {
    getCategoryResult = json['GetCategoryResult'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['GetCategoryResult'] = this.getCategoryResult;
    return data;
  }
}

class GetCategoryResult {
  String result;
  var value;

  GetCategoryResult({this.result, this.value});

  GetCategoryResult.fromJson(Map<String, dynamic> json) {
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

class CategoryValue {
  int value;
  String label;

  CategoryValue({this.value, this.label});

  CategoryValue.fromJson(Map<String, dynamic> json) {
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
