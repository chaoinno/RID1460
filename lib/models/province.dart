class Province {
  String getProvinceResult;

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
