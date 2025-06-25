class AnnualHolidaysModel {
  String? condition;
  String? calenderCode;
  int? date;
  String? day;
  String? status;
  int? isHalfDay;
  String? dateMonth;
  int? dateYear;
  int? dateWeek;
  String? description;
  String? createdBy;
  String? createdOn;

  AnnualHolidaysModel(
      {this.condition,
        this.calenderCode,
        this.date,
        this.day,
        this.status,
        this.isHalfDay,
        this.dateMonth,
        this.dateYear,
        this.dateWeek,
        this.description,
        this.createdBy,
        this.createdOn});

  AnnualHolidaysModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    calenderCode = json['calender_code'];
    date = json['date'];
    day = json['day'];
    status = json['status'];
    isHalfDay = json['is_half_day'];
    dateMonth = json['date_month'];
    dateYear = json['date_year'];
    dateWeek = json['date_week'];
    description = json['description'];
    createdBy = json['created_by'];
    createdOn = json['created_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['calender_code'] = this.calenderCode;
    data['date'] = this.date;
    data['day'] = this.day;
    data['status'] = this.status;
    data['is_half_day'] = this.isHalfDay;
    data['date_month'] = this.dateMonth;
    data['date_year'] = this.dateYear;
    data['date_week'] = this.dateWeek;
    data['description'] = this.description;
    data['created_by'] = this.createdBy;
    data['created_on'] = this.createdOn;
    return data;
  }
}