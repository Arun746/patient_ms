class PatientInfoDt {
  String? address;
  String? contactPerson;
  String? contactPhone;
  String? contactRelation;
  String? ddate;
  String? dob;
  String? email;
  String? ethinicCode;
  String? gender;
  String? hospid;
  String? id;
  String? martialstatus;
  String? nagarVdcId;
  String? nid;
  String? occupation;
  String? pname;
  String? policyid;
  String? regno;
  String? remarks;
  String? staff;
  String? telephone;
  String? userid;
  String? wardno;

  PatientInfoDt(
      {this.address,
      this.contactPerson,
      this.contactPhone,
      this.contactRelation,
      this.ddate,
      this.dob,
      this.email,
      this.ethinicCode,
      this.gender,
      this.hospid,
      this.id,
      this.martialstatus,
      this.nagarVdcId,
      this.nid,
      this.occupation,
      this.pname,
      this.policyid,
      this.regno,
      this.remarks,
      this.staff,
      this.telephone,
      this.userid,
      this.wardno});

  PatientInfoDt.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    contactPerson = json['contact_person'];
    contactPhone = json['contact_phone'];
    contactRelation = json['contact_relation'];
    ddate = json['ddate'];
    dob = json['dob'];
    email = json['email'];
    ethinicCode = json['ethinic_code'];
    gender = json['gender'];
    hospid = json['hospid'];
    id = json['id'];
    martialstatus = json['martialstatus'];
    nagarVdcId = json['nagar_vdc_id'];
    nid = json['nid'];
    occupation = json['occupation'];
    pname = json['pname'];
    policyid = json['policyid'];
    regno = json['regno'];
    remarks = json['remarks'];
    staff = json['staff'];
    telephone = json['telephone'];
    userid = json['userid'];
    wardno = json['wardno'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['contact_person'] = this.contactPerson;
    data['contact_phone'] = this.contactPhone;
    data['contact_relation'] = this.contactRelation;
    data['ddate'] = this.ddate;
    data['dob'] = this.dob;
    data['email'] = this.email;
    data['ethinic_code'] = this.ethinicCode;
    data['gender'] = this.gender;
    data['hospid'] = this.hospid;
    data['id'] = this.id;
    data['martialstatus'] = this.martialstatus;
    data['nagar_vdc_id'] = this.nagarVdcId;
    data['nid'] = this.nid;
    data['occupation'] = this.occupation;
    data['pname'] = this.pname;
    data['policyid'] = this.policyid;
    data['regno'] = this.regno;
    data['remarks'] = this.remarks;
    data['staff'] = this.staff;
    data['telephone'] = this.telephone;
    data['userid'] = this.userid;
    data['wardno'] = this.wardno;
    return data;
  }
}
