class SpecialityDt {
  int? spId;
  String? detail;

  SpecialityDt.fromJson(Map<String, dynamic> json) {
    spId = json['sp_id'];
    detail = json['detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sp_id'] = this.spId;
    data['detail'] = this.detail;
    return data;
  }
}
