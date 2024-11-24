class DateDt {
  String? adDate;
  String? bsDate;
  String? weekdays;
  bool? holidayFl;

  DateDt({this.adDate, this.bsDate, this.weekdays, this.holidayFl});

  DateDt.fromJson(Map<String, dynamic> json) {
    adDate = json['ad_date'];
    bsDate = json['bs_date'];
    weekdays = json['weekdays'];
    holidayFl = json['holiday_fl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ad_date'] = this.adDate;
    data['bs_date'] = this.bsDate;
    data['weekdays'] = this.weekdays;
    data['holiday_fl'] = this.holidayFl;
    return data;
  }
}
