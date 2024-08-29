class DoctorDt {
  int? refid;
  int? spId;
  String? referer;
  String? regno;
  int? acCode;
  String? qualification;
  String? present;
  String? professional;
  String? specialized;
  String? publication;
  String? other;
  bool? oncall;
  int? min;
  String? password;
  String? address;
  String? telephone;
  String? status;
  int? templateId;
  int? templateid;
  int? smCode;
  int? refererType;
  int? consultid;
  bool? patho;
  bool? refering;
  bool? consult;
  bool? doctor;
  double? rate;
  String? email;
  bool? appointment;
  bool? radiologist;
  String? zoomUser;
  String? zoomApikey;
  String? zoomSecretkey;
  String? image;

  DoctorDt(
      {this.refid,
      this.spId,
      this.referer,
      this.regno,
      this.acCode,
      this.qualification,
      this.present,
      this.professional,
      this.specialized,
      this.publication,
      this.other,
      this.oncall,
      this.min,
      this.password,
      this.address,
      this.telephone,
      this.status,
      this.templateId,
      this.templateid,
      this.smCode,
      this.refererType,
      this.consultid,
      this.patho,
      this.refering,
      this.consult,
      this.doctor,
      this.rate,
      this.email,
      this.appointment,
      this.radiologist,
      this.zoomUser,
      this.zoomApikey,
      this.zoomSecretkey,
      this.image});

  DoctorDt.fromJson(Map<String, dynamic> json) {
    refid = json['refid'];
    spId = json['sp_id'];
    referer = json['referer'];
    regno = json['regno'];
    acCode = json['ac_code'];
    qualification = json['qualification'];
    present = json['present'];
    professional = json['professional'];
    specialized = json['specialized'];
    publication = json['publication'];
    other = json['other'];
    oncall = json['oncall'];
    min = json['min'];
    password = json['password'];
    address = json['address'];
    telephone = json['telephone'];
    status = json['status'];
    templateId = json['template_id'];
    templateid = json['templateid'];
    smCode = json['sm_code'];
    refererType = json['referer_type'];
    consultid = json['consultid'];
    patho = json['patho'];
    refering = json['refering'];
    consult = json['consult'];
    doctor = json['doctor'];
    rate = json['rate'];
    email = json['email'];
    appointment = json['appointment'];
    radiologist = json['radiologist'];
    zoomUser = json['zoom_user'];
    zoomApikey = json['zoom_apikey'];
    zoomSecretkey = json['zoom_secretkey'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['refid'] = this.refid;
    data['sp_id'] = this.spId;
    data['referer'] = this.referer;
    data['regno'] = this.regno;
    data['ac_code'] = this.acCode;
    data['qualification'] = this.qualification;
    data['present'] = this.present;
    data['professional'] = this.professional;
    data['specialized'] = this.specialized;
    data['publication'] = this.publication;
    data['other'] = this.other;
    data['oncall'] = this.oncall;
    data['min'] = this.min;
    data['password'] = this.password;
    data['address'] = this.address;
    data['telephone'] = this.telephone;
    data['status'] = this.status;
    data['template_id'] = this.templateId;
    data['templateid'] = this.templateid;
    data['sm_code'] = this.smCode;
    data['referer_type'] = this.refererType;
    data['consultid'] = this.consultid;
    data['patho'] = this.patho;
    data['refering'] = this.refering;
    data['consult'] = this.consult;
    data['doctor'] = this.doctor;
    data['rate'] = this.rate;
    data['email'] = this.email;
    data['appointment'] = this.appointment;
    data['radiologist'] = this.radiologist;
    data['zoom_user'] = this.zoomUser;
    data['zoom_apikey'] = this.zoomApikey;
    data['zoom_secretkey'] = this.zoomSecretkey;
    data['image'] = this.image;
    return data;
  }
}
