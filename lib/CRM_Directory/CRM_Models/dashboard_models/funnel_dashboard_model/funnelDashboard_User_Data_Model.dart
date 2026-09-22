class funnelDashboardDataListModel {
  String? condition;
  String? totalRows;
  String? salesCycleId;
  String? taskId;
  String? accountCode;
  String? accountName;
  String? contactCode;
  String? contactName;
  String? salesCycleOwner;
  String? salesCycleStatus;
  String? salesCycleApprovalStatus;
  String? salesCycleRemarks;
  String? approvedBy;
  String? finalApprovedBy;
  String? approvedOn;
  String? rejectReason;
  String? createdBy;
  String? createdOn;
  dynamic noOfQuotation;
  String? estClosureDate;
  dynamic budgetAmount;
  dynamic estBudgetAmount;
  dynamic isCustomerNeedIdentify;
  String? proposedSolution;
  dynamic isSolutionAccepted;
  String? solutionRejectedRemarks;
  String? reopenRemarks;
  String? quoteAccepted;
  String? competitorName;
  String? quoteRejectedReason;
  String? wonQuoteId;
  dynamic isSalesCycleClosed;
  String? updatedBy;
  String? updatedOn;
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
  dynamic isDecisionMaker;
  String? purchaseProcess;
  String? purchaseTimeFrame;
  dynamic commit;
  dynamic quoteSubmitted;
  dynamic confirmDecisionDate;
  dynamic confirmExpectedRevenue;
  double? crmWonOrderValue;
  String? wonBy;
  String? wonOn;
  String? accountOwner;
  String? branchHeadValue;
  String? clustureHeadValue;
  String? postCode;
  String? district;
  String? companyProfileType;
  dynamic estimatedAmount;
  String? accountOwnerFullName;
  String? productCategory;
  String? parentProductCategory;
  String? approvedFullName;
  String? createdFullName;
  String? salesCycleOwnerName;
  String? alongWithPersonName;

  funnelDashboardDataListModel(
      {this.condition,
        this.totalRows,
        this.salesCycleId,
        this.taskId,
        this.accountCode,
        this.accountName,
        this.contactCode,
        this.contactName,
        this.salesCycleOwner,
        this.salesCycleStatus,
        this.salesCycleApprovalStatus,
        this.salesCycleRemarks,
        this.approvedBy,
        this.finalApprovedBy,
        this.approvedOn,
        this.rejectReason,
        this.createdBy,
        this.createdOn,
        this.noOfQuotation,
        this.estClosureDate,
        this.budgetAmount,
        this.estBudgetAmount,
        this.isCustomerNeedIdentify,
        this.proposedSolution,
        this.isSolutionAccepted,
        this.solutionRejectedRemarks,
        this.reopenRemarks,
        this.quoteAccepted,
        this.competitorName,
        this.quoteRejectedReason,
        this.wonQuoteId,
        this.isSalesCycleClosed,
        this.updatedBy,
        this.updatedOn,
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
        this.isDecisionMaker,
        this.purchaseProcess,
        this.purchaseTimeFrame,
        this.commit,
        this.quoteSubmitted,
        this.confirmDecisionDate,
        this.confirmExpectedRevenue,
        this.crmWonOrderValue,
        this.wonBy,
        this.wonOn,
        this.accountOwner,
        this.branchHeadValue,
        this.clustureHeadValue,
        this.postCode,
        this.district,
        this.companyProfileType,
        this.estimatedAmount,
        this.accountOwnerFullName,
        this.productCategory,
        this.parentProductCategory,
        this.approvedFullName,
        this.createdFullName,
        this.salesCycleOwnerName,
        this.alongWithPersonName});

  funnelDashboardDataListModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    totalRows = json['total_rows'];
    salesCycleId = json['sales_cycle_id'];
    taskId = json['task_id'];
    accountCode = json['account_code'];
    accountName = json['account_name'];
    contactCode = json['contact_code'];
    contactName = json['contact_name'];
    salesCycleOwner = json['sales_cycle_owner'];
    salesCycleStatus = json['sales_cycle_status'];
    salesCycleApprovalStatus = json['sales_cycle_approval_status'];
    salesCycleRemarks = json['sales_cycle_remarks'];
    approvedBy = json['approved_by'];
    finalApprovedBy = json['final_approved_by'];
    approvedOn = json['approved_on'];
    rejectReason = json['reject_reason'];
    createdBy = json['created_by'];
    createdOn = json['created_on'];
    noOfQuotation = json['no_of_quotation'];
    estClosureDate = json['est_closure_date'];
    budgetAmount = json['budget_amount'];
    estBudgetAmount = json['est_budget_amount'];
    isCustomerNeedIdentify = json['is_customer_need_identify'];
    proposedSolution = json['proposed_solution'];
    isSolutionAccepted = json['is_solution_accepted'];
    solutionRejectedRemarks = json['solution_rejected_remarks'];
    reopenRemarks = json['reopen_remarks'];
    quoteAccepted = json['quote_accepted'];
    competitorName = json['competitor_name'];
    quoteRejectedReason = json['quote_rejected_reason'];
    wonQuoteId = json['won_quote_id'];
    isSalesCycleClosed = json['is_sales_cycle_closed'];
    updatedBy = json['updated_by'];
    updatedOn = json['updated_on'];
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
    isDecisionMaker = json['is_decision_maker'];
    purchaseProcess = json['purchase_process'];
    purchaseTimeFrame = json['purchase_time_frame'];
    commit = json['commit'];
    quoteSubmitted = json['quote_submitted'];
    confirmDecisionDate = json['confirm_decision_date'];
    confirmExpectedRevenue = json['confirm_expected_revenue'];
    crmWonOrderValue = json['crm_won_order_value'];
    wonBy = json['won_by'];
    wonOn = json['won_on'];
    accountOwner = json['account_owner'];
    branchHeadValue = json['branch_head_value'];
    clustureHeadValue = json['clusture_head_value'];
    postCode = json['post_code'];
    district = json['district'];
    companyProfileType = json['company_profile_type'];
    estimatedAmount = json['estimated_amount'];
    accountOwnerFullName = json['account_owner_full_name'];
    productCategory = json['product_category'];
    parentProductCategory = json['parent_product_category'];
    approvedFullName = json['approved_full_name'];
    createdFullName = json['created_full_name'];
    salesCycleOwnerName = json['sales_cycle_owner_name'];
    alongWithPersonName = json['along_with_person_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['total_rows'] = this.totalRows;
    data['sales_cycle_id'] = this.salesCycleId;
    data['task_id'] = this.taskId;
    data['account_code'] = this.accountCode;
    data['account_name'] = this.accountName;
    data['contact_code'] = this.contactCode;
    data['contact_name'] = this.contactName;
    data['sales_cycle_owner'] = this.salesCycleOwner;
    data['sales_cycle_status'] = this.salesCycleStatus;
    data['sales_cycle_approval_status'] = this.salesCycleApprovalStatus;
    data['sales_cycle_remarks'] = this.salesCycleRemarks;
    data['approved_by'] = this.approvedBy;
    data['final_approved_by'] = this.finalApprovedBy;
    data['approved_on'] = this.approvedOn;
    data['reject_reason'] = this.rejectReason;
    data['created_by'] = this.createdBy;
    data['created_on'] = this.createdOn;
    data['no_of_quotation'] = this.noOfQuotation;
    data['est_closure_date'] = this.estClosureDate;
    data['budget_amount'] = this.budgetAmount;
    data['est_budget_amount'] = this.estBudgetAmount;
    data['is_customer_need_identify'] = this.isCustomerNeedIdentify;
    data['proposed_solution'] = this.proposedSolution;
    data['is_solution_accepted'] = this.isSolutionAccepted;
    data['solution_rejected_remarks'] = this.solutionRejectedRemarks;
    data['reopen_remarks'] = this.reopenRemarks;
    data['quote_accepted'] = this.quoteAccepted;
    data['competitor_name'] = this.competitorName;
    data['quote_rejected_reason'] = this.quoteRejectedReason;
    data['won_quote_id'] = this.wonQuoteId;
    data['is_sales_cycle_closed'] = this.isSalesCycleClosed;
    data['updated_by'] = this.updatedBy;
    data['updated_on'] = this.updatedOn;
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
    data['is_decision_maker'] = this.isDecisionMaker;
    data['purchase_process'] = this.purchaseProcess;
    data['purchase_time_frame'] = this.purchaseTimeFrame;
    data['commit'] = this.commit;
    data['quote_submitted'] = this.quoteSubmitted;
    data['confirm_decision_date'] = this.confirmDecisionDate;
    data['confirm_expected_revenue'] = this.confirmExpectedRevenue;
    data['crm_won_order_value'] = this.crmWonOrderValue;
    data['won_by'] = this.wonBy;
    data['won_on'] = this.wonOn;
    data['account_owner'] = this.accountOwner;
    data['branch_head_value'] = this.branchHeadValue;
    data['clusture_head_value'] = this.clustureHeadValue;
    data['post_code'] = this.postCode;
    data['district'] = this.district;
    data['company_profile_type'] = this.companyProfileType;
    data['estimated_amount'] = this.estimatedAmount;
    data['account_owner_full_name'] = this.accountOwnerFullName;
    data['product_category'] = this.productCategory;
    data['parent_product_category'] = this.parentProductCategory;
    data['approved_full_name'] = this.approvedFullName;
    data['created_full_name'] = this.createdFullName;
    data['sales_cycle_owner_name'] = this.salesCycleOwnerName;
    data['along_with_person_name'] = this.alongWithPersonName;
    return data;
  }
}