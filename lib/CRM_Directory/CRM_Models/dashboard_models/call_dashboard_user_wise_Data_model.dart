class CallDashboardUserWiseDataModel {
  String? condition;
  String? totalRows;
  String? taskId;
  String? typeOfCall;
  String? methodOfCall;
  String? accountCode;
  String? accountName;
  String? contactCode;
  String? contactName;
  String? taskStatus;
  String? lastActivityStatus;
  String? lastActivityUpdatedBy;
  String? lastActivityUpdatedOn;
  String? taskDueDate;
  String? taskDueTime;
  String? taskRemarks;
  String? purposeOfVisit;
  dynamic isInfraLead;
  String? infraLeadNo;
  String? userRegion;
  String? userClusture;
  String? nameOfInfraDepartment;
  String? executiveEngineer;
  String? assistantEngineer;
  String? projectName;
  String? location;
  String? timePeriodToCompleteCivilWorkInMonths;
  String? expectedDateOfCompletion;
  dynamic projectValue;
  dynamic expectedRevenue;
  dynamic furnitureIncludedInCivilScope;
  String? customerName;
  String? contactPersonDecisionMaker;
  String? nameOfAgencyContrator;
  String? ownerOfContractor;
  String? projectSiteManager;
  String? nameOfArchitectFirm;
  String? architect;
  dynamic drawingCollected;
  String? dateDrawingReceived;
  dynamic proposalSubmitted;
  String? dateOfProposalSubmission;
  dynamic valueOfQuote;
  String? expectedDateOfOrder;
  String? inaugrationDateOfProject;
  dynamic isSalesCycleActive;
  String? salesCycleActivatedBy;
  String? salesCycleActivatedOn;
  String? salesCycleId;
  String? approvedBy;
  String? finalApprovedBy;
  String? approvedOn;
  String? rejectReason;
  String? reopenRemarks;
  String? managerRemarks;
  String? createdBy;
  String? createdOn;
  dynamic isClosedOrCompleted;
  String? previousTaskId;
  String? paymentSaleCycleId;
  String? dateOfVisit;
  String? timeOfVisit;
  String? accountOwner;
  String? branchHeadValue;
  String? clustureHeadValue;
  String? postCode;
  String? district;
  String? companyProfileType;
  String? accountOwnerFullName;
  String? productCategory;
  String? approvedFullName;
  String? createdFullName;
  String? alongWithPersonName;

  CallDashboardUserWiseDataModel(
      {this.condition,
        this.totalRows,
        this.taskId,
        this.typeOfCall,
        this.methodOfCall,
        this.accountCode,
        this.accountName,
        this.contactCode,
        this.contactName,
        this.taskStatus,
        this.lastActivityStatus,
        this.lastActivityUpdatedBy,
        this.lastActivityUpdatedOn,
        this.taskDueDate,
        this.taskDueTime,
        this.taskRemarks,
        this.purposeOfVisit,
        this.isInfraLead,
        this.infraLeadNo,
        this.userRegion,
        this.userClusture,
        this.nameOfInfraDepartment,
        this.executiveEngineer,
        this.assistantEngineer,
        this.projectName,
        this.location,
        this.timePeriodToCompleteCivilWorkInMonths,
        this.expectedDateOfCompletion,
        this.projectValue,
        this.expectedRevenue,
        this.furnitureIncludedInCivilScope,
        this.customerName,
        this.contactPersonDecisionMaker,
        this.nameOfAgencyContrator,
        this.ownerOfContractor,
        this.projectSiteManager,
        this.nameOfArchitectFirm,
        this.architect,
        this.drawingCollected,
        this.dateDrawingReceived,
        this.proposalSubmitted,
        this.dateOfProposalSubmission,
        this.valueOfQuote,
        this.expectedDateOfOrder,
        this.inaugrationDateOfProject,
        this.isSalesCycleActive,
        this.salesCycleActivatedBy,
        this.salesCycleActivatedOn,
        this.salesCycleId,
        this.approvedBy,
        this.finalApprovedBy,
        this.approvedOn,
        this.rejectReason,
        this.reopenRemarks,
        this.managerRemarks,
        this.createdBy,
        this.createdOn,
        this.isClosedOrCompleted,
        this.previousTaskId,
        this.paymentSaleCycleId,
        this.dateOfVisit,
        this.timeOfVisit,
        this.accountOwner,
        this.branchHeadValue,
        this.clustureHeadValue,
        this.postCode,
        this.district,
        this.companyProfileType,
        this.accountOwnerFullName,
        this.productCategory,
        this.approvedFullName,
        this.createdFullName,
        this.alongWithPersonName});

  CallDashboardUserWiseDataModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    totalRows = json['total_rows'];
    taskId = json['task_id'];
    typeOfCall = json['type_of_call'];
    methodOfCall = json['method_of_call'];
    accountCode = json['account_code'];
    accountName = json['account_name'];
    contactCode = json['contact_code'];
    contactName = json['contact_name'];
    taskStatus = json['task_status'];
    lastActivityStatus = json['last_activity_status'];
    lastActivityUpdatedBy = json['last_activity_updated_by'];
    lastActivityUpdatedOn = json['last_activity_updated_on'];
    taskDueDate = json['task_due_date'];
    taskDueTime = json['task_due_time'];
    taskRemarks = json['task_remarks'];
    purposeOfVisit = json['purpose_of_visit'];
    isInfraLead = json['is_infra_lead'];
    infraLeadNo = json['infra_lead_no'];
    userRegion = json['user_region'];
    userClusture = json['user_clusture'];
    nameOfInfraDepartment = json['name_of_infra_department'];
    executiveEngineer = json['executive_engineer'];
    assistantEngineer = json['assistant_engineer'];
    projectName = json['project_name'];
    location = json['location'];
    timePeriodToCompleteCivilWorkInMonths =
    json['time_period_to_complete_civil_work_in_months'];
    expectedDateOfCompletion = json['expected_date_of_completion'];
    projectValue = json['project_value'];
    expectedRevenue = json['expected_revenue'];
    furnitureIncludedInCivilScope = json['furniture_included_in_civil_scope'];
    customerName = json['customer_name'];
    contactPersonDecisionMaker = json['contact_person_decision_maker'];
    nameOfAgencyContrator = json['name_of_agency_contrator'];
    ownerOfContractor = json['owner_of_contractor'];
    projectSiteManager = json['project_site_manager'];
    nameOfArchitectFirm = json['name_of_architect_firm'];
    architect = json['architect'];
    drawingCollected = json['drawing_collected'];
    dateDrawingReceived = json['date_drawing_received'];
    proposalSubmitted = json['proposal_submitted'];
    dateOfProposalSubmission = json['date_of_proposal_submission'];
    valueOfQuote = json['value_of_quote'];
    expectedDateOfOrder = json['expected_date_of_order'];
    inaugrationDateOfProject = json['inaugration_date_of_project'];
    isSalesCycleActive = json['is_sales_cycle_active'];
    salesCycleActivatedBy = json['sales_cycle_activated_by'];
    salesCycleActivatedOn = json['sales_cycle_activated_on'];
    salesCycleId = json['sales_cycle_id'];
    approvedBy = json['approved_by'];
    finalApprovedBy = json['final_approved_by'];
    approvedOn = json['approved_on'];
    rejectReason = json['reject_reason'];
    reopenRemarks = json['reopen_remarks'];
    managerRemarks = json['manager_remarks'];
    createdBy = json['created_by'];
    createdOn = json['created_on'];
    isClosedOrCompleted = json['is_closed_or_completed'];
    previousTaskId = json['previous_task_id'];
    paymentSaleCycleId = json['payment_sale_cycle_id'];
    dateOfVisit = json['date_of_visit'];
    timeOfVisit = json['time_of_visit'];
    accountOwner = json['account_owner'];
    branchHeadValue = json['branch_head_value'];
    clustureHeadValue = json['clusture_head_value'];
    postCode = json['post_code'];
    district = json['district'];
    companyProfileType = json['company_profile_type'];
    accountOwnerFullName = json['account_owner_full_name'];
    productCategory = json['product_category'];
    approvedFullName = json['approved_full_name'];
    createdFullName = json['created_full_name'];
    alongWithPersonName = json['along_with_person_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['total_rows'] = this.totalRows;
    data['task_id'] = this.taskId;
    data['type_of_call'] = this.typeOfCall;
    data['method_of_call'] = this.methodOfCall;
    data['account_code'] = this.accountCode;
    data['account_name'] = this.accountName;
    data['contact_code'] = this.contactCode;
    data['contact_name'] = this.contactName;
    data['task_status'] = this.taskStatus;
    data['last_activity_status'] = this.lastActivityStatus;
    data['last_activity_updated_by'] = this.lastActivityUpdatedBy;
    data['last_activity_updated_on'] = this.lastActivityUpdatedOn;
    data['task_due_date'] = this.taskDueDate;
    data['task_due_time'] = this.taskDueTime;
    data['task_remarks'] = this.taskRemarks;
    data['purpose_of_visit'] = this.purposeOfVisit;
    data['is_infra_lead'] = this.isInfraLead;
    data['infra_lead_no'] = this.infraLeadNo;
    data['user_region'] = this.userRegion;
    data['user_clusture'] = this.userClusture;
    data['name_of_infra_department'] = this.nameOfInfraDepartment;
    data['executive_engineer'] = this.executiveEngineer;
    data['assistant_engineer'] = this.assistantEngineer;
    data['project_name'] = this.projectName;
    data['location'] = this.location;
    data['time_period_to_complete_civil_work_in_months'] =
        this.timePeriodToCompleteCivilWorkInMonths;
    data['expected_date_of_completion'] = this.expectedDateOfCompletion;
    data['project_value'] = this.projectValue;
    data['expected_revenue'] = this.expectedRevenue;
    data['furniture_included_in_civil_scope'] =
        this.furnitureIncludedInCivilScope;
    data['customer_name'] = this.customerName;
    data['contact_person_decision_maker'] = this.contactPersonDecisionMaker;
    data['name_of_agency_contrator'] = this.nameOfAgencyContrator;
    data['owner_of_contractor'] = this.ownerOfContractor;
    data['project_site_manager'] = this.projectSiteManager;
    data['name_of_architect_firm'] = this.nameOfArchitectFirm;
    data['architect'] = this.architect;
    data['drawing_collected'] = this.drawingCollected;
    data['date_drawing_received'] = this.dateDrawingReceived;
    data['proposal_submitted'] = this.proposalSubmitted;
    data['date_of_proposal_submission'] = this.dateOfProposalSubmission;
    data['value_of_quote'] = this.valueOfQuote;
    data['expected_date_of_order'] = this.expectedDateOfOrder;
    data['inaugration_date_of_project'] = this.inaugrationDateOfProject;
    data['is_sales_cycle_active'] = this.isSalesCycleActive;
    data['sales_cycle_activated_by'] = this.salesCycleActivatedBy;
    data['sales_cycle_activated_on'] = this.salesCycleActivatedOn;
    data['sales_cycle_id'] = this.salesCycleId;
    data['approved_by'] = this.approvedBy;
    data['final_approved_by'] = this.finalApprovedBy;
    data['approved_on'] = this.approvedOn;
    data['reject_reason'] = this.rejectReason;
    data['reopen_remarks'] = this.reopenRemarks;
    data['manager_remarks'] = this.managerRemarks;
    data['created_by'] = this.createdBy;
    data['created_on'] = this.createdOn;
    data['is_closed_or_completed'] = this.isClosedOrCompleted;
    data['previous_task_id'] = this.previousTaskId;
    data['payment_sale_cycle_id'] = this.paymentSaleCycleId;
    data['date_of_visit'] = this.dateOfVisit;
    data['time_of_visit'] = this.timeOfVisit;
    data['account_owner'] = this.accountOwner;
    data['branch_head_value'] = this.branchHeadValue;
    data['clusture_head_value'] = this.clustureHeadValue;
    data['post_code'] = this.postCode;
    data['district'] = this.district;
    data['company_profile_type'] = this.companyProfileType;
    data['account_owner_full_name'] = this.accountOwnerFullName;
    data['product_category'] = this.productCategory;
    data['approved_full_name'] = this.approvedFullName;
    data['created_full_name'] = this.createdFullName;
    data['along_with_person_name'] = this.alongWithPersonName;
    return data;
  }
}