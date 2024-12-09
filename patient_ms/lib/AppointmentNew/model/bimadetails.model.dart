class BimaDetailsDt {
  String? address;
  String? family;
  String? given;
  String? ssfIdentity;
  String? birthdate;
  String? id;
  String? gender;
  String? telephone;
  String? email;
  String? claimSystem;
  String? photo;
  String? fsp;
  String? district;
  String? registrationDate;

  BimaDetailsDt(
      {this.address,
      this.family,
      this.given,
      this.ssfIdentity,
      this.birthdate,
      this.id,
      this.gender,
      this.telephone,
      this.email,
      this.claimSystem,
      this.photo,
      this.fsp,
      this.district,
      this.registrationDate});

  BimaDetailsDt.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    family = json['family'];
    given = json['given'];
    ssfIdentity = json['ssf_identity'];
    birthdate = json['birthdate'];
    id = json['id'];
    gender = json['gender'];
    telephone = json['telephone'];
    email = json['email'];
    claimSystem = json['claim_system'];
    photo = json['photo'];
    fsp = json['fsp'];
    district = json['district'];
    registrationDate = json['registrationDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['family'] = this.family;
    data['given'] = this.given;
    data['ssf_identity'] = this.ssfIdentity;
    data['birthdate'] = this.birthdate;
    data['id'] = this.id;
    data['gender'] = this.gender;
    data['telephone'] = this.telephone;
    data['email'] = this.email;
    data['claim_system'] = this.claimSystem;
    data['photo'] = this.photo;
    data['fsp'] = this.fsp;
    data['district'] = this.district;
    data['registrationDate'] = this.registrationDate;
    return data;
  }
}
