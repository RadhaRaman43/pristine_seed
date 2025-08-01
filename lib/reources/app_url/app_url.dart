class AppUrl {
  /*static const String BASE_URL="https://dev4.pristinefulfil.com";
  static const String login_url="$BASE_URL/api/UserLogin/Login";*/
  // static const String BASE_URL="https://mahalaxmi.pristinefulfil.com";
   //todo testing url...
     static const String BASE_URL = "https://devlogin.pristinefulfil.com";
    //todo live url....
       //static const String BASE_URL = "https://care.pristinefulfil.com";

  static const String login_url = "$BASE_URL/api/UserLogin/Login";
  static const String logout_url = "$BASE_URL/api/UserLogin/Logout";
  static const String employeeGet = "$BASE_URL/api/Employee/EmployeeDetailGet";
  static const String forget_pass_url = "$BASE_URL/api/UserLogin/ResetPasswordOTPSend";
  static const String getCollectionList = "$BASE_URL/api/Collection/GetCollectionData";
  static const String profile_upload="$BASE_URL/api/UserLogin/ProfileUpload";
  static const String notification_list="$BASE_URL/api/PushNofication/GetNotificationList";

  //todo for installation......
  static const String serviceInstallationData = "$BASE_URL/api/ServiceActivity/ServiceMstGetDashbord";
  static const String serviceInstallationListData = "$BASE_URL/api/ServiceActivity/ServiceMstGet";
  static const String serviceInstallationDetailsGet = "$BASE_URL/api/ServiceActivity/ServiceMstDetailGet";
  static const String reasonMasterGet = "$BASE_URL/api/Master/ReasonMasterAll";
  static const String itemDetailsGet = "$BASE_URL/api/ItemMaster/ItemComponentMstGet";
  static const String itemNoGet = "$BASE_URL/api/ServiceIndent/IndentLineItemGet";
  static const String reAssignment = "$BASE_URL/api/ServiceActivity/ServiceMarkReassignment";
  static const String reSchedule = "$BASE_URL/api/ServiceActivity/ServiceMarkRescheduled";
  static const String serviceMarkVisit = "$BASE_URL/api/ServiceActivity/ServiceMarkVisit";
  static const String installationCertificateImage = "$BASE_URL/api/ServiceActivity/ServiceUploadDocument";
  static const String installationMarkCompleted = "$BASE_URL/api/ServiceActivity/ServiceMarkCompleted";
  static const String installationDeleteDocument = "$BASE_URL/api/ServiceActivity/ServiceUploadDocumentDelete";


  //todo for service indent....

  static const String serviceIndentGet = "$BASE_URL/api/ServiceIndent/IndentHeaderListGet";
  static const String serviceIndentHeaderCreate = "$BASE_URL/api/ServiceIndent/IndentHeaderCreate";
  static const String serviceIndentLineCreate = "$BASE_URL/api/ServiceIndent/IndentLineAdd";
  static const String serviceIndentLineAndHeader = "$BASE_URL/api/ServiceIndent/IndentHeaderLineDiscard";
  static const String serviceIndentHeader = "$BASE_URL/api/ServiceIndent/IndentHeaderComplete";
  static const String serviceIndentConsumerLineMark = "$BASE_URL/api/ServiceIndent/IndentLineConsumeMark";
  static const String serviceIndentConsumerHeaderMark = "$BASE_URL/api/ServiceIndent/IndentHeaderConsumeMark";
  static const String serviceOffSiteMarkClosure = "$BASE_URL/api/ServiceActivity/ServiceMarkOffsiteClosure";


  //todo for checkIn.......
  static const String vehileTypeGetInsert="$BASE_URL/api/Travel/VehicleTypeGet";
  static const String currentRunningCheckInData="$BASE_URL/api/Travel/CurrentRunningCheckInData";
  static const String getVehicleDetails="$BASE_URL/api/Travel/GetVehicleDetails";
  static const String get_employee_master="$BASE_URL/api/Employee/EmployeeMasterGet";
  static const String markCheckIn="$BASE_URL/api/Travel/MarkCheckIn";
  static const String markCheckOutSaveData="$BASE_URL/api/Travel/CheckOutDataSave";
  static const String checkOutComplete="$BASE_URL/api/Travel/CheckOutComplete";
  static const String userLocationInsert="$BASE_URL/api/Travel/UserLocationInsert";
  static const String expanseLineSaveSaveData="$BASE_URL/api/Travel/CheckOutLineExpenseSubmit";
   //todo for checkInApproval.........
  static const String employeeTeamMemberGet="$BASE_URL/api/Employee/EmployeeTeamMemberGet";
  static const String check_in_approverData="$BASE_URL/api/Travel/CheckInApproverGet";
  static const String CheckInMarkApprove="$BASE_URL/api/Travel/CheckInMarkApprove";

  //todo for service Corrective....

  static const String serviceCorrectiveListData = "$BASE_URL/api/ServiceActivity/ServiceMstGet";
  static const String serviceCorrectiveItemDetails = "$BASE_URL/api/ItemMaster/ItemComponentMstGet";
  static const String serviceCorrectiveDetailsGet = "$BASE_URL/api/ServiceActivity/ServiceMstDetailGet";
  static const String serviceCorrectiveMarkVisit = "$BASE_URL/api/ServiceActivity/ServiceMarkVisit";
  static const String serviceCorrectiveIndentGet = "$BASE_URL/api/ServiceIndent/IndentHeaderListGet";
  static const String serviceCorrectiveIndentHeaderCreate = "$BASE_URL/api/ServiceIndent/IndentHeaderCreate";
  static const String correctiveMarkCompleted = "$BASE_URL/api/ServiceActivity/ServiceMarkCompleted";
  static const String correctiveCertificateImage = "$BASE_URL/api/ServiceActivity/ServiceUploadDocument";
  static const String correctiveIndentConsumerHeaderMark = "$BASE_URL/api/ServiceIndent/IndentHeaderConsumeMark";
  static const String correctiveIndentHeader = "$BASE_URL/api/ServiceIndent/IndentHeaderComplete";
  static const String correctiveIndentLineAndHeader = "$BASE_URL/api/ServiceIndent/IndentHeaderLineDiscard";
  static const String correctiveitemNoGet = "$BASE_URL/api/ServiceIndent/IndentLineItemGet";
  static const String correctiveIndentConsumerLineMark = "$BASE_URL/api/ServiceIndent/IndentLineConsumeMark";
  static const String correctiveIndentLineCreate = "$BASE_URL/api/ServiceIndent/IndentLineAdd";
  static const String correctiveReasonMasterGet = "$BASE_URL/api/Master/ReasonMasterAll";
  static const String correctiveReSchedule = "$BASE_URL/api/ServiceActivity/ServiceMarkRescheduled";
  static const String correctiveReAssignment = "$BASE_URL/api/ServiceActivity/ServiceMarkReassignment";
  static const String correctiveOffSiteMarkClosure = "$BASE_URL/api/ServiceActivity/ServiceMarkOffsiteClosure";
     static const String correctiveDeleteDocument = "$BASE_URL/api/ServiceActivity/ServiceUploadDocumentDelete";

  //todo preventive for........
  static const String PreventiveitemDetailsGet = "$BASE_URL/api/ItemMaster/ItemComponentMstGet";
  static const String servicePreventiveListData = "$BASE_URL/api/ServiceActivity/ServiceMstGet";
  static const String servicePreventiveDetailsGet = "$BASE_URL/api/ServiceActivity/ServiceMstDetailGet";
  static const String preventiveReasonMasterGet = "$BASE_URL/api/Master/ReasonMasterAll";
  static const String preventiveServiceIndentGet = "$BASE_URL/api/ServiceIndent/IndentHeaderListGet";
  static const String preventiveServiceMarkVisit = "$BASE_URL/api/ServiceActivity/ServiceMarkVisit";
  static const String preventiveReAssignment = "$BASE_URL/api/ServiceActivity/ServiceMarkReassignment";
  static const String preventiveReSchedule = "$BASE_URL/api/ServiceActivity/ServiceMarkRescheduled";
  static const String preventiveServiceIndentHeaderCreate = "$BASE_URL/api/ServiceIndent/IndentHeaderCreate";
  static const String preventiveCertificateImage = "$BASE_URL/api/ServiceActivity/ServiceUploadDocument";
  static const String preventiveMarkCompleted = "$BASE_URL/api/ServiceActivity/ServiceMarkCompleted";
  static const String preventiveItemNoGet = "$BASE_URL/api/ServiceIndent/IndentLineItemGet";
  static const String preventiveServiceIndentConsumerLineMark = "$BASE_URL/api/ServiceIndent/IndentLineConsumeMark";
  static const String preventiveServiceIndentLineCreate = "$BASE_URL/api/ServiceIndent/IndentLineAdd";
  static const String preventiveServiceIndentLineAndHeader = "$BASE_URL/api/ServiceIndent/IndentHeaderLineDiscard";
  static const String preventiveServiceIndentConsumerHeaderMark = "$BASE_URL/api/ServiceIndent/IndentHeaderConsumeMark";
  static const String preventiveServiceIndentHeader = "$BASE_URL/api/ServiceIndent/IndentHeaderComplete";
  static const String createPreventiveCalender = "$BASE_URL/api/ServiceActivity/ServiceWarrantyCalanderGet";
  static const String createPreventiveCall = "$BASE_URL/api/ServiceActivity/ServiceWarrantyPreventiveCreate";
  static const String preventiveOffSiteMarkClosure = "$BASE_URL/api/ServiceActivity/ServiceMarkOffsiteClosure";
     static const String priventiveDeleteDocument = "$BASE_URL/api/ServiceActivity/ServiceUploadDocumentDelete";
  //todo for user expenses..................

  static const String getExpenseHeader="$BASE_URL/api/Expense/GetExpenseHeader";
  static const String getExpenseLines="$BASE_URL/api/Expense/GetExpenseLines";
  static const String getExpenseCatagory="$BASE_URL/api/Master/ExpenseCreate";
  static const String regionGet="$BASE_URL/api/GeographicalSetup/RegionGet";
  static const String expenseRegionGet="$BASE_URL/api/Expense/ExpenseRegionGet";
  static const String expenseCreate="$BASE_URL/api/Expense/ExpenseCreate";
  static const String expenseLinesSubmit="$BASE_URL/api/Expense/ExpenseLinesSubmit";
  static const String expenseComplete="$BASE_URL/api/Expense/ExpenseComplete";
  static const String expense_approverData="$BASE_URL/api/Expense/ExpenseApproverGet";
  static const String expenseMarkApprove="$BASE_URL/api/Expense/ExpenseMarkApprove";
  //todo show google map and rotes.........
  static const String getDateWiseUserCoordinate="$BASE_URL/api/Travel/GetDateWiseUserCoordinate";

  //todo return indent.....
 // static const String getReturnLocation="$BASE_URL/api/Master/GetLocationList";
  static const String getReturnLocation="$BASE_URL/api/ReturnIndent/GetReturnLocationList";
  static const String returnIndentHeaderCreate="$BASE_URL/api/ReturnIndent/ReturnIndentHeaderCreate";
  static const String returnIndentList="$BASE_URL/api/ReturnIndent/ReturnIndentHeaderListGet";
  static const String returnIndentItemWise="$BASE_URL/api/ReturnIndent/ReturnIndentGetItemWise";
  static const String returnIndentAddLine="$BASE_URL/api/ReturnIndent/ReturnIndentAddLine";
  static const String returnIndentLineDelete="$BASE_URL/api/ReturnIndent/ReturnIndentLineDiscard";
  static const String returnIndentHeaderDelete="$BASE_URL/api/ReturnIndent/ReturnIndentHeaderDiscard";
  static const String returnIndentHeaderComplete="$BASE_URL/api/ReturnIndent/ReturnIndentHeaderComplete";


  //todo order......

  static const String orderHeaderGet="$BASE_URL/api/Order/OrderHeaderGet";
  static const String orderDetailsGet="$BASE_URL/api/Order/OrderHeaderCreate";
  static const String orderItemCategoryGet="$BASE_URL/api/Order/OrderItemCategoryGet";
  static const String orderItemGet="$BASE_URL/api/Order/OrderItemGet";
  static const String orderLineInsert="$BASE_URL/api/Order/OrderLineInsert";
  static const String orderHeaderComplete="$BASE_URL/api/Order/OrderHeaderComplete";
  static const String customerGet="$BASE_URL/api/Customer/CustomerGet";
  static const String orderHeaderCreate="$BASE_URL/api/Order/OrderHeaderCreate";
  static const String orderApprovalGet="$BASE_URL/api/Order/OrderINApproverGet";
  static const String orderApprovalLineUpdate="$BASE_URL/api/Order/OrderApprovalLineUpdate";
  static const String OrderMarkApprove="$BASE_URL/api/Order/OrderMarkApprove";
  static const String getConsigneeMstGet="$BASE_URL/api/Customer/ConsigneeMstGet";

  //todo indentList...
  static const String indentListGet="$BASE_URL/api/ServiceIndent/ServiceIndentHeaderDataGet";
  static const String indentListHeaderGet = "$BASE_URL/api/ServiceIndent/IndentHeaderCreate";



  //todo Customer Complain...
  static const String customerRaiseComplain="$BASE_URL/api/ServiceActivity/ServiceMarkRaiseComplain";
  static const String getAllComplain="$BASE_URL/api/ServiceActivity/ServiceInatallationAllComplain";
  static const String getServiceComplainAddFilter="$BASE_URL/api/ServiceActivity/ServiceComplainAddFilterGet";
  static const String getServiceComplainAddList="$BASE_URL/api/ServiceActivity/ServiceComplainAddListGet";


  //todo Bulk Indent.....
     static const String bulkIndentList = "$BASE_URL/api/ServiceIndent/ServiceIndentHeaderDataGet";
     static const String bulkIndentHeaderCreate = "$BASE_URL/api/ServiceIndent/IndentHeaderCreate";
     static const String itemMasterGet = "$BASE_URL/api/ItemMaster/ItemMstGet";
     static const String bulkIndentLineCreate = "$BASE_URL/api/ServiceIndent/IndentLineAdd";
     static const String bulkIndentLineAndHeader = "$BASE_URL/api/ServiceIndent/IndentHeaderLineDiscard";
     static const String bulkIndentHeadercomplete = "$BASE_URL/api/ServiceIndent/IndentHeaderComplete";
     static const String bulkIndentConsumerHeaderMark = "$BASE_URL/api/ServiceIndent/IndentHeaderConsumeMark";
     static const String bulkIndentConsumerLineMark = "$BASE_URL/api/ServiceIndent/IndentLineConsumeMark";



     //todo service Inventory.....
     static const String serviceInventoryList= "$BASE_URL/api/ItemMaster/ServiceEngineerInventoryGet";
     static const String serviceInventoryListview= "$BASE_URL/api/ItemMaster/ServiceEngineerIndentWiseInventoryGet";



     //todo crm url.....



     //todo account Master repo....
     static const String AccountMstGet = "$BASE_URL/api/CRM/Account/AccountMstGet";
     static const String getMasterType = "$BASE_URL/api/CRM/Master/GetMasterType";
     static const String employeeMemberGet = "$BASE_URL/api/Employee/EmployeeTeamMemberGet";
     static const String CompanyProfileMstGet = "$BASE_URL/api/CRM/Master/CompanyProfileMstGet";
     static const String GetStateList = "$BASE_URL/api/Master/GetStateList";
     static const String GetTatResponseList = "$BASE_URL/api/CRM/Master/TatMstGet";
     static const String AccountMstUploader = "$BASE_URL/api/CRM/Account/AccountMstUploader";
     static const String AccountMstGetBuyCode = "$BASE_URL/api/CRM/Account/AccountMstGetByCode";
     static const String AccountMstImageUpload = "$BASE_URL/api/CRM/Account/AccountMstImageUpload";
     static const String CompanyProfileMstUploader = "$BASE_URL/api/CRM/Master/CompanyProfileMstUploader";
     static const String AccountDashboardDataGet = "$BASE_URL/api/CRM/Account/AccountDashboardDataGet";
     static const String AccountTaskHistoryGet = "$BASE_URL/api/CRM/Account/AccountTaskHistoryGet";
     static const String AccountDashboardCountGet = "$BASE_URL/api/CRM/Account/AccountDashboardCountGet";
     static const String DraftAccountMstGet = "$BASE_URL/api/CRM/Account/DraftAccountMstGet";
     static const String DraftAccountMstUploader = "$BASE_URL/api/CRM/Account/DraftAccountMstUploader";
     static const String CompanyTypeMstGet = "$BASE_URL/api/CRM/Master/CompanyTypeMstGet";
     static const String ContactMstGetAll = "$BASE_URL/api/CRM/Contact/ContactMstGetAll";
     static const String AccountCategoryTypeMstGet = "$BASE_URL/api/CRM/Master/AccountCategoryTypeMstGet";

     //todo contact master repo.....
     static const String ContactMstGet = "$BASE_URL/api/CRM/Contact/ContactMstGet";
     static const String DepartmentGetInsert = "$BASE_URL/api/Master/DepartmentGetInsert";
     static const String ContactMstUploader = "$BASE_URL/api/CRM/Contact/ContactMstUploader";
     static const String DesignationGet = "$BASE_URL/api/Master/DesignationGet";

     //todo Address or Consignee master repo.....
     static const String ConsigneeMstUploader = "$BASE_URL/api/CRM/Account/ConsigneeMstUploader";
     static const String ConsigneeMstGet = "$BASE_URL/api/CRM/Account/ConsigneeMstGet";

     //todo Task Master repo....
     static const String TaskMstGet = "$BASE_URL/api/CRM/Task/TaskMstGet";
     static const String CallStatusMstGet = "$BASE_URL/api/CRM/Master/CallStatusMstGet";
     static const String TaskMstCreate = "$BASE_URL/api/CRM/Task/TaskMstCreate";
     static const String TaskMstApproveReject = "$BASE_URL/api/CRM/Task/TaskMstApproveReject";
     static const String TaskDSARMstGet = "$BASE_URL/api/CRM/Task/TaskDSARMstGet";
     static const String TaskDSARMstCreate = "$BASE_URL/api/CRM/Task/TaskDSARMstCreate";
     static const String ItemCategoryMstGetByTaskId = "$BASE_URL/api/CRM/Task/ItemCategoryMstGetByTaskId";
     static const String ItemCategoryMstGetByDocument = "$BASE_URL/api/CRM/Task/ItemCategoryMstGetByDocument";
     static const String TaskSalesProductCategoryCreate = "$BASE_URL/api/CRM/Task/TaskSalesProductCategoryCreate";
     static const String taskMstInfraUpdate = "$BASE_URL/api/CRM/Task/TaskMstInfraUpdate";
     static const String ItemCategoryMstGet = "$BASE_URL/api/ItemMaster/ItemCategoryMstGet";
     static const String TaskPersonMstGetByTaskId = "$BASE_URL/api/CRM/Task/TakPersonMstGetByTaskId";
     static const String taskPersonMstCreate = "$BASE_URL/api/CRM/Task/task_person_mst_create";
     static const String GeoGetPincodeHierarchy = "$BASE_URL/api/GeographicalSetup/GeoGetPincodeHierarchy";
     static const String PincodeMasterGet = "$BASE_URL/api/CRM/Master/PincodeMasterGetByPincode";
     static const String TaskMstRejectReopen = "$BASE_URL/api/CRM/Task/TaskMstRejectReopen";
     static const String TaskMstGetApprovalList = "$BASE_URL  /api/CRM/Task/TaskMstGetApprovalList";


     //todo sales cycle
     static const String salesCycleMstGet = "$BASE_URL/api/CRM/SalesCycle/SalesCycleMstGet";
     static const String salesCycleMstUpdate = "$BASE_URL/api/CRM/SalesCycle/SalesCycleMstUpdate";
     static const String salesCycleMstApproveReject = "$BASE_URL/api/CRM/SalesCycle/SalesCycleMstApproveReject";
     static const String SalesCycleMstGetByAccountCode = "$BASE_URL/api/CRM/SalesCycle/SalesCycleMstGetByAccountCode";
     static const String quoteHeaderGet = "$BASE_URL/api/CRM/Quote/QuoteHeaderGet";
     static const String QuoteWonDataGet = "$BASE_URL/api/CRM/Quote/QuoteWonDataGet";
     static const String quoteHeaderCreate = "$BASE_URL/api/CRM/Quote/QuoteHeaderCreate";
     static const String quoteHeaderDuplicateCreate = "$BASE_URL/api/CRM/Quote/QuoteHeaderDuplicate";
     static const String quoteHeaderGetByQuoteId = "$BASE_URL/api/CRM/Quote/QuoteHeaderGetByQuoteId";
     static const String itemMstGetByQuoteId = "$BASE_URL/api/CRM/Quote/ItemMstGetByQuoteId";
     static const String quoteLineCreate = "$BASE_URL/api/CRM/Quote/QuoteLineCreate";
     static const String quoteLineDuplicate = "$BASE_URL/api/CRM/Quote/QuoteLineDuplicate";
     static const String quoteLineMarkRegret = "$BASE_URL/api/CRM/Quote/QuoteLineMarkRegret";
     static const String quoteLineDelete = "$BASE_URL/api/CRM/Quote/QuoteLineDelete";
     static const String quoteHeaderUpdate = "$BASE_URL/api/CRM/Quote/QuoteHeaderUpdate";
     static const String quoteHeaderMarkRegret = "$BASE_URL/api/CRM/Quote/QuoteHeaderMarkRegret";
     static const String quoteSendForApproval = "$BASE_URL/api/CRM/Quote/QuoteSendForApproval";
     static const String quoteApproveReject = "$BASE_URL/api/CRM/Quote/QuoteApproveReject";
     static const String QuoteLineCreateFromPropectStage = "$BASE_URL/api/CRM/Quote/QuoteLineCreateFromPropectStage";
    // static const String ItemCategoryMstGetByDocument = "$BASE_URL/api/CRM/Task/ItemCategoryMstGetByDocument";
     static const String QuoteSalesProductCategoryCreate = "$BASE_URL/api/CRM/Task/QuoteSalesProductCategoryCreate";
     static const String QuoteHeaderUpdateBusinessTerms = "$BASE_URL/api/CRM/Quote/QuoteHeaderUpdateBusinessTerms";
     static const String quotationReport = "$BASE_URL/api/CRM/Quote/QuotationReport";
     static const String specialPriceRequestReport = "$BASE_URL/api/CRM/Quote/SpecialPriceRequestReport";
     static const String SaleCycleProductCategoryWiseAmtCreate = "$BASE_URL/api/CRM/SalesCycle/SaleCycleProductCategoryWiseAmtCreate";
     static const String SaleCycleProductCategoryWiseAmtDelete = "$BASE_URL/api/CRM/SalesCycle/SaleCycleProductCategoryWiseAmtDelete";
     static const String SaleCycleProductCategoryWiseAmtGet = "$BASE_URL/api/CRM/SalesCycle/SaleCycleProductCategoryWiseAmtGet";
     static const String EmpMstEmailByGet = "$BASE_URL/api/CRM/SalesCycle/EmpMstEmailByGet";
     static const String SalesCycleMstPurchaseByUpdate = "$BASE_URL/api/CRM/SalesCycle/SalesCycleMstPurchaseByUpdate";
     static const String SalesCycleProductGetBySalesCycleId = "$BASE_URL/api/CRM/SalesCycle/SalesCycleProductGetBySalesCycleId";
     static const String SalesProductLineDelete = "$BASE_URL/api/CRM/SalesCycle/SalesProductLineDelete";
     static const String ItemMstGetBySalesCycleId = "$BASE_URL/api/CRM/SalesCycle/ItemMstGetBySalesCycleId";
     static const String SalesProductLineCreate = "$BASE_URL/api/CRM/SalesCycle/SalesProductLineCreate";
     static const String SalesCycleMstStatusChange = "$BASE_URL/api/CRM/SalesCycle/SalesCycleMstStatusChange";
     static const String SalesCycleMstUpdateSuspect = "$BASE_URL/api/CRM/SalesCycle/SalesCycleMstUpdateSuspect";
     static const String SalesProductLineCompetitorCreate = "$BASE_URL/api/CRM/SalesCycle/SalesProductLineCompetitorCreate";
     static const String SalesCycleMstUpdateProposeConfirmDecision = "$BASE_URL/api/CRM/SalesCycle/SalesCycleMstUpdateProposeConfirmDecision";
     static const String SalesCycleMstUpdateProposedSolution = "$BASE_URL/api/CRM/SalesCycle/SalesCycleMstUpdateProposedSolution";
     static const String SalesCycleMstUpdatePropose = "$BASE_URL/api/CRM/SalesCycle/SalesCycleMstUpdatePropose";
     static const String SalesCycleMstRejectReopen = "$BASE_URL/api/CRM/SalesCycle/SalesCycleMstRejectReopen";
     static const String QuotationDiscountReport = "$BASE_URL/api/CRM/Quote/QuotationDiscountReport";
     static const String QuoteMstRejectReopen = "$BASE_URL/api/CRM/Quote/QuoteMstRejectReopen";
     static const String QuoteHeaderGetNew="$BASE_URL/api/CRM/Quote/QuoteHeaderGetNew";
     static const String SalesProductLineCompetitorClear="$BASE_URL/api/CRM/SalesCycle/SalesProductLineCompetitorClear";
     static const String SalesCycleCompetitorProductGetBySalesCycleId="$BASE_URL/api/CRM/SalesCycle/SalesCycleCompetitorProductGetBySalesCycleId";
     static const String SalesCycleCompetitorCreateFromProspectProducts="$BASE_URL/api/CRM/SalesCycle/SalesCycleCompetitorCreateFromProspectProducts";
     static const String salesProductLineCompetitorDelete="$BASE_URL/api/CRM/SalesCycle/SalesProductLineCompetitorDelete";

   //todo SalesAdvise
     static const String salesAdviceHeaderGet="$BASE_URL/api/CRM/SalesAdvice/SalesAdviceHeaderGet";
     static const String salesAdviceHeaderGetBySalesAdviceId="$BASE_URL/api/CRM/SalesAdvice/SalesAdviceHeaderGetBySalesAdviceId";
     static const String salesAdviceCreate="$BASE_URL/api/CRM/SalesAdvice/SalesAdviceCreate";
     static const String salesAdviceLineUpdate="$BASE_URL/api/CRM/SalesAdvice/SalesAdviceLineUpdate";
     static const String salesAdviceHeaderUpdate="$BASE_URL/api/CRM/SalesAdvice/SalesAdviceHeaderUpdate";
     static const String salesAdviceLineDelete="$BASE_URL/api/CRM/SalesAdvice/SalesAdviceLineDelete";
     static const String salesAdviceComplete="$BASE_URL/api/CRM/SalesAdvice/SalesAdviceComplete";
     static const String salesAdviceLineItemUpdate="$BASE_URL/api/CRM/SalesAdvice/SalesAdviceLineItemUpdate";

     //todo employee information
     static const String employeeLeaveDataGet="$BASE_URL/api/CRM/EmployeeAttendance/EmployeeLeaveDataGet";
     static const String leaveTypesGet="$BASE_URL/api/CRM/EmployeeAttendance/LeaveTypesGet";
     static const String shiftDetailsByEmailGet="$BASE_URL/api/CRM/EmployeeAttendance/ShiftDetailsByEmailGet";
     static const String getEmployeeHolidays="$BASE_URL/api/CRM/EmployeeAttendance/GetEmployeeHolidays";
     static const String employeeLeaveMark="$BASE_URL/api/CRM/EmployeeAttendance/EmployeeLeaveMark";

     //todo business tour plan
     static const String businessPlanListGet="$BASE_URL/api/CRM/BusinessTourPlan/BusinessTourPlanListGet";
     static const String BusinessTourPlanHeaderCreate="$BASE_URL/api/CRM/BusinessTourPlan/BusinessTourPlanHeaderCreate";
     static const String BusinessTourPlanHeaderComplete="$BASE_URL/api/CRM/BusinessTourPlan/BusinessTourplanHeadercComplete";
     static const String BusinessTourPlanDetailsGet="$BASE_URL/api/CRM/BusinessTourPlan/BusinessTourPlanDetailsGet";
     static const String BusinessTourPlanHeaderDelete="$BASE_URL/api/CRM/BusinessTourPlan/BusinessTourPlanHeaderDelete";
     static const String BusinessTourTypeGet="$BASE_URL/api/CRM/BusinessTourPlan/BusinessTourTypeGet";
     static const String BusinessTourPlanAccountGet="$BASE_URL/api/CRM/BusinessTourPlan/BusinessTourPlanAccountGet";
     static const String BusinessTourPlanDistrictGet="$BASE_URL/api/CRM/BusinessTourPlan/BusinessTourPlanDistrictGet";
     static const String BusinessTourPlanContactsGet="$BASE_URL/api/CRM/BusinessTourPlan/BusinessTourPlanContactsGet";
     static const String BusinessTourPlanLineCreate="$BASE_URL/api/CRM/BusinessTourPlan/BusinessTourPlanLineCreate";
     static const String BusinessTourPlanLineDelete="$BASE_URL/api/CRM/BusinessTourPlan/BusinessTourPlanLineDelete";
     static const String BusinessTourPlanReport="$BASE_URL/api/CRM/BusinessTourPlan/BussinessTourPlanReport";
     static const String BusinessTourplanApprovalGet="$BASE_URL/api/CRM/BusinessTourPlan/BusinessTourplanApprovalGet";
     static const String BusinessTourPlanApproveReject="$BASE_URL/api/CRM/BusinessTourPlan/BusinessTourplanApproveReject";

}