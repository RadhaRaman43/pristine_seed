class TourPlanAccountModel {
  String? condition;
  String? totalRows;
  String? accountCode;
  String? accountName;
  String? accountOwnerFullName;
  String? accountOwner;
  String? contactCode;
  String? contactName;

  TourPlanAccountModel(
      {this.condition,
        this.totalRows,
        this.accountCode,
        this.accountName,
        this.accountOwnerFullName,
        this.accountOwner,
        this.contactCode,
        this.contactName
      });

  TourPlanAccountModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    totalRows = json['total_rows'];
    accountCode = json['account_code'];
    accountName = json['account_name'];
    accountOwnerFullName = json['account_owner_full_name'];
    accountOwner = json['account_owner'];
    contactCode = json['contact_code'];
    contactName = json['contact_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['total_rows'] = this.totalRows;
    data['account_code'] = this.accountCode;
    data['account_name'] = this.accountName;
    data['account_owner_full_name'] = this.accountOwnerFullName;
    data['account_owner'] = this.accountOwner;
    data['contact_code'] = this.contactCode;
    data['contact_name'] = this.contactName;
    return data;
  }
}