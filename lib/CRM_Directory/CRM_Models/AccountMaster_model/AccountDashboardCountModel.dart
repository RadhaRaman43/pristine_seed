class AccountDashboardCountModel {
  String? condition;
  String? message;
  Task? task;
  Sales? sales;
  Quotation? quotation;

  AccountDashboardCountModel(
      {this.condition, this.message, this.task, this.sales, this.quotation});

  AccountDashboardCountModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    task = json['task'] != null ? new Task.fromJson(json['task']) : null;
    sales = json['sales'] != null ? new Sales.fromJson(json['sales']) : null;
    quotation = json['quotation'] != null
        ? new Quotation.fromJson(json['quotation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['message'] = this.message;
    if (this.task != null) {
      data['task'] = this.task!.toJson();
    }
    if (this.sales != null) {
      data['sales'] = this.sales!.toJson();
    }
    if (this.quotation != null) {
      data['quotation'] = this.quotation!.toJson();
    }
    return data;
  }
}

class Task {
  int? todayAccountTask;
  int? futureAccountTask;
  int? breachedAccountTask;
  int? allAccountTask;

  Task(
      {this.todayAccountTask,
        this.futureAccountTask,
        this.breachedAccountTask,
        this.allAccountTask});

  Task.fromJson(Map<String, dynamic> json) {
    todayAccountTask = json['today_account_task'];
    futureAccountTask = json['future_account_task'];
    breachedAccountTask = json['breached_account_task'];
    allAccountTask = json['all_account_task'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['today_account_task'] = this.todayAccountTask;
    data['future_account_task'] = this.futureAccountTask;
    data['breached_account_task'] = this.breachedAccountTask;
    data['all_account_task'] = this.allAccountTask;
    return data;
  }
}

class Sales {
  int? suspectAccountSales;
  int? prospectAccountSales;
  int? proposeAccountSales;
  int? wonAccountSales;
  int? lossAccountSales;
  int? allAccountSales;

  Sales(
      {this.suspectAccountSales,
        this.prospectAccountSales,
        this.proposeAccountSales,
        this.wonAccountSales,
        this.lossAccountSales,
        this.allAccountSales});

  Sales.fromJson(Map<String, dynamic> json) {
    suspectAccountSales = json['suspect_account_sales'];
    prospectAccountSales = json['prospect_account_sales'];
    proposeAccountSales = json['propose_account_sales'];
    wonAccountSales = json['won_account_sales'];
    lossAccountSales = json['loss_account_sales'];
    allAccountSales = json['all_account_sales'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['suspect_account_sales'] = this.suspectAccountSales;
    data['prospect_account_sales'] = this.prospectAccountSales;
    data['propose_account_sales'] = this.proposeAccountSales;
    data['won_account_sales'] = this.wonAccountSales;
    data['loss_account_sales'] = this.lossAccountSales;
    data['all_account_sales'] = this.allAccountSales;
    return data;
  }
}

class Quotation {
  int? wonAccountQuotation;
  int? pendingForApprovalAccountQuotation;
  int? approvedAccountQuotation;
  int? rejectedAccountQuotation;
  int? allAccountQuotation;

  Quotation(
      {this.wonAccountQuotation,
        this.pendingForApprovalAccountQuotation,
        this.approvedAccountQuotation,
        this.rejectedAccountQuotation,
        this.allAccountQuotation});

  Quotation.fromJson(Map<String, dynamic> json) {
    wonAccountQuotation = json['won_account_quotation'];
    pendingForApprovalAccountQuotation = json['pending_for_approval_account_quotation'];
    approvedAccountQuotation = json['approved_account_quotation'];
    rejectedAccountQuotation = json['rejected_account_quotation'];
    allAccountQuotation = json['all_account_quotation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['won_account_quotation'] = this.wonAccountQuotation;
    data['pending_for_approval_account_quotation'] = this.pendingForApprovalAccountQuotation;
    data['approved_account_quotation'] = this.approvedAccountQuotation;
    data['rejected_account_quotation'] = this.rejectedAccountQuotation;
    data['all_account_quotation'] = this.allAccountQuotation;
    return data;
  }
}