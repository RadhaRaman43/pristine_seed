class TaskMasterGetModel {
  String? condition;
  String? message;
  String? totalRows;
  String? taskId;
  String? typeOfCall;
  String? methodOfCall;
  String? accountCode;
  String? accountName;
  String? contactCode;
  String? contactName;
  String? taskStatus;
  String? taskDueDate;
  String? taskDueTime;
  String? purposeOfVisit;
  String? taskRemarks;
  String? previousTaskId;
  String? productCategory;
  String? lastActivityStatus;
  String? lastActivityUpdatedBy;
  String? lastActivityUpdatedOn;
  int? isSalesCycleActive;
  String? salesCycleActivatedBy;
  String? salesCycleActivatedOn;
  String? salesCycleId;
  String? approvedBy;
  String? approvedFullName;
  String? approvedOn;
  String? rejectReason;
  String? createdBy;
  String? createdFullName;
  String? createdOn;
  int? isInfraLead;
  String? userRegion;
  String? userClusture;
  double? projectValue;
  String? expectedDateOfOrder;
  int? drawingCollected;
  int? proposalSubmitted;
  String? inaugrationDateOfProject;
  String? architect;
  String? executiveEngineer;
  String? nameOfArchitectFirm;
  String? nameOfInfraDepartment;
  String? nameOfAgencyContrator;
  double? expectedRevenue;
  double? valueOfQuote;
  String? expectedDateOfCompletion;
  int? isReadyForApprove;
  int? isCreateTaskDsar;

  TaskMasterGetModel(
      {this.condition,
        this.message,
        this.totalRows,
        this.taskId,
        this.typeOfCall,
        this.methodOfCall,
        this.accountCode,
        this.accountName,
        this.contactCode,
        this.contactName,
        this.taskStatus,
        this.taskDueDate,
        this.taskDueTime,
        this.purposeOfVisit,
        this.taskRemarks,
        this.previousTaskId,
        this.productCategory,
        this.lastActivityStatus,
        this.lastActivityUpdatedBy,
        this.lastActivityUpdatedOn,
        this.isSalesCycleActive,
        this.salesCycleActivatedBy,
        this.salesCycleActivatedOn,
        this.salesCycleId,
        this.approvedBy,
        this.approvedFullName,
        this.approvedOn,
        this.rejectReason,
        this.createdBy,
        this.createdFullName,
        this.createdOn,
        this.isInfraLead,
        this.userRegion,
        this.userClusture,
        this.projectValue,
        this.expectedDateOfOrder,
        this.drawingCollected,
        this.proposalSubmitted,
        this.inaugrationDateOfProject,
        this.architect,
        this.executiveEngineer,
        this.nameOfArchitectFirm,
        this.nameOfInfraDepartment,
        this.nameOfAgencyContrator,
        this.expectedRevenue,
        this.valueOfQuote,
        this.expectedDateOfCompletion,
        this.isReadyForApprove,
        this.isCreateTaskDsar});

  TaskMasterGetModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    totalRows = json['total_rows'];
    taskId = json['task_id'];
    typeOfCall = json['type_of_call'];
    methodOfCall = json['method_of_call'];
    accountCode = json['account_code'];
    accountName = json['account_name'];
    contactCode = json['contact_code'];
    contactName = json['contact_name'];
    taskStatus = json['task_status'];
    taskDueDate = json['task_due_date'];
    taskDueTime = json['task_due_time'];
    purposeOfVisit = json['purpose_of_visit'];
    taskRemarks = json['task_remarks'];
    previousTaskId = json['previous_task_id'];
    productCategory = json['product_category'];
    lastActivityStatus = json['last_activity_status'];
    lastActivityUpdatedBy = json['last_activity_updated_by'];
    lastActivityUpdatedOn = json['last_activity_updated_on'];
    isSalesCycleActive = json['is_sales_cycle_active'];
    salesCycleActivatedBy = json['sales_cycle_activated_by'];
    salesCycleActivatedOn = json['sales_cycle_activated_on'];
    salesCycleId = json['sales_cycle_id'];
    approvedBy = json['approved_by'];
    approvedFullName = json['approved_full_name'];
    approvedOn = json['approved_on'];
    rejectReason = json['reject_reason'];
    createdBy = json['created_by'];
    createdFullName = json['created_full_name'];
    createdOn = json['created_on'];
    isInfraLead = json['is_infra_lead'];
    userRegion = json['user_region'];
    userClusture = json['user_clusture'];
    projectValue = json['project_value'];
    expectedDateOfOrder = json['expected_date_of_order'];
    drawingCollected = json['drawing_collected'];
    proposalSubmitted = json['proposal_submitted'];
    inaugrationDateOfProject = json['inaugration_date_of_project'];
    architect = json['architect'];
    executiveEngineer = json['executive_engineer'];
    nameOfArchitectFirm = json['name_of_architect_firm'];
    nameOfInfraDepartment = json['name_of_infra_department'];
    nameOfAgencyContrator = json['name_of_agency_contrator'];
    expectedRevenue = json['expected_revenue'];
    valueOfQuote = json['value_of_quote'];
    expectedDateOfCompletion = json['expected_date_of_completion'];
    isReadyForApprove = json['is_ready_for_approve'];
    isCreateTaskDsar = json['is_create_task_dsar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['message'] = this.message;
    data['total_rows'] = this.totalRows;
    data['task_id'] = this.taskId;
    data['type_of_call'] = this.typeOfCall;
    data['method_of_call'] = this.methodOfCall;
    data['account_code'] = this.accountCode;
    data['account_name'] = this.accountName;
    data['contact_code'] = this.contactCode;
    data['contact_name'] = this.contactName;
    data['task_status'] = this.taskStatus;
    data['task_due_date'] = this.taskDueDate;
    data['task_due_time'] = this.taskDueTime;
    data['purpose_of_visit'] = this.purposeOfVisit;
    data['task_remarks'] = this.taskRemarks;
    data['previous_task_id'] = this.previousTaskId;
    data['product_category'] = this.productCategory;
    data['last_activity_status'] = this.lastActivityStatus;
    data['last_activity_updated_by'] = this.lastActivityUpdatedBy;
    data['last_activity_updated_on'] = this.lastActivityUpdatedOn;
    data['is_sales_cycle_active'] = this.isSalesCycleActive;
    data['sales_cycle_activated_by'] = this.salesCycleActivatedBy;
    data['sales_cycle_activated_on'] = this.salesCycleActivatedOn;
    data['sales_cycle_id'] = this.salesCycleId;
    data['approved_by'] = this.approvedBy;
    data['approved_full_name'] = this.approvedFullName;
    data['approved_on'] = this.approvedOn;
    data['reject_reason'] = this.rejectReason;
    data['created_by'] = this.createdBy;
    data['created_full_name'] = this.createdFullName;
    data['created_on'] = this.createdOn;
    data['is_infra_lead'] = this.isInfraLead;
    data['user_region'] = this.userRegion;
    data['user_clusture'] = this.userClusture;
    data['project_value'] = this.projectValue;
    data['expected_date_of_order'] = this.expectedDateOfOrder;
    data['drawing_collected'] = this.drawingCollected;
    data['proposal_submitted'] = this.proposalSubmitted;
    data['inaugration_date_of_project'] = this.inaugrationDateOfProject;
    data['architect'] = this.architect;
    data['executive_engineer'] = this.executiveEngineer;
    data['name_of_architect_firm'] = this.nameOfArchitectFirm;
    data['name_of_infra_department'] = this.nameOfInfraDepartment;
    data['name_of_agency_contrator'] = this.nameOfAgencyContrator;
    data['expected_revenue'] = this.expectedRevenue;
    data['value_of_quote'] = this.valueOfQuote;
    data['expected_date_of_completion'] = this.expectedDateOfCompletion;
    data['is_ready_for_approve'] = this.isReadyForApprove;
    data['is_create_task_dsar'] = this.isCreateTaskDsar;
    return data;
  }
}