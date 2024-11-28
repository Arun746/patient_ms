class SchemeDt {
  int? schemeId;
  String? schemeName;
  bool? hib;

  SchemeDt({this.schemeId, this.schemeName, this.hib});

  SchemeDt.fromJson(Map<String, dynamic> json) {
    schemeId = json['scheme_id'];
    schemeName = json['scheme_name'];
    hib = json['hib'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['scheme_id'] = this.schemeId;
    data['scheme_name'] = this.schemeName;
    data['hib'] = this.hib;
    return data;
  }
}
