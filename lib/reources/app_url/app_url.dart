class AppUrl {
  /*static const String BASE_URL="https://dev4.pristinefulfil.com";
  static const String login_url="$BASE_URL/api/UserLogin/Login";*/

  // static const String BASE_URL="https://mahalaxmi.pristinefulfil.com";
  static const String BASE_URL = "https://devlogin.pristinefulfil.com";
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


}