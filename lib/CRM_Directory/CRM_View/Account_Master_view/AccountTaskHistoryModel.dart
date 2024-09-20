class AccountTaskHistoryModel {
  String? condition;
  String? totalRows;
  String? taskId;
  String? accountCode;
  String? accountName;
  String? contactCode;
  String? contactName;
  String? taskRemarks;
  String? salesCycleId;
  String? dsarStatus;
  String? nextInteractionDate;
  String? nextInteractionTime;
  String? remarks;
  String? createdBy;
  String? createdOn;

  AccountTaskHistoryModel(
      {this.condition,
        this.totalRows,
        this.taskId,
        this.accountCode,
        this.accountName,
        this.contactCode,
        this.contactName,
        this.taskRemarks,
        this.salesCycleId,
        this.dsarStatus,
        this.nextInteractionDate,
        this.nextInteractionTime,
        this.remarks,
        this.createdBy,
        this.createdOn});

  AccountTaskHistoryModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    totalRows = json['total_rows'];
    taskId = json['task_id'];
    accountCode = json['account_code'];
    accountName = json['account_name'];
    contactCode = json['contact_code'];
    contactName = json['contact_name'];
    taskRemarks = json['task_remarks'];
    salesCycleId = json['sales_cycle_id'];
    dsarStatus = json['dsar_status'];
    nextInteractionDate = json['next_interaction_date'];
    nextInteractionTime = json['next_interaction_time'];
    remarks = json['remarks'];
    createdBy = json['created_by'];
    createdOn = json['created_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['total_rows'] = this.totalRows;
    data['task_id'] = this.taskId;
    data['account_code'] = this.accountCode;
    data['account_name'] = this.accountName;
    data['contact_code'] = this.contactCode;
    data['contact_name'] = this.contactName;
    data['task_remarks'] = this.taskRemarks;
    data['sales_cycle_id'] = this.salesCycleId;
    data['dsar_status'] = this.dsarStatus;
    data['next_interaction_date'] = this.nextInteractionDate;
    data['next_interaction_time'] = this.nextInteractionTime;
    data['remarks'] = this.remarks;
    data['created_by'] = this.createdBy;
    data['created_on'] = this.createdOn;
    return data;
  }
}