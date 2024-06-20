class ExpenseHeaderResponse {
  String? condition;
  String? status;
  double? pendingAmount;
  double? underApproveAmount;
  double? unpaidAmount;
  String? documentNo;
  String? grade;
  String? expenseDate;
  String? remarks;
  String? daCode;
  String? daName;
  double? daAmount;
  String? createdBy;
  String? createdOn;
  int? isDone;
  String? completedOn;
  int? isApprove;
  double? lineAmount;
  String? approveStatus;
  String? approveBy;
  String? approveOn;
  int? isPaid;

  ExpenseHeaderResponse(
      {this.condition,
        this.status,
        this.pendingAmount,
        this.underApproveAmount,
        this.unpaidAmount,
        this.documentNo,
        this.grade,
        this.expenseDate,
        this.remarks,
        this.daCode,
        this.daName,
        this.daAmount,
        this.createdBy,
        this.createdOn,
        this.isDone,
        this.completedOn,
        this.isApprove,
        this.lineAmount,
        this.approveStatus,
        this.approveBy,
        this.approveOn,
        this.isPaid});

  ExpenseHeaderResponse.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    status = json['status'];
    pendingAmount = json['pending_amount'];
    underApproveAmount = json['under_approve_amount'];
    unpaidAmount = json['unpaid_amount'];
    documentNo = json['document_no'];
    grade = json['grade'];
    expenseDate = json['expense_date'];
    remarks = json['remarks'];
    daCode = json['da_code'];
    daName = json['da_name'];
    daAmount = json['da_amount'];
    createdBy = json['created_by'];
    createdOn = json['created_on'];
    isDone = json['is_done'];
    completedOn = json['completed_on'];
    isApprove = json['is_approve'];
    lineAmount = json['line_amount'];
    approveStatus = json['approve_status'];
    approveBy = json['approve_by'];
    approveOn = json['approve_on'];
    isPaid = json['is_paid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['status'] = this.status;
    data['pending_amount'] = this.pendingAmount;
    data['under_approve_amount'] = this.underApproveAmount;
    data['unpaid_amount'] = this.unpaidAmount;
    data['document_no'] = this.documentNo;
    data['grade'] = this.grade;
    data['expense_date'] = this.expenseDate;
    data['remarks'] = this.remarks;
    data['da_code'] = this.daCode;
    data['da_name'] = this.daName;
    data['da_amount'] = this.daAmount;
    data['created_by'] = this.createdBy;
    data['created_on'] = this.createdOn;
    data['is_done'] = this.isDone;
    data['completed_on'] = this.completedOn;
    data['is_approve'] = this.isApprove;
    data['line_amount'] = this.lineAmount;
    data['approve_status'] = this.approveStatus;
    data['approve_by'] = this.approveBy;
    data['approve_on'] = this.approveOn;
    data['is_paid'] = this.isPaid;
    return data;
  }
}