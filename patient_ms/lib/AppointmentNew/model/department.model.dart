class DepartmentDt {
  int? hospitalCode;
  int? grpid;
  String? groupname;
  bool? su;
  bool? mo;
  bool? tu;
  bool? we;
  bool? th;
  bool? fr;
  bool? sa;
  String? appointmentEndtime;
  double? newRate;
  double? oldRate;

  DepartmentDt(
      {this.hospitalCode,
      this.grpid,
      this.groupname,
      this.su,
      this.mo,
      this.tu,
      this.we,
      this.th,
      this.fr,
      this.sa,
      this.appointmentEndtime,
      this.newRate,
      this.oldRate});

  DepartmentDt.fromJson(Map<String, dynamic> json) {
    hospitalCode = json['hospital_code'];
    grpid = json['grpid'];
    groupname = json['groupname'];
    su = json['su'];
    mo = json['mo'];
    tu = json['tu'];
    we = json['we'];
    th = json['th'];
    fr = json['fr'];
    sa = json['sa'];
    appointmentEndtime = json['appointment_endtime'];
    newRate = json['new_rate'];
    oldRate = json['old_rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hospital_code'] = this.hospitalCode;
    data['grpid'] = this.grpid;
    data['groupname'] = this.groupname;
    data['su'] = this.su;
    data['mo'] = this.mo;
    data['tu'] = this.tu;
    data['we'] = this.we;
    data['th'] = this.th;
    data['fr'] = this.fr;
    data['sa'] = this.sa;
    data['appointment_endtime'] = this.appointmentEndtime;
    data['new_rate'] = this.newRate;
    data['old_rate'] = this.oldRate;
    return data;
  }
}
