class ShortLeaveTimeModel {
  String? condition;
  int? shiftID;
  String? shiftName;
  String? shiftStartTime;
  String? shiftEndTime;
  String? morningLeaveStart;
  String? morningLeaveEnd;
  String? eveningLeaveStart;
  String? eveningLeaveEnd;

  ShortLeaveTimeModel(
      {this.condition,
        this.shiftID,
        this.shiftName,
        this.shiftStartTime,
        this.shiftEndTime,
        this.morningLeaveStart,
        this.morningLeaveEnd,
        this.eveningLeaveStart,
        this.eveningLeaveEnd});

  ShortLeaveTimeModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    shiftID = json['ShiftID'];
    shiftName = json['shift_name'];
    shiftStartTime = json['ShiftStartTime'];
    shiftEndTime = json['ShiftEndTime'];
    morningLeaveStart = json['MorningLeaveStart'];
    morningLeaveEnd = json['MorningLeaveEnd'];
    eveningLeaveStart = json['EveningLeaveStart'];
    eveningLeaveEnd = json['EveningLeaveEnd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['ShiftID'] = this.shiftID;
    data['shift_name'] = this.shiftName;
    data['ShiftStartTime'] = this.shiftStartTime;
    data['ShiftEndTime'] = this.shiftEndTime;
    data['MorningLeaveStart'] = this.morningLeaveStart;
    data['MorningLeaveEnd'] = this.morningLeaveEnd;
    data['EveningLeaveStart'] = this.eveningLeaveStart;
    data['EveningLeaveEnd'] = this.eveningLeaveEnd;
    return data;
  }
}