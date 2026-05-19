class ReportingManagerModal {
  String? condition;
  String? message;
  String? emailId;
  String? userFullName;

  ReportingManagerModal({this.condition, this.message, this.emailId, this.userFullName});

  ReportingManagerModal.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    emailId = json['email_id'];
    userFullName = json['user_full_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['message'] = this.message;
    data['email_id'] = this.emailId;
    data['user_full_name'] = this.userFullName;
    return data;
  }
}