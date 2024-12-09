//this model is used to for the response data recived from appointment post
class AppPostModel {
  String? ddate;
  String? appointmentDate;
  String? appointmentTime;
  int? dpId;
  int? refid;
  String? remarks;
  int? hospitalCode;
  double? rate;
  int? traceId;
  bool? review;
  int? reviewId;
  String? reviewDatetime;
  bool? websiteUpdate;
  bool? new_;
  bool? insurance;
  bool? ssf;
  int? schemeId;
  int? schemeProductId;
  double? balance;
  int? servid;
  int? consid;
  int? id;
  int? patientId;

  AppPostModel({
    this.ddate,
    this.appointmentDate,
    this.appointmentTime,
    this.dpId,
    this.refid,
    this.remarks,
    this.hospitalCode,
    this.rate,
    this.traceId,
    this.review,
    this.reviewId,
    this.reviewDatetime,
    this.websiteUpdate,
    this.new_,
    this.insurance,
    this.ssf,
    this.schemeId,
    this.schemeProductId,
    this.balance,
    this.servid,
    this.consid,
    this.id,
    this.patientId,
  });

  AppPostModel.fromJson(Map<String, dynamic> json) {
    ddate = json['ddate'];
    appointmentDate = json['appointment_date'];
    appointmentTime = json['appointment_time'];
    dpId = json['dp_id'];
    refid = json['refid'];
    remarks = json['remarks'];
    hospitalCode = json['hospital_code'];
    rate = json['rate'];
    traceId = json['trace_id'];
    review = json['review'];
    reviewId = json['review_id'];
    reviewDatetime = json['review_datetime'];
    websiteUpdate = json['website_update'];
    new_ = json['new_'];
    insurance = json['insurance'];
    ssf = json['ssf'];
    schemeId = json['scheme_id'];
    schemeProductId = json['scheme_product_id'];
    balance = json['balance'];
    servid = json['servid'];
    consid = json['consid'];
    id = json['id'];
    patientId = json['patient_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ddate'] = this.ddate;
    data['appointment_date'] = this.appointmentDate;
    data['appointment_time'] = this.appointmentTime;
    data['dp_id'] = this.dpId;
    data['refid'] = this.refid;
    data['remarks'] = this.remarks;
    data['hospital_code'] = this.hospitalCode;
    data['rate'] = this.rate;
    data['trace_id'] = this.traceId;
    data['review'] = this.review;
    data['review_id'] = this.reviewId;
    data['review_datetime'] = this.reviewDatetime;
    data['website_update'] = this.websiteUpdate;
    data['new_'] = this.new_;
    data['insurance'] = this.insurance;
    data['ssf'] = this.ssf;
    data['scheme_id'] = this.schemeId;
    data['scheme_product_id'] = this.schemeProductId;
    data['balance'] = this.balance;
    data['servid'] = this.servid;
    data['consid'] = this.consid;
    data['id'] = this.id;
    data['patient_id'] = this.patientId;
    return data;
  }
}
