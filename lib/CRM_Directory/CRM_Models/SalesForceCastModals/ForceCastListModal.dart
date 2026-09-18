class ForceCastListModal {
  String? condition;
  String? totalRows;
  String? quoteId;
  String? salesCycleId;
  String? quoteStatus;
  int? isActive;
  String? quoteStatusWon;
  String? quoteAccepted;
  int? lineNo;
  String? itemCode;
  String? itemName;
  String? itemDescription;
  dynamic? qty;
  dynamic? unitPrice;
  dynamic? mrpPrice;
  dynamic? quoteLinePrice;
  dynamic? totalPrice;
  dynamic? discountPer;
  dynamic? discountAmt;
  dynamic? discountAmtPerUnit;
  dynamic? approvedDiscountPer;
  dynamic? approvedAmount;
  dynamic? approvedAmountPerUnit;
  dynamic? bmDiscountPer;
  dynamic? branchTransferPrice;
  dynamic? minimalAcceptablePrice;
  dynamic? listSellingPrice;
  dynamic? isSprRequired;
  dynamic? sgstPer;
  dynamic? cgstPer;
  dynamic? igstPer;
  dynamic? sgstAmt;
  dynamic? cgstAmt;
  dynamic? igstAmt;
  dynamic? gstAmount;
  dynamic? grossAmount;
  dynamic? salesCredit;
  String? lineStatus;
  String? productCategory;
  String? parentProductCategory;

  int? isSelected;

  ForceCastListModal(
      {this.condition,
        this.totalRows,
        this.quoteId,
        this.salesCycleId,
        this.quoteStatus,
        this.isActive,
        this.quoteStatusWon,
        this.quoteAccepted,
        this.lineNo,
        this.itemCode,
        this.itemName,
        this.itemDescription,
        this.qty,
        this.unitPrice,
        this.mrpPrice,
        this.quoteLinePrice,
        this.totalPrice,
        this.discountPer,
        this.discountAmt,
        this.discountAmtPerUnit,
        this.approvedDiscountPer,
        this.approvedAmount,
        this.approvedAmountPerUnit,
        this.bmDiscountPer,
        this.branchTransferPrice,
        this.minimalAcceptablePrice,
        this.listSellingPrice,
        this.isSprRequired,
        this.sgstPer,
        this.cgstPer,
        this.igstPer,
        this.sgstAmt,
        this.cgstAmt,
        this.igstAmt,
        this.gstAmount,
        this.grossAmount,
        this.salesCredit,
        this.lineStatus,
        this.productCategory,
        this.parentProductCategory,
        this.isSelected=0});

  ForceCastListModal.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    totalRows = json['total_rows'];
    quoteId = json['quote_id'];
    salesCycleId = json['sales_cycle_id'];
    quoteStatus = json['quote_status'];
    isActive = json['is_active'];
    quoteStatusWon = json['quote_status_won'];
    quoteAccepted = json['quote_accepted'];
    lineNo = json['line_no'];
    itemCode = json['item_code'];
    itemName = json['item_name'];
    itemDescription = json['item_description'];
    qty = json['qty'];
    unitPrice = json['unit_price'];
    mrpPrice = json['mrp_price'];
    quoteLinePrice = json['quote_line_price'];
    totalPrice = json['total_price'];
    discountPer = json['discount_per'];
    discountAmt = json['discount_amt'];
    discountAmtPerUnit = json['discount_amt_per_unit'];
    approvedDiscountPer = json['approved_discount_per'];
    approvedAmount = json['approved_amount'];
    approvedAmountPerUnit = json['approved_amount_per_unit'];
    bmDiscountPer = json['bm_discount_per'];
    branchTransferPrice = json['branch_transfer_price'];
    minimalAcceptablePrice = json['minimal_acceptable_price'];
    listSellingPrice = json['list_selling_price'];
    isSprRequired = json['is_spr_required'];
    sgstPer = json['sgst_per'];
    cgstPer = json['cgst_per'];
    igstPer = json['igst_per'];
    sgstAmt = json['sgst_amt'];
    cgstAmt = json['cgst_amt'];
    igstAmt = json['igst_amt'];
    gstAmount = json['gst_amount'];
    grossAmount = json['gross_amount'];
    salesCredit = json['sales_credit'];
    lineStatus = json['line_status'];
    productCategory = json['product_category'];
    parentProductCategory = json['parent_product_category'];
    isSelected = json['is_selected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['total_rows'] = this.totalRows;
    data['quote_id'] = this.quoteId;
    data['sales_cycle_id'] = this.salesCycleId;
    data['quote_status'] = this.quoteStatus;
    data['is_active'] = this.isActive;
    data['quote_status_won'] = this.quoteStatusWon;
    data['quote_accepted'] = this.quoteAccepted;
    data['line_no'] = this.lineNo;
    data['item_code'] = this.itemCode;
    data['item_name'] = this.itemName;
    data['item_description'] = this.itemDescription;
    data['qty'] = this.qty;
    data['unit_price'] = this.unitPrice;
    data['mrp_price'] = this.mrpPrice;
    data['quote_line_price'] = this.quoteLinePrice;
    data['total_price'] = this.totalPrice;
    data['discount_per'] = this.discountPer;
    data['discount_amt'] = this.discountAmt;
    data['discount_amt_per_unit'] = this.discountAmtPerUnit;
    data['approved_discount_per'] = this.approvedDiscountPer;
    data['approved_amount'] = this.approvedAmount;
    data['approved_amount_per_unit'] = this.approvedAmountPerUnit;
    data['bm_discount_per'] = this.bmDiscountPer;
    data['branch_transfer_price'] = this.branchTransferPrice;
    data['minimal_acceptable_price'] = this.minimalAcceptablePrice;
    data['list_selling_price'] = this.listSellingPrice;
    data['is_spr_required'] = this.isSprRequired;
    data['sgst_per'] = this.sgstPer;
    data['cgst_per'] = this.cgstPer;
    data['igst_per'] = this.igstPer;
    data['sgst_amt'] = this.sgstAmt;
    data['cgst_amt'] = this.cgstAmt;
    data['igst_amt'] = this.igstAmt;
    data['gst_amount'] = this.gstAmount;
    data['gross_amount'] = this.grossAmount;
    data['sales_credit'] = this.salesCredit;
    data['line_status'] = this.lineStatus;
    data['product_category'] = this.productCategory;
    data['parent_product_category'] = this.parentProductCategory;
    data['is_selected'] = this.isSelected;
    return data;
  }
}