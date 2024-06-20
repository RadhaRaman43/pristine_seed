class NotificationListResponse {
  String? condition;
  int? id;
  String? emailId;
  String? documentType;
  String? documentNo;
  String? subDocumentNo;
  String? message;
  int? acknowledgement;
  String? createdOn;
  String? updatedOn;
  String? createdBy;
  int? isSendToUser;
  int? hitCount;

  NotificationListResponse(
      {this.condition,
        this.id,
        this.emailId,
        this.documentType,
        this.documentNo,
        this.subDocumentNo,
        this.message,
        this.acknowledgement,
        this.createdOn,
        this.updatedOn,
        this.createdBy,
        this.isSendToUser,
        this.hitCount});

  NotificationListResponse.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    id = json['id'];
    emailId = json['email_id'];
    documentType = json['document_type'];
    documentNo = json['document_no'];
    subDocumentNo = json['sub_document_no'];
    message = json['message'];
    acknowledgement = json['acknowledgement'];
    createdOn = json['created_on'];
    updatedOn = json['updated_on'];
    createdBy = json['created_by'];
    isSendToUser = json['is_send_to_user'];
    hitCount = json['hit_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['id'] = this.id;
    data['email_id'] = this.emailId;
    data['document_type'] = this.documentType;
    data['document_no'] = this.documentNo;
    data['sub_document_no'] = this.subDocumentNo;
    data['message'] = this.message;
    data['acknowledgement'] = this.acknowledgement;
    data['created_on'] = this.createdOn;
    data['updated_on'] = this.updatedOn;
    data['created_by'] = this.createdBy;
    data['is_send_to_user'] = this.isSendToUser;
    data['hit_count'] = this.hitCount;
    return data;
  }
}