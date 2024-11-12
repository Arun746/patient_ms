class HospitalDt {
  int? hospitalCode;
  String? hospitalName;
  String? hospitalAddress;
  String? hospitalTelephone;
  String? hospitalMobile;
  String? hospitalEmail;
  String? merchantCode;
  Null logo;

  HospitalDt(
      {this.hospitalCode,
      this.hospitalName,
      this.hospitalAddress,
      this.hospitalTelephone,
      this.hospitalMobile,
      this.hospitalEmail,
      this.merchantCode,
      this.logo});

  HospitalDt.fromJson(Map<String, dynamic> json) {
    hospitalCode = json['hospital_code'];
    hospitalName = json['hospital_name'];
    hospitalAddress = json['hospital_address'];
    hospitalTelephone = json['hospital_telephone'];
    hospitalMobile = json['hospital_mobile'];
    hospitalEmail = json['hospital_email'];
    merchantCode = json['merchant_code'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hospital_code'] = this.hospitalCode;
    data['hospital_name'] = this.hospitalName;
    data['hospital_address'] = this.hospitalAddress;
    data['hospital_telephone'] = this.hospitalTelephone;
    data['hospital_mobile'] = this.hospitalMobile;
    data['hospital_email'] = this.hospitalEmail;
    data['merchant_code'] = this.merchantCode;
    data['logo'] = this.logo;
    return data;
  }
}
