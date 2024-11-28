class SchemeProductDt {
  int? productId;
  int? schemeId;
  String? schemeProductName;
  bool? ipd;
  double? ssfPc;
  bool? status;
  bool? hib;

  SchemeProductDt(
      {this.productId,
      this.schemeId,
      this.schemeProductName,
      this.ipd,
      this.ssfPc,
      this.status,
      this.hib});

  SchemeProductDt.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    schemeId = json['scheme_id'];
    schemeProductName = json['scheme_product_name'];
    ipd = json['ipd'];
    ssfPc = json['ssf_pc'];
    status = json['status'];
    hib = json['hib'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['scheme_id'] = this.schemeId;
    data['scheme_product_name'] = this.schemeProductName;
    data['ipd'] = this.ipd;
    data['ssf_pc'] = this.ssfPc;
    data['status'] = this.status;
    data['hib'] = this.hib;
    return data;
  }
}
