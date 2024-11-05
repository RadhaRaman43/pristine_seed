class TaskDSARModel {
  String? condition;
  String? totalRows;
  String? taskId;
  int? isInfraLead;
  String? dsarStatus;
  String? nextInteractionDate;
  String? nextInteractionTime;
  String? remarks;
  String? createdBy;
  String? createdFullName;
  String? createdOn;
  String? methodOfCall;
  String? purposeOfVisit;

  TaskDSARModel(
      {this.condition,
        this.totalRows,
        this.taskId,
        this.isInfraLead,
        this.dsarStatus,
        this.nextInteractionDate,
        this.nextInteractionTime,
        this.remarks,
        this.createdBy,
        this.createdFullName,
        this.createdOn,
        this.methodOfCall,
        this.purposeOfVisit});

  TaskDSARModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    totalRows = json['total_rows'];
    taskId = json['task_id'];
    isInfraLead = json['is_infra_lead'];
    dsarStatus = json['dsar_status'];
    nextInteractionDate = json['next_interaction_date'];
    nextInteractionTime = json['next_interaction_time'];
    remarks = json['remarks'];
    createdBy = json['created_by'];
    createdFullName = json['created_full_name'];
    createdOn = json['created_on'];
    methodOfCall = json['method_of_call'];
    purposeOfVisit = json['purpose_of_visit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['total_rows'] = this.totalRows;
    data['task_id'] = this.taskId;
    data['is_infra_lead'] = this.isInfraLead;
    data['dsar_status'] = this.dsarStatus;
    data['next_interaction_date'] = this.nextInteractionDate;
    data['next_interaction_time'] = this.nextInteractionTime;
    data['remarks'] = this.remarks;
    data['created_by'] = this.createdBy;
    data['created_full_name'] = this.createdFullName;
    data['created_on'] = this.createdOn;
    data['method_of_call'] = this.methodOfCall;
    data['purpose_of_visit'] = this.purposeOfVisit;
    return data;
  }
}