class CallStatusMasterModel {
  String? condition;
  String? totalRows;
  int? id;
  String? typeOfCall;
  String? taskStatus;
  int? isNextInteraction;
  int? isClosed;
  int? isCreateNewTask;
  int? isCreateSalesCycle;
  int? isInfraLead;
  int? isTypeOfCall;
  String? createdBy;
  String? createdOn;
  String? updatedBy;
  String? updatedOn;

  CallStatusMasterModel(
      {this.condition,
        this.totalRows,
        this.id,
        this.typeOfCall,
        this.taskStatus,
        this.isNextInteraction,
        this.isClosed,
        this.isCreateNewTask,
        this.isCreateSalesCycle,
        this.isInfraLead,
        this.isTypeOfCall,
        this.createdBy,
        this.createdOn,
        this.updatedBy,
        this.updatedOn});

  CallStatusMasterModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    totalRows = json['total_rows'];
    id = json['id'];
    typeOfCall = json['type_of_call'];
    taskStatus = json['task_status'];
    isNextInteraction = json['is_next_interaction'];
    isClosed = json['is_closed'];
    isCreateNewTask = json['is_create_new_task'];
    isCreateSalesCycle = json['is_create_sales_cycle'];
    isInfraLead = json['is_infra_lead'];
    isTypeOfCall = json['is_type_of_call'];
    createdBy = json['created_by'];
    createdOn = json['created_on'];
    updatedBy = json['updated_by'];
    updatedOn = json['updated_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['total_rows'] = this.totalRows;
    data['id'] = this.id;
    data['type_of_call'] = this.typeOfCall;
    data['task_status'] = this.taskStatus;
    data['is_next_interaction'] = this.isNextInteraction;
    data['is_closed'] = this.isClosed;
    data['is_create_new_task'] = this.isCreateNewTask;
    data['is_create_sales_cycle'] = this.isCreateSalesCycle;
    data['is_infra_lead'] = this.isInfraLead;
    data['is_type_of_call'] = this.isTypeOfCall;
    data['created_by'] = this.createdBy;
    data['created_on'] = this.createdOn;
    data['updated_by'] = this.updatedBy;
    data['updated_on'] = this.updatedOn;
    return data;
  }
}