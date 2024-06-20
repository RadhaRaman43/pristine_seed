
class ForgotPassResponse {
  String? condition;
  String? message;
  String? mailSendOnEmail;
  String? genrateOn;

  ForgotPassResponse(
      {this.condition, this.message, this.mailSendOnEmail, this.genrateOn});

  ForgotPassResponse.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    mailSendOnEmail = json['mail_send_on_email'];
    genrateOn = json['genrate_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['message'] = this.message;
    data['mail_send_on_email'] = this.mailSendOnEmail;
    data['genrate_on'] = this.genrateOn;
    return data;
  }
}