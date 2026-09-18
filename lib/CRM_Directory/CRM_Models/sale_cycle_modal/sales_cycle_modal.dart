class SalesCycleModal {
  String? condition;
  String? totalRows;
  String? salesCycleId;
  String? taskId;
  String? accountCode;
  String? accountName;
  String? contactCode;
  String? contactName;
  String? productCategory;
  String? productCategoryCode;
  String? infraProductCategoryCode;
  String? infraProductCategoryName;
  String? salesCycleStatus;
  String? salesCycleApprovalStatus;
  String? salesCycleRemarks;
  String? approvedBy;
  String? approvedFullName;
  String? finalApprovedFullName;
  String? approvedOn;
  String? rejectReason;
  String? createdBy;
  String? createdFullName;
  String? createdOn;
  String? salesCycleOwnerName;
  String? salesCycleOwner;
  int? noOfQuotation;
  String? estClosureDate;
  double? budgetAmount;
  double? estBudgetAmount;
  int? isCustomerNeedIdentify;
  String? proposedSolution;
  String? quoteAccepted;
  String? competitorName;
  String? quoteRejectedReason;
  int? isSolutionAccepted;
  String? solutionRejectedRemarks;
  String? reopenRemarks;
  String? wonQuoteId;
  int? isSalesCycleClosed;
  int? isInfraLead;
  String? infraLeadNo;
  String? userRegion;
  String? userClusture;
  String? nameOfInfraDepartment;
  String? executiveEngineer;
  String? assistantEngineer;
  String? projectName;
  String? location;
  int? timePeriodToCompleteCivilWorkInMonths;
  String? expectedDateOfCompletion;
  double? projectValue;
  double? expectedRevenue;
  int? furnitureIncludedInCivilScope;
  String? customerName;
  String? contactPersonDecisionMaker;
  String? nameOfAgencyContrator;
  String? ownerOfContractor;
  String? projectSiteManager;
  String? nameOfArchitectFirm;
  String? architect;
  int? drawingCollected;
  String? dateDrawingReceived;
  int? proposalSubmitted;
  String? dateOfProposalSubmission;
  double? valueOfQuote;
  String? expectedDateOfOrder;
  String? inaugrationDateOfProject;
  String? updatedBy;
  String? updatedOn;
  int? isReadyForApprove;
  int? isReadySendForApproval;
  String? actualSalesCycleApprovalStatus;
  String? shippingAddress;
  String? shippingAddress2;
  String? shippingCity;
  String? shippingDistrict;
  String? shippingPostCode;
  String? shippingStateCode;
  String? shippingStateName;
  String? shippingPhoneNo;
  String? shippingEmailId;
  int? isDecisionMaker;
  String? purchaseProcess;
  String? purchaseTimeFrame;
  int? commit;
  int? quoteSubmitted;
  int? confirmDecisionDate;
  int? confirmExpectedRevenue;
  dynamic? crmWonOrderValue;
  String? wonBy;
  String? wonOn;
  int? isMarkRateContract;
  String? frontlinerValue;
  String? branchHeadValue;
  String? zoneHeadValue;
  String? clustureHeadValue;
  String? companyProfileType;
  String? postCode;
  String? district;
  String? actualNameOfInfraDepartment;
  String? actualCustomerName;
  String? actualNameOfAgencyContrator;
  String? actualNameOfArchitectFirm;
  String? actualExecutiveEngineer;
  String? actualAssistantEngineer;
  String? actualContactPersonDecisionMaker;
  String? actualOwnerOfContractor;
  String? actualProjectSiteManager;
  String? actualArchitect;

  SalesCycleModal(
      {this.condition,
        this.totalRows,
        this.salesCycleId,
        this.taskId,
        this.accountCode,
        this.accountName,
        this.contactCode,
        this.contactName,
        this.productCategory,
        this.productCategoryCode,
        this.infraProductCategoryCode,
        this.infraProductCategoryName,
        this.salesCycleStatus,
        this.salesCycleApprovalStatus,
        this.salesCycleRemarks,
        this.approvedBy,
        this.approvedFullName,
        this.finalApprovedFullName,
        this.approvedOn,
        this.rejectReason,
        this.createdBy,
        this.createdFullName,
        this.createdOn,
        this.salesCycleOwnerName,
        this.salesCycleOwner,
        this.noOfQuotation,
        this.estClosureDate,
        this.budgetAmount,
        this.estBudgetAmount,
        this.isCustomerNeedIdentify,
        this.proposedSolution,
        this.quoteAccepted,
        this.competitorName,
        this.quoteRejectedReason,
        this.isSolutionAccepted,
        this.solutionRejectedRemarks,
        this.reopenRemarks,
        this.wonQuoteId,
        this.isSalesCycleClosed,
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
        this.updatedBy,
        this.updatedOn,
        this.isReadyForApprove,
        this.isReadySendForApproval,
        this.actualSalesCycleApprovalStatus,
        this.shippingAddress,
        this.shippingAddress2,
        this.shippingCity,
        this.shippingDistrict,
        this.shippingPostCode,
        this.shippingStateCode,
        this.shippingStateName,
        this.shippingPhoneNo,
        this.shippingEmailId,
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
        this.isMarkRateContract,
        this.frontlinerValue,
        this.branchHeadValue,
        this.zoneHeadValue,
        this.clustureHeadValue,
        this.companyProfileType,
        this.postCode,
        this.district,
        this.actualNameOfInfraDepartment,
        this.actualCustomerName,
        this.actualNameOfAgencyContrator,
        this.actualNameOfArchitectFirm,
        this.actualExecutiveEngineer,
        this.actualAssistantEngineer,
        this.actualContactPersonDecisionMaker,
        this.actualOwnerOfContractor,
        this.actualProjectSiteManager,
        this.actualArchitect});

  SalesCycleModal.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    totalRows = json['total_rows'];
    salesCycleId = json['sales_cycle_id'];
    taskId = json['task_id'];
    accountCode = json['account_code'];
    accountName = json['account_name'];
    contactCode = json['contact_code'];
    contactName = json['contact_name'];
    productCategory = json['product_category'];
    productCategoryCode = json['product_category_code'];
    infraProductCategoryCode = json['infra_product_category_code'];
    infraProductCategoryName = json['infra_product_category_name'];
    salesCycleStatus = json['sales_cycle_status'];
    salesCycleApprovalStatus = json['sales_cycle_approval_status'];
    salesCycleRemarks = json['sales_cycle_remarks'];
    approvedBy = json['approved_by'];
    approvedFullName = json['approved_full_name'];
    finalApprovedFullName = json['final_approved_full_name'];
    approvedOn = json['approved_on'];
    rejectReason = json['reject_reason'];
    createdBy = json['created_by'];
    createdFullName = json['created_full_name'];
    createdOn = json['created_on'];
    salesCycleOwnerName = json['sales_cycle_owner_name'];
    salesCycleOwner = json['sales_cycle_owner'];
    noOfQuotation = json['no_of_quotation'];
    estClosureDate = json['est_closure_date'];
    budgetAmount = json['budget_amount'];
    estBudgetAmount = json['est_budget_amount'];
    isCustomerNeedIdentify = json['is_customer_need_identify'];
    proposedSolution = json['proposed_solution'];
    quoteAccepted = json['quote_accepted'];
    competitorName = json['competitor_name'];
    quoteRejectedReason = json['quote_rejected_reason'];
    isSolutionAccepted = json['is_solution_accepted'];
    solutionRejectedRemarks = json['solution_rejected_remarks'];
    reopenRemarks = json['reopen_remarks'];
    wonQuoteId = json['won_quote_id'];
    isSalesCycleClosed = json['is_sales_cycle_closed'];
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
    updatedBy = json['updated_by'];
    updatedOn = json['updated_on'];
    isReadyForApprove = json['is_ready_for_approve'];
    isReadySendForApproval = json['is_ready_send_for_approval'];
    actualSalesCycleApprovalStatus = json['actual_sales_cycle_approval_status'];
    shippingAddress = json['shipping_address'];
    shippingAddress2 = json['shipping_address2'];
    shippingCity = json['shipping_city'];
    shippingDistrict = json['shipping_district'];
    shippingPostCode = json['shipping_post_code'];
    shippingStateCode = json['shipping_state_code'];
    shippingStateName = json['shipping_state_name'];
    shippingPhoneNo = json['shipping_phone_no'];
    shippingEmailId = json['shipping_email_id'];
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
    isMarkRateContract = json['is_mark_rate_contract'];
    frontlinerValue = json['frontliner_value'];
    branchHeadValue = json['branch_head_value'];
    zoneHeadValue = json['zone_head_value'];
    clustureHeadValue = json['clusture_head_value'];
    companyProfileType = json['company_profile_type'];
    postCode = json['post_code'];
    district = json['district'];
    actualNameOfInfraDepartment = json['actual_name_of_infra_department'];
    actualCustomerName = json['actual_customer_name'];
    actualNameOfAgencyContrator = json['actual_name_of_agency_contrator'];
    actualNameOfArchitectFirm = json['actual_name_of_architect_firm'];
    actualExecutiveEngineer = json['actual_executive_engineer'];
    actualAssistantEngineer = json['actual_assistant_engineer'];
    actualContactPersonDecisionMaker = json['actual_contact_person_decision_maker'];
    actualOwnerOfContractor = json['actual_owner_of_contractor'];
    actualProjectSiteManager = json['actual_project_site_manager'];
    actualArchitect = json['actual_architect'];
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
    data['product_category'] = this.productCategory;
    data['product_category_code'] = this.productCategoryCode;
    data['infra_product_category_code'] = this.infraProductCategoryCode;
    data['infra_product_category_name'] = this.infraProductCategoryName;
    data['sales_cycle_status'] = this.salesCycleStatus;
    data['sales_cycle_approval_status'] = this.salesCycleApprovalStatus;
    data['sales_cycle_remarks'] = this.salesCycleRemarks;
    data['approved_by'] = this.approvedBy;
    data['approved_full_name'] = this.approvedFullName;
    data['final_approved_full_name'] = this.finalApprovedFullName;
    data['approved_on'] = this.approvedOn;
    data['reject_reason'] = this.rejectReason;
    data['created_by'] = this.createdBy;
    data['created_full_name'] = this.createdFullName;
    data['created_on'] = this.createdOn;
    data['sales_cycle_owner_name'] = this.salesCycleOwnerName;
    data['sales_cycle_owner'] = this.salesCycleOwner;
    data['no_of_quotation'] = this.noOfQuotation;
    data['est_closure_date'] = this.estClosureDate;
    data['budget_amount'] = this.budgetAmount;
    data['est_budget_amount'] = this.estBudgetAmount;
    data['is_customer_need_identify'] = this.isCustomerNeedIdentify;
    data['proposed_solution'] = this.proposedSolution;
    data['quote_accepted'] = this.quoteAccepted;
    data['competitor_name'] = this.competitorName;
    data['quote_rejected_reason'] = this.quoteRejectedReason;
    data['is_solution_accepted'] = this.isSolutionAccepted;
    data['solution_rejected_remarks'] = this.solutionRejectedRemarks;
    data['reopen_remarks'] = this.reopenRemarks;
    data['won_quote_id'] = this.wonQuoteId;
    data['is_sales_cycle_closed'] = this.isSalesCycleClosed;
    data['is_infra_lead'] = this.isInfraLead;
    data['infra_lead_no'] = this.infraLeadNo;
    data['user_region'] = this.userRegion;
    data['user_clusture'] = this.userClusture;
    data['name_of_infra_department'] = this.nameOfInfraDepartment;
    data['executive_engineer'] = this.executiveEngineer;
    data['assistant_engineer'] = this.assistantEngineer;
    data['project_name'] = this.projectName;
    data['location'] = this.location;
    data['time_period_to_complete_civil_work_in_months'] = this.timePeriodToCompleteCivilWorkInMonths;
    data['expected_date_of_completion'] = this.expectedDateOfCompletion;
    data['project_value'] = this.projectValue;
    data['expected_revenue'] = this.expectedRevenue;
    data['furniture_included_in_civil_scope'] = this.furnitureIncludedInCivilScope;
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
    data['updated_by'] = this.updatedBy;
    data['updated_on'] = this.updatedOn;
    data['is_ready_for_approve'] = this.isReadyForApprove;
    data['is_ready_send_for_approval'] = this.isReadySendForApproval;
    data['actual_sales_cycle_approval_status'] = this.actualSalesCycleApprovalStatus;
    data['shipping_address'] = this.shippingAddress;
    data['shipping_address2'] = this.shippingAddress2;
    data['shipping_city'] = this.shippingCity;
    data['shipping_district'] = this.shippingDistrict;
    data['shipping_post_code'] = this.shippingPostCode;
    data['shipping_state_code'] = this.shippingStateCode;
    data['shipping_state_name'] = this.shippingStateName;
    data['shipping_phone_no'] = this.shippingPhoneNo;
    data['shipping_email_id'] = this.shippingEmailId;
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
    data['is_mark_rate_contract'] = this.isMarkRateContract;
    data['frontliner_value'] = this.frontlinerValue;
    data['branch_head_value'] = this.branchHeadValue;
    data['zone_head_value'] = this.zoneHeadValue;
    data['clusture_head_value'] = this.clustureHeadValue;
    data['company_profile_type'] = this.companyProfileType;
    data['post_code'] = this.postCode;
    data['district'] = this.district;
    data['actual_name_of_infra_department'] = this.actualNameOfInfraDepartment;
    data['actual_customer_name'] = this.actualCustomerName;
    data['actual_name_of_agency_contrator'] = this.actualNameOfAgencyContrator;
    data['actual_name_of_architect_firm'] = this.actualNameOfArchitectFirm;
    data['actual_executive_engineer'] = this.actualExecutiveEngineer;
    data['actual_assistant_engineer'] = this.actualAssistantEngineer;
    data['actual_contact_person_decision_maker'] = this.actualContactPersonDecisionMaker;
    data['actual_owner_of_contractor'] = this.actualOwnerOfContractor;
    data['actual_project_site_manager'] = this.actualProjectSiteManager;
    data['actual_architect'] = this.actualArchitect;
    return data;
  }
}