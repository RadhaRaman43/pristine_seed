/*
class SaleDashboardDataModel {
  String? condition;
  String? message;
  String? periodFrom;
  String? periodTo;
  String? salePersonName;
  String? salePersonEmpCode;
  String? regionHead;
  String? clusterHead;
  dynamic? newAccount;
  dynamic? existingAccount;
  dynamic? totalAccount;
  dynamic? accountCoveredCurrentMonth;
  dynamic? accountCoveredPreviousMonth;
  dynamic? freshAccountCoveredCurrentMonth;
  dynamic? totalAccountCovered;
  dynamic? workingDays;
  dynamic? newCall;
  dynamic? followUpCall;
  dynamic? paymentCall;
  dynamic? totalCall;
  dynamic? totalOrders;
  String? ordersValue;
  dynamic? callRate;
  dynamic? callRateTargetAchieve;
  dynamic? newCallPer;
  dynamic? newCallTargetAchieve;
  dynamic? strikeRate;
  dynamic? strikeRateTargetAchieve;
  dynamic? dsarPer;
  dynamic? dsarTargetAchieve;
  String? avgOrderSize;
  dynamic? targetAchievement;
  dynamic? businessTourDays;
  String? currentMonthSuspect;
  String? currentMonthProspect;
  String? currentMonthPropose;
  String? currentFinancialYearSuspect;
  String? currentFinancialYearProspect;
  String? currentFinancialYearPropose;
  String? currentMonthTotalFunnel;
  String? currentFinancialYearTotalFunnel;
  List<MonthWiseTotalFunnel>? monthWiseTotalFunnel;
  String? firstQuaterSuspect;
  String? firstQuaterProspect;
  String? firstQuaterPropose;
  String? firstQuaterTotalFunnel;
  String? secondQuaterSuspect;
  String? secondQuaterProspect;
  String? secondQuaterPropose;
  String? secondQuaterTotalFunnel;
  String? thirdQuaterSuspect;
  String? thirdQuaterProspect;
  String? thirdQuaterPropose;
  String? thirdQuaterTotalFunnel;
  String? fourthQuaterSuspect;
  String? fourthQuaterProspect;
  String? fourthQuaterPropose;
  String? fourthQuaterTotalFunnel;
  String? newProspectsGeneratedCurrentMonth;
  dynamic? carryForwardProspectsPreviousMonths;
  String? previousMonthOrderWon;
  String? previousMonthOrderLost;
  String? currentMonthOrderWon;
  String? currentMonthOrderLost;
  String? orderLostFy;
  String? orderWonFy;
  String? commitmentPreMonth;
  String? bookingCommitmentCurrentMonth;
  String? actualBookingPrevMonth;
  String? actualBookingCurrentMonth;
  dynamic? bookingAchivePrevMonthPer;
  dynamic? bookingAchiveCurrentMonthPer;
  String? bookingAoCurrentMonth;
  dynamic? aoVsBookingAchiveCurrentMonthPer;
  String? bookingAoCurrentFy;
  String? actualBookingCurrentFy;
  dynamic? aoVsBookingAchiveFyPer;
  dynamic? ordersAbove15LakhCurrentMonth;
  dynamic? ordersAbove20LakhCurrentMonth;
  dynamic? ordersAbove15LakhFy;
  dynamic? ordersAbove20LakhFy;
  List<MonthWiseCommitment>? monthWiseCommitment;
  List<MonthWiseAoVsBookingAchive>? monthWiseAoVsBookingAchive;
  String? prevMonthCollectionCommitment;
  String? prevMonthCollectionActual;
  String? currentMonthCollectionCommitment;
  String? currentMonthCollectionActual;
  dynamic? prevMonthCollectionPlanAchivePer;
  dynamic? currentMonthCollectionPlanAchivePer;
  List<MonthWiseCollectionCommitmentVsActualCollectionAchive>?
  monthWiseCollectionCommitmentVsActualCollectionAchive;
  List<FinancialYearCollectionCommitmentVsActualCollectionAchive>?
  financialYearCollectionCommitmentVsActualCollectionAchive;
  String? totalBankGrantee;
  String? totalDueBankGrantee;
  String? totalEmsd;
  String? totalDueEmsd;
  String? a030;
  String? a3160;
  String? a6190;
  String? a91180;
  String? a181365;
  String? a366Above;
  String? totalOutstanding;

  SaleDashboardDataModel(
      {this.condition,
        this.message,
        this.periodFrom,
        this.periodTo,
        this.salePersonName,
        this.salePersonEmpCode,
        this.regionHead,
        this.clusterHead,
        this.newAccount,
        this.existingAccount,
        this.totalAccount,
        this.accountCoveredCurrentMonth,
        this.accountCoveredPreviousMonth,
        this.freshAccountCoveredCurrentMonth,
        this.totalAccountCovered,
        this.workingDays,
        this.newCall,
        this.followUpCall,
        this.paymentCall,
        this.totalCall,
        this.totalOrders,
        this.ordersValue,
        this.callRate,
        this.callRateTargetAchieve,
        this.newCallPer,
        this.newCallTargetAchieve,
        this.strikeRate,
        this.strikeRateTargetAchieve,
        this.dsarPer,
        this.dsarTargetAchieve,
        this.avgOrderSize,
        this.targetAchievement,
        this.businessTourDays,
        this.currentMonthSuspect,
        this.currentMonthProspect,
        this.currentMonthPropose,
        this.currentFinancialYearSuspect,
        this.currentFinancialYearProspect,
        this.currentFinancialYearPropose,
        this.currentMonthTotalFunnel,
        this.currentFinancialYearTotalFunnel,
        this.monthWiseTotalFunnel,
        this.firstQuaterSuspect,
        this.firstQuaterProspect,
        this.firstQuaterPropose,
        this.firstQuaterTotalFunnel,
        this.secondQuaterSuspect,
        this.secondQuaterProspect,
        this.secondQuaterPropose,
        this.secondQuaterTotalFunnel,
        this.thirdQuaterSuspect,
        this.thirdQuaterProspect,
        this.thirdQuaterPropose,
        this.thirdQuaterTotalFunnel,
        this.fourthQuaterSuspect,
        this.fourthQuaterProspect,
        this.fourthQuaterPropose,
        this.fourthQuaterTotalFunnel,
        this.newProspectsGeneratedCurrentMonth,
        this.carryForwardProspectsPreviousMonths,
        this.previousMonthOrderWon,
        this.previousMonthOrderLost,
        this.currentMonthOrderWon,
        this.currentMonthOrderLost,
        this.orderLostFy,
        this.orderWonFy,
        this.commitmentPreMonth,
        this.bookingCommitmentCurrentMonth,
        this.actualBookingPrevMonth,
        this.actualBookingCurrentMonth,
        this.bookingAchivePrevMonthPer,
        this.bookingAchiveCurrentMonthPer,
        this.bookingAoCurrentMonth,
        this.aoVsBookingAchiveCurrentMonthPer,
        this.bookingAoCurrentFy,
        this.actualBookingCurrentFy,
        this.aoVsBookingAchiveFyPer,
        this.ordersAbove15LakhCurrentMonth,
        this.ordersAbove20LakhCurrentMonth,
        this.ordersAbove15LakhFy,
        this.ordersAbove20LakhFy,
        this.monthWiseCommitment,
        this.monthWiseAoVsBookingAchive,
        this.prevMonthCollectionCommitment,
        this.prevMonthCollectionActual,
        this.currentMonthCollectionCommitment,
        this.currentMonthCollectionActual,
        this.prevMonthCollectionPlanAchivePer,
        this.currentMonthCollectionPlanAchivePer,
        this.monthWiseCollectionCommitmentVsActualCollectionAchive,
        this.financialYearCollectionCommitmentVsActualCollectionAchive,
        this.totalBankGrantee,
        this.totalDueBankGrantee,
        this.totalEmsd,
        this.totalDueEmsd,
        this.a030,
        this.a3160,
        this.a6190,
        this.a91180,
        this.a181365,
        this.a366Above,
        this.totalOutstanding});

  SaleDashboardDataModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    periodFrom = json['period_from'];
    periodTo = json['period_to'];
    salePersonName = json['sale_person_name'];
    salePersonEmpCode = json['sale_person_emp_code'];
    regionHead = json['region_head'];
    clusterHead = json['cluster_head'];
    newAccount = json['new_account'];
    existingAccount = json['existing_account'];
    totalAccount = json['total_account'];
    accountCoveredCurrentMonth = json['account_covered_current_month'];
    accountCoveredPreviousMonth = json['account_covered_previous_month'];
    freshAccountCoveredCurrentMonth =
    json['fresh_account_covered_current_month'];
    totalAccountCovered = json['total_account_covered'];
    workingDays = json['working_days'];
    newCall = json['new_call'];
    followUpCall = json['follow_up_call'];
    paymentCall = json['payment_call'];
    totalCall = json['total_call'];
    totalOrders = json['total_orders'];
    ordersValue = json['orders_value'];
    callRate = json['call_rate'];
    callRateTargetAchieve = json['call_rate_target_achieve'];
    newCallPer = json['new_call_per'];
    newCallTargetAchieve = json['new_call_target_achieve'];
    strikeRate = json['strike_rate'];
    strikeRateTargetAchieve = json['strike_rate_target_achieve'];
    dsarPer = json['dsar_per'];
    dsarTargetAchieve = json['dsar_target_achieve'];
    avgOrderSize = json['avg_order_size'];
    targetAchievement = json['target_achievement'];
    businessTourDays = json['business_tour_days'];
    currentMonthSuspect = json['current_month_suspect'];
    currentMonthProspect = json['current_month_prospect'];
    currentMonthPropose = json['current_month_propose'];
    currentFinancialYearSuspect = json['current_financial_year_suspect'];
    currentFinancialYearProspect = json['current_financial_year_prospect'];
    currentFinancialYearPropose = json['current_financial_year_propose'];
    currentMonthTotalFunnel = json['current_month_total_funnel'];
    currentFinancialYearTotalFunnel =
    json['current_financial_year_total_funnel'];
    if (json['month_wise_total_funnel'] != null) {
      monthWiseTotalFunnel = <MonthWiseTotalFunnel>[];
      json['month_wise_total_funnel'].forEach((v) {
        monthWiseTotalFunnel!.add(new MonthWiseTotalFunnel.fromJson(v));
      });
    }
    firstQuaterSuspect = json['first_quater_suspect'];
    firstQuaterProspect = json['first_quater_prospect'];
    firstQuaterPropose = json['first_quater_propose'];
    firstQuaterTotalFunnel = json['first_quater_total_funnel'];
    secondQuaterSuspect = json['second_quater_suspect'];
    secondQuaterProspect = json['second_quater_prospect'];
    secondQuaterPropose = json['second_quater_propose'];
    secondQuaterTotalFunnel = json['second_quater_total_funnel'];
    thirdQuaterSuspect = json['third_quater_suspect'];
    thirdQuaterProspect = json['third_quater_prospect'];
    thirdQuaterPropose = json['third_quater_propose'];
    thirdQuaterTotalFunnel = json['third_quater_total_funnel'];
    fourthQuaterSuspect = json['fourth_quater_suspect'];
    fourthQuaterProspect = json['fourth_quater_prospect'];
    fourthQuaterPropose = json['fourth_quater_propose'];
    fourthQuaterTotalFunnel = json['fourth_quater_total_funnel'];
    newProspectsGeneratedCurrentMonth =
    json['new_prospects_generated_current_month'];
    carryForwardProspectsPreviousMonths =
    json['carry_forward_prospects_previous_months'];
    previousMonthOrderWon = json['previous_month_order_won'];
    previousMonthOrderLost = json['previous_month_order_lost'];
    currentMonthOrderWon = json['current_month_order_won'];
    currentMonthOrderLost = json['current_month_order_lost'];
    orderLostFy = json['order_lost_fy'];
    orderWonFy = json['order_won_fy'];
    commitmentPreMonth = json['commitment_pre_month'];
    bookingCommitmentCurrentMonth = json['booking_commitment_current_month'];
    actualBookingPrevMonth = json['actual_booking_prev_month'];
    actualBookingCurrentMonth = json['actual_booking_current_month'];
    bookingAchivePrevMonthPer = json['booking_achive_prev_month_per'];
    bookingAchiveCurrentMonthPer = json['booking_achive_current_month_per'];
    bookingAoCurrentMonth = json['booking_ao_current_month'];
    aoVsBookingAchiveCurrentMonthPer =
    json['ao_vs_booking_achive_current_month_per'];
    bookingAoCurrentFy = json['booking_ao_current_fy'];
    actualBookingCurrentFy = json['actual_booking_current_fy'];
    aoVsBookingAchiveFyPer = json['ao_vs_booking_achive_fy_per'];
    ordersAbove15LakhCurrentMonth = json['orders_above_15_Lakh_current_month'];
    ordersAbove20LakhCurrentMonth = json['orders_above_20_Lakh_current_month'];
    ordersAbove15LakhFy = json['orders_above_15_Lakh_fy'];
    ordersAbove20LakhFy = json['orders_above_20_Lakh_fy'];
    if (json['month_wise_commitment'] != null) {
      monthWiseCommitment = <MonthWiseCommitment>[];
      json['month_wise_commitment'].forEach((v) {
        monthWiseCommitment!.add(new MonthWiseCommitment.fromJson(v));
      });
    }
    if (json['month_wise_ao_vs_booking_achive'] != null) {
      monthWiseAoVsBookingAchive = <MonthWiseAoVsBookingAchive>[];
      json['month_wise_ao_vs_booking_achive'].forEach((v) {
        monthWiseAoVsBookingAchive!
            .add(new MonthWiseAoVsBookingAchive.fromJson(v));
      });
    }
    prevMonthCollectionCommitment = json['prev_month_collection_commitment'];
    prevMonthCollectionActual = json['prev_month_collection_actual'];
    currentMonthCollectionCommitment =
    json['current_month_collection_commitment'];
    currentMonthCollectionActual = json['current_month_collection_actual'];
    prevMonthCollectionPlanAchivePer =
    json['prev_month_collection_plan_achive_per'];
    currentMonthCollectionPlanAchivePer =
    json['current_month_collection_plan_achive_per'];
    if (json['month_wise_collection_commitment_vs_actual_collection_achive'] !=
        null) {
      monthWiseCollectionCommitmentVsActualCollectionAchive =
      <MonthWiseCollectionCommitmentVsActualCollectionAchive>[];
      json['month_wise_collection_commitment_vs_actual_collection_achive']
          .forEach((v) {
        monthWiseCollectionCommitmentVsActualCollectionAchive!.add(
            new MonthWiseCollectionCommitmentVsActualCollectionAchive.fromJson(
                v));
      });
    }
    if (json[
    'financial_year_collection_commitment_vs_actual_collection_achive'] !=
        null) {
      financialYearCollectionCommitmentVsActualCollectionAchive =
      <FinancialYearCollectionCommitmentVsActualCollectionAchive>[];
      json['financial_year_collection_commitment_vs_actual_collection_achive']
          .forEach((v) {
        financialYearCollectionCommitmentVsActualCollectionAchive!.add(
            new FinancialYearCollectionCommitmentVsActualCollectionAchive
                .fromJson(v));
      });
    }
    totalBankGrantee = json['total_bank_grantee'];
    totalDueBankGrantee = json['total_due_bank_grantee'];
    totalEmsd = json['total_emsd'];
    totalDueEmsd = json['total_due_emsd'];
    a030 = json['a_0_30'];
    a3160 = json['a_31_60'];
    a6190 = json['a_61_90'];
    a91180 = json['a_91_180'];
    a181365 = json['a_181_365'];
    a366Above = json['a_366_above'];
    totalOutstanding = json['total_outstanding'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['message'] = this.message;
    data['period_from'] = this.periodFrom;
    data['period_to'] = this.periodTo;
    data['sale_person_name'] = this.salePersonName;
    data['sale_person_emp_code'] = this.salePersonEmpCode;
    data['region_head'] = this.regionHead;
    data['cluster_head'] = this.clusterHead;
    data['new_account'] = this.newAccount;
    data['existing_account'] = this.existingAccount;
    data['total_account'] = this.totalAccount;
    data['account_covered_current_month'] = this.accountCoveredCurrentMonth;
    data['account_covered_previous_month'] = this.accountCoveredPreviousMonth;
    data['fresh_account_covered_current_month'] =
        this.freshAccountCoveredCurrentMonth;
    data['total_account_covered'] = this.totalAccountCovered;
    data['working_days'] = this.workingDays;
    data['new_call'] = this.newCall;
    data['follow_up_call'] = this.followUpCall;
    data['payment_call'] = this.paymentCall;
    data['total_call'] = this.totalCall;
    data['total_orders'] = this.totalOrders;
    data['orders_value'] = this.ordersValue;
    data['call_rate'] = this.callRate;
    data['call_rate_target_achieve'] = this.callRateTargetAchieve;
    data['new_call_per'] = this.newCallPer;
    data['new_call_target_achieve'] = this.newCallTargetAchieve;
    data['strike_rate'] = this.strikeRate;
    data['strike_rate_target_achieve'] = this.strikeRateTargetAchieve;
    data['dsar_per'] = this.dsarPer;
    data['dsar_target_achieve'] = this.dsarTargetAchieve;
    data['avg_order_size'] = this.avgOrderSize;
    data['target_achievement'] = this.targetAchievement;
    data['business_tour_days'] = this.businessTourDays;
    data['current_month_suspect'] = this.currentMonthSuspect;
    data['current_month_prospect'] = this.currentMonthProspect;
    data['current_month_propose'] = this.currentMonthPropose;
    data['current_financial_year_suspect'] = this.currentFinancialYearSuspect;
    data['current_financial_year_prospect'] = this.currentFinancialYearProspect;
    data['current_financial_year_propose'] = this.currentFinancialYearPropose;
    data['current_month_total_funnel'] = this.currentMonthTotalFunnel;
    data['current_financial_year_total_funnel'] =
        this.currentFinancialYearTotalFunnel;
    if (this.monthWiseTotalFunnel != null) {
      data['month_wise_total_funnel'] =
          this.monthWiseTotalFunnel!.map((v) => v.toJson()).toList();
    }
    data['first_quater_suspect'] = this.firstQuaterSuspect;
    data['first_quater_prospect'] = this.firstQuaterProspect;
    data['first_quater_propose'] = this.firstQuaterPropose;
    data['first_quater_total_funnel'] = this.firstQuaterTotalFunnel;
    data['second_quater_suspect'] = this.secondQuaterSuspect;
    data['second_quater_prospect'] = this.secondQuaterProspect;
    data['second_quater_propose'] = this.secondQuaterPropose;
    data['second_quater_total_funnel'] = this.secondQuaterTotalFunnel;
    data['third_quater_suspect'] = this.thirdQuaterSuspect;
    data['third_quater_prospect'] = this.thirdQuaterProspect;
    data['third_quater_propose'] = this.thirdQuaterPropose;
    data['third_quater_total_funnel'] = this.thirdQuaterTotalFunnel;
    data['fourth_quater_suspect'] = this.fourthQuaterSuspect;
    data['fourth_quater_prospect'] = this.fourthQuaterProspect;
    data['fourth_quater_propose'] = this.fourthQuaterPropose;
    data['fourth_quater_total_funnel'] = this.fourthQuaterTotalFunnel;
    data['new_prospects_generated_current_month'] =
        this.newProspectsGeneratedCurrentMonth;
    data['carry_forward_prospects_previous_months'] =
        this.carryForwardProspectsPreviousMonths;
    data['previous_month_order_won'] = this.previousMonthOrderWon;
    data['previous_month_order_lost'] = this.previousMonthOrderLost;
    data['current_month_order_won'] = this.currentMonthOrderWon;
    data['current_month_order_lost'] = this.currentMonthOrderLost;
    data['order_lost_fy'] = this.orderLostFy;
    data['order_won_fy'] = this.orderWonFy;
    data['commitment_pre_month'] = this.commitmentPreMonth;
    data['booking_commitment_current_month'] =
        this.bookingCommitmentCurrentMonth;
    data['actual_booking_prev_month'] = this.actualBookingPrevMonth;
    data['actual_booking_current_month'] = this.actualBookingCurrentMonth;
    data['booking_achive_prev_month_per'] = this.bookingAchivePrevMonthPer;
    data['booking_achive_current_month_per'] =
        this.bookingAchiveCurrentMonthPer;
    data['booking_ao_current_month'] = this.bookingAoCurrentMonth;
    data['ao_vs_booking_achive_current_month_per'] =
        this.aoVsBookingAchiveCurrentMonthPer;
    data['booking_ao_current_fy'] = this.bookingAoCurrentFy;
    data['actual_booking_current_fy'] = this.actualBookingCurrentFy;
    data['ao_vs_booking_achive_fy_per'] = this.aoVsBookingAchiveFyPer;
    data['orders_above_15_Lakh_current_month'] =
        this.ordersAbove15LakhCurrentMonth;
    data['orders_above_20_Lakh_current_month'] =
        this.ordersAbove20LakhCurrentMonth;
    data['orders_above_15_Lakh_fy'] = this.ordersAbove15LakhFy;
    data['orders_above_20_Lakh_fy'] = this.ordersAbove20LakhFy;
    if (this.monthWiseCommitment != null) {
      data['month_wise_commitment'] =
          this.monthWiseCommitment!.map((v) => v.toJson()).toList();
    }
    if (this.monthWiseAoVsBookingAchive != null) {
      data['month_wise_ao_vs_booking_achive'] =
          this.monthWiseAoVsBookingAchive!.map((v) => v.toJson()).toList();
    }
    data['prev_month_collection_commitment'] =
        this.prevMonthCollectionCommitment;
    data['prev_month_collection_actual'] = this.prevMonthCollectionActual;
    data['current_month_collection_commitment'] =
        this.currentMonthCollectionCommitment;
    data['current_month_collection_actual'] = this.currentMonthCollectionActual;
    data['prev_month_collection_plan_achive_per'] =
        this.prevMonthCollectionPlanAchivePer;
    data['current_month_collection_plan_achive_per'] =
        this.currentMonthCollectionPlanAchivePer;
    if (this.monthWiseCollectionCommitmentVsActualCollectionAchive != null) {
      data['month_wise_collection_commitment_vs_actual_collection_achive'] =
          this
              .monthWiseCollectionCommitmentVsActualCollectionAchive!
              .map((v) => v.toJson())
              .toList();
    }
    if (this.financialYearCollectionCommitmentVsActualCollectionAchive !=
        null) {
      data['financial_year_collection_commitment_vs_actual_collection_achive'] =
          this
              .financialYearCollectionCommitmentVsActualCollectionAchive!
              .map((v) => v.toJson())
              .toList();
    }
    data['total_bank_grantee'] = this.totalBankGrantee;
    data['total_due_bank_grantee'] = this.totalDueBankGrantee;
    data['total_emsd'] = this.totalEmsd;
    data['total_due_emsd'] = this.totalDueEmsd;
    data['a_0_30'] = this.a030;
    data['a_31_60'] = this.a3160;
    data['a_61_90'] = this.a6190;
    data['a_91_180'] = this.a91180;
    data['a_181_365'] = this.a181365;
    data['a_366_above'] = this.a366Above;
    data['total_outstanding'] = this.totalOutstanding;
    return data;
  }
}

class MonthWiseTotalFunnel {
  String? monthYearDate;
  String? monthYearName;
  String? monthName;
  String? monthYearValue;

  MonthWiseTotalFunnel(
      {this.monthYearDate,
        this.monthYearName,
        this.monthName,
        this.monthYearValue});

  MonthWiseTotalFunnel.fromJson(Map<String, dynamic> json) {
    monthYearDate = json['month_year_date'];
    monthYearName = json['month_year_name'];
    monthName = json['month_name'];
    monthYearValue = json['month_year_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month_year_date'] = this.monthYearDate;
    data['month_year_name'] = this.monthYearName;
    data['month_name'] = this.monthName;
    data['month_year_value'] = this.monthYearValue;
    return data;
  }
}

class MonthWiseCommitment {
  String? monthYearDate;
  String? monthYearName;
  String? monthName;
  dynamic monthYearValue;

  MonthWiseCommitment(
      {this.monthYearDate,
        this.monthYearName,
        this.monthName,
        this.monthYearValue});

  MonthWiseCommitment.fromJson(Map<String, dynamic> json) {
    monthYearDate = json['month_year_date'];
    monthYearName = json['month_year_name'];
    monthName = json['month_name'];
    monthYearValue = json['month_year_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month_year_date'] = this.monthYearDate;
    data['month_year_name'] = this.monthYearName;
    data['month_name'] = this.monthName;
    data['month_year_value'] = this.monthYearValue;
    return data;
  }
}

class MonthWiseAoVsBookingAchive {
  String? monthYearDate;
  String? monthYearName;
  String? monthName;
  String? monthYearBookingAoValue;
  String? monthYearActualBookingValue;
  String? monthYearAoAchiveValue;

  MonthWiseAoVsBookingAchive(
      {this.monthYearDate,
        this.monthYearName,
        this.monthName,
        this.monthYearBookingAoValue,
        this.monthYearActualBookingValue,
        this.monthYearAoAchiveValue});

  MonthWiseAoVsBookingAchive.fromJson(Map<String, dynamic> json) {
    monthYearDate = json['month_year_date'];
    monthYearName = json['month_year_name'];
    monthName = json['month_name'];
    monthYearBookingAoValue = json['month_year_booking_ao_value'];
    monthYearActualBookingValue = json['month_year_actual_booking_value'];
    monthYearAoAchiveValue = json['month_year_ao_achive_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month_year_date'] = this.monthYearDate;
    data['month_year_name'] = this.monthYearName;
    data['month_name'] = this.monthName;
    data['month_year_booking_ao_value'] = this.monthYearBookingAoValue;
    data['month_year_actual_booking_value'] = this.monthYearActualBookingValue;
    data['month_year_ao_achive_value'] = this.monthYearAoAchiveValue;
    return data;
  }
}

class MonthWiseCollectionCommitmentVsActualCollectionAchive {
  String? monthYearDate;
  String? monthYearName;
  String? monthName;
  String? monthYearCollectionCommitmentValue;
  String? monthYearActualCollectionValue;

  MonthWiseCollectionCommitmentVsActualCollectionAchive(
      {this.monthYearDate,
        this.monthYearName,
        this.monthName,
        this.monthYearCollectionCommitmentValue,
        this.monthYearActualCollectionValue});

  MonthWiseCollectionCommitmentVsActualCollectionAchive.fromJson(
      Map<String, dynamic> json) {
    monthYearDate = json['month_year_date'];
    monthYearName = json['month_year_name'];
    monthName = json['month_name'];
    monthYearCollectionCommitmentValue =
    json['month_year_collection_commitment_value'];
    monthYearActualCollectionValue = json['month_year_actual_collection_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month_year_date'] = this.monthYearDate;
    data['month_year_name'] = this.monthYearName;
    data['month_name'] = this.monthName;
    data['month_year_collection_commitment_value'] =
        this.monthYearCollectionCommitmentValue;
    data['month_year_actual_collection_value'] =
        this.monthYearActualCollectionValue;
    return data;
  }
}

class FinancialYearCollectionCommitmentVsActualCollectionAchive {
  String? financialYearCollectionCommitmentValue;
  String? financialYearActualCollectionValue;
  dynamic? financialYearCollectionValuePer;

  FinancialYearCollectionCommitmentVsActualCollectionAchive(
      {this.financialYearCollectionCommitmentValue,
        this.financialYearActualCollectionValue,
        this.financialYearCollectionValuePer});

  FinancialYearCollectionCommitmentVsActualCollectionAchive.fromJson(
      Map<String, dynamic> json) {
    financialYearCollectionCommitmentValue =
    json['financial_year_collection_commitment_value'];
    financialYearActualCollectionValue =
    json['financial_year_actual_collection_value'];
    financialYearCollectionValuePer =
    json['financial_year_collection_value_per'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['financial_year_collection_commitment_value'] =
        this.financialYearCollectionCommitmentValue;
    data['financial_year_actual_collection_value'] =
        this.financialYearActualCollectionValue;
    data['financial_year_collection_value_per'] =
        this.financialYearCollectionValuePer;
    return data;
  }
}*/

class SaleDashboardDataModel {
  String? condition;
  String? message;
  String? periodfrom;
  String? periodto;
  String? salepersonname;
  String? salepersonempcode;
  String? regionhead;
  String? clusterhead;
  dynamic? newaccount;
  dynamic? existingaccount;
  dynamic? totalaccount;
  dynamic? accountcoveredcurrentmonth;
  dynamic? accountcoveredpreviousmonth;
  dynamic? freshaccountcoveredcurrentmonth;
  dynamic? totalaccountcovered;
  dynamic? workingdays;
  dynamic? newcall;
  dynamic? followupcall;
  dynamic? paymentcall;
  dynamic? totalcall;
  dynamic? totalorders;
  String? ordersvalue;
  dynamic? callrate;
  dynamic? callratetargetachieve;
  dynamic? newcallper;
  dynamic? newcalltargetachieve;
  dynamic? strikerate;
  dynamic? strikeratetargetachieve;
  dynamic? dsarper;
  dynamic? dsartargetachieve;
  String? avgordersize;
  dynamic? targetachievement;
  dynamic? businesstourdays;
  String? currentmonthsuspect;
  String? currentmonthprospect;
  String? currentmonthpropose;
  String? currentfinancialyearsuspect;
  String? currentfinancialyearprospect;
  String? currentfinancialyearpropose;
  String? currentmonthtotalfunnel;
  String? currentfinancialyeartotalfunnel;
  List<MonthWiseTotalFunnel?>? monthwisetotalfunnel;
  String? firstquatersuspect;
  String? firstquaterprospect;
  String? firstquaterpropose;
  String? firstquatertotalfunnel;
  String? secondquatersuspect;
  String? secondquaterprospect;
  String? secondquaterpropose;
  String? secondquatertotalfunnel;
  String? thirdquatersuspect;
  String? thirdquaterprospect;
  String? thirdquaterpropose;
  String? thirdquatertotalfunnel;
  String? fourthquatersuspect;
  String? fourthquaterprospect;
  String? fourthquaterpropose;
  String? fourthquatertotalfunnel;
  String? totalfunnelfinancialyear;
  String? newprospectsgeneratedcurrentmonth;
  String? carryforwardprospectspreviousmonths;
  String? previousmonthorderwon;
  String? previousmonthorderlost;
  String? currentmonthorderwon;
  String? currentmonthorderlost;
  String? orderlostfy;
  String? orderwonfy;
  String? commitmentpremonth;
  String? bookingcommitmentcurrentmonth;
  String? actualbookingprevmonth;
  String? actualbookingcurrentmonth;
  dynamic? bookingachiveprevmonthper;
  dynamic? bookingachivecurrentmonthper;
  String? bookingaocurrentmonth;
  dynamic? aovsbookingachivecurrentmonthper;
  String? bookingaocurrentfy;
  String? actualbookingcurrentfy;
  dynamic? aovsbookingachivefyper;
  dynamic? ordersabove15Lakhcurrentmonth;
  dynamic? ordersabove20Lakhcurrentmonth;
  dynamic? ordersabove15Lakhfy;
  dynamic? ordersabove20Lakhfy;
  List<MonthWiseCommitment?>? monthwisecommitment;
  List<TotalMonthWiseCommitment?>? totalmonthwisecommitment;
  List<MonthWiseFinalBookingCommitment?>? monthwisefinalbookingcommitment;
  List<TotalMonthWiseFinalBookingCommitment?>? totalmonthwisefinalbookingcommitment;
  List<MonthWiseAoVsBookingAchive?>? monthwiseaovsbookingachive;
  String? prevmonthcollectioncommitment;
  String? prevmonthcollectionactual;
  String? currentmonthcollectioncommitment;
  String? currentmonthcollectionactual;
  dynamic? prevmonthcollectionplanachiveper;
  dynamic? currentmonthcollectionplanachiveper;
  List<MonthWiseCollectionCommitmentVsActualCollectionAchive?>? monthwisecollectioncommitmentvsactualcollectionachive;
  List<FinancialYearCollectionCommitmentVsActualCollectionAchive?>? financialyearcollectioncommitmentvsactualcollectionachive;
  String? totalbankgrantee;
  String? totalduebankgrantee;
  String? totalemsd;
  String? totaldueemsd;
  String? a030;
  String? a3160;
  String? a6190;
  String? a91180;
  String? a181365;
  String? a366above;
  String? totaloutstanding;

  SaleDashboardDataModel({this.condition,this.message, this.periodfrom, this.periodto, this.salepersonname, this.salepersonempcode, this.regionhead, this.clusterhead, this.newaccount, this.existingaccount, this.totalaccount, this.accountcoveredcurrentmonth, this.accountcoveredpreviousmonth, this.freshaccountcoveredcurrentmonth, this.totalaccountcovered, this.workingdays, this.newcall, this.followupcall, this.paymentcall, this.totalcall, this.totalorders, this.ordersvalue, this.callrate, this.callratetargetachieve, this.newcallper, this.newcalltargetachieve, this.strikerate, this.strikeratetargetachieve, this.dsarper, this.dsartargetachieve, this.avgordersize, this.targetachievement, this.businesstourdays, this.currentmonthsuspect, this.currentmonthprospect, this.currentmonthpropose, this.currentfinancialyearsuspect, this.currentfinancialyearprospect, this.currentfinancialyearpropose, this.currentmonthtotalfunnel, this.currentfinancialyeartotalfunnel, this.monthwisetotalfunnel, this.firstquatersuspect, this.firstquaterprospect, this.firstquaterpropose, this.firstquatertotalfunnel, this.secondquatersuspect, this.secondquaterprospect, this.secondquaterpropose, this.secondquatertotalfunnel, this.thirdquatersuspect, this.thirdquaterprospect, this.thirdquaterpropose, this.thirdquatertotalfunnel, this.fourthquatersuspect, this.fourthquaterprospect, this.fourthquaterpropose, this.fourthquatertotalfunnel, this.totalfunnelfinancialyear, this.newprospectsgeneratedcurrentmonth, this.carryforwardprospectspreviousmonths, this.previousmonthorderwon, this.previousmonthorderlost, this.currentmonthorderwon, this.currentmonthorderlost, this.orderlostfy, this.orderwonfy, this.commitmentpremonth, this.bookingcommitmentcurrentmonth, this.actualbookingprevmonth, this.actualbookingcurrentmonth, this.bookingachiveprevmonthper, this.bookingachivecurrentmonthper, this.bookingaocurrentmonth, this.aovsbookingachivecurrentmonthper, this.bookingaocurrentfy, this.actualbookingcurrentfy, this.aovsbookingachivefyper, this.ordersabove15Lakhcurrentmonth, this.ordersabove20Lakhcurrentmonth, this.ordersabove15Lakhfy, this.ordersabove20Lakhfy, this.monthwisecommitment, this.totalmonthwisecommitment, this.monthwisefinalbookingcommitment, this.totalmonthwisefinalbookingcommitment, this.monthwiseaovsbookingachive, this.prevmonthcollectioncommitment, this.prevmonthcollectionactual, this.currentmonthcollectioncommitment, this.currentmonthcollectionactual, this.prevmonthcollectionplanachiveper, this.currentmonthcollectionplanachiveper, this.monthwisecollectioncommitmentvsactualcollectionachive, this.financialyearcollectioncommitmentvsactualcollectionachive, this.totalbankgrantee, this.totalduebankgrantee, this.totalemsd, this.totaldueemsd, this.a030, this.a3160, this.a6190, this.a91180, this.a181365, this.a366above, this.totaloutstanding});

  SaleDashboardDataModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    periodfrom = json['period_from'];
    periodto = json['period_to'];
    salepersonname = json['sale_person_name'];
    salepersonempcode = json['sale_person_emp_code'];
    regionhead = json['region_head'];
    clusterhead = json['cluster_head'];
    newaccount = json['new_account'];
    existingaccount = json['existing_account'];
    totalaccount = json['total_account'];
    accountcoveredcurrentmonth = json['account_covered_current_month'];
    accountcoveredpreviousmonth = json['account_covered_previous_month'];
    freshaccountcoveredcurrentmonth = json['fresh_account_covered_current_month'];
    totalaccountcovered = json['total_account_covered'];
    workingdays = json['working_days'];
    newcall = json['new_call'];
    followupcall = json['follow_up_call'];
    paymentcall = json['payment_call'];
    totalcall = json['total_call'];
    totalorders = json['total_orders'];
    ordersvalue = json['orders_value'];
    callrate = json['call_rate'];
    callratetargetachieve = json['call_rate_target_achieve'];
    newcallper = json['new_call_per'];
    newcalltargetachieve = json['new_call_target_achieve'];
    strikerate = json['strike_rate'];
    strikeratetargetachieve = json['strike_rate_target_achieve'];
    dsarper = json['dsar_per'];
    dsartargetachieve = json['dsar_target_achieve'];
    avgordersize = json['avg_order_size'];
    targetachievement = json['target_achievement'];
    businesstourdays = json['business_tour_days'];
    currentmonthsuspect = json['current_month_suspect'];
    currentmonthprospect = json['current_month_prospect'];
    currentmonthpropose = json['current_month_propose'];
    currentfinancialyearsuspect = json['current_financial_year_suspect'];
    currentfinancialyearprospect = json['current_financial_year_prospect'];
    currentfinancialyearpropose = json['current_financial_year_propose'];
    currentmonthtotalfunnel = json['current_month_total_funnel'];
    currentfinancialyeartotalfunnel = json['current_financial_year_total_funnel'];
    if (json['month_wise_total_funnel'] != null) {
      monthwisetotalfunnel = <MonthWiseTotalFunnel>[];
      json['month_wise_total_funnel'].forEach((v) {
        monthwisetotalfunnel!.add(MonthWiseTotalFunnel.fromJson(v));
      });
    }
    firstquatersuspect = json['first_quater_suspect'];
    firstquaterprospect = json['first_quater_prospect'];
    firstquaterpropose = json['first_quater_propose'];
    firstquatertotalfunnel = json['first_quater_total_funnel'];
    secondquatersuspect = json['second_quater_suspect'];
    secondquaterprospect = json['second_quater_prospect'];
    secondquaterpropose = json['second_quater_propose'];
    secondquatertotalfunnel = json['second_quater_total_funnel'];
    thirdquatersuspect = json['third_quater_suspect'];
    thirdquaterprospect = json['third_quater_prospect'];
    thirdquaterpropose = json['third_quater_propose'];
    thirdquatertotalfunnel = json['third_quater_total_funnel'];
    fourthquatersuspect = json['fourth_quater_suspect'];
    fourthquaterprospect = json['fourth_quater_prospect'];
    fourthquaterpropose = json['fourth_quater_propose'];
    fourthquatertotalfunnel = json['fourth_quater_total_funnel'];
    totalfunnelfinancialyear = json['total_funnel_financial_year'];
    newprospectsgeneratedcurrentmonth = json['new_prospects_generated_current_month'];
    carryforwardprospectspreviousmonths = json['carry_forward_prospects_previous_months'];
    previousmonthorderwon = json['previous_month_order_won'];
    previousmonthorderlost = json['previous_month_order_lost'];
    currentmonthorderwon = json['current_month_order_won'];
    currentmonthorderlost = json['current_month_order_lost'];
    orderlostfy = json['order_lost_fy'];
    orderwonfy = json['order_won_fy'];
    commitmentpremonth = json['commitment_pre_month'];
    bookingcommitmentcurrentmonth = json['booking_commitment_current_month'];
    actualbookingprevmonth = json['actual_booking_prev_month'];
    actualbookingcurrentmonth = json['actual_booking_current_month'];
    bookingachiveprevmonthper = json['booking_achive_prev_month_per'];
    bookingachivecurrentmonthper = json['booking_achive_current_month_per'];
    bookingaocurrentmonth = json['booking_ao_current_month'];
    aovsbookingachivecurrentmonthper = json['ao_vs_booking_achive_current_month_per'];
    bookingaocurrentfy = json['booking_ao_current_fy'];
    actualbookingcurrentfy = json['actual_booking_current_fy'];
    aovsbookingachivefyper = json['ao_vs_booking_achive_fy_per'];
    ordersabove15Lakhcurrentmonth = json['orders_above_15_Lakh_current_month'];
    ordersabove20Lakhcurrentmonth = json['orders_above_20_Lakh_current_month'];
    ordersabove15Lakhfy = json['orders_above_15_Lakh_fy'];
    ordersabove20Lakhfy = json['orders_above_20_Lakh_fy'];
    if (json['month_wise_commitment'] != null) {
      monthwisecommitment = <MonthWiseCommitment>[];
      json['month_wise_commitment'].forEach((v) {
        monthwisecommitment!.add(MonthWiseCommitment.fromJson(v));
      });
    }
    if (json['total_month_wise_commitment'] != null) {
      totalmonthwisecommitment = <TotalMonthWiseCommitment>[];
      json['total_month_wise_commitment'].forEach((v) {
        totalmonthwisecommitment!.add(TotalMonthWiseCommitment.fromJson(v));
      });
    }
    if (json['month_wise_final_booking_commitment'] != null) {
      monthwisefinalbookingcommitment = <MonthWiseFinalBookingCommitment>[];
      json['month_wise_final_booking_commitment'].forEach((v) {
        monthwisefinalbookingcommitment!.add(MonthWiseFinalBookingCommitment.fromJson(v));
      });
    }
    if (json['total_month_wise_final_booking_commitment'] != null) {
      totalmonthwisefinalbookingcommitment = <TotalMonthWiseFinalBookingCommitment>[];
      json['total_month_wise_final_booking_commitment'].forEach((v) {
        totalmonthwisefinalbookingcommitment!.add(TotalMonthWiseFinalBookingCommitment.fromJson(v));
      });
    }
    if (json['month_wise_ao_vs_booking_achive'] != null) {
      monthwiseaovsbookingachive = <MonthWiseAoVsBookingAchive>[];
      json['month_wise_ao_vs_booking_achive'].forEach((v) {
        monthwiseaovsbookingachive!.add(MonthWiseAoVsBookingAchive.fromJson(v));
      });
    }
    prevmonthcollectioncommitment = json['prev_month_collection_commitment'];
    prevmonthcollectionactual = json['prev_month_collection_actual'];
    currentmonthcollectioncommitment = json['current_month_collection_commitment'];
    currentmonthcollectionactual = json['current_month_collection_actual'];
    prevmonthcollectionplanachiveper = json['prev_month_collection_plan_achive_per'];
    currentmonthcollectionplanachiveper = json['current_month_collection_plan_achive_per'];
    if (json['month_wise_collection_commitment_vs_actual_collection_achive'] != null) {
      monthwisecollectioncommitmentvsactualcollectionachive = <MonthWiseCollectionCommitmentVsActualCollectionAchive>[];
      json['month_wise_collection_commitment_vs_actual_collection_achive'].forEach((v) {
        monthwisecollectioncommitmentvsactualcollectionachive!.add(MonthWiseCollectionCommitmentVsActualCollectionAchive.fromJson(v));
      });
    }
    if (json['financial_year_collection_commitment_vs_actual_collection_achive'] != null) {
      financialyearcollectioncommitmentvsactualcollectionachive = <FinancialYearCollectionCommitmentVsActualCollectionAchive>[];
      json['financial_year_collection_commitment_vs_actual_collection_achive'].forEach((v) {
        financialyearcollectioncommitmentvsactualcollectionachive!.add(FinancialYearCollectionCommitmentVsActualCollectionAchive.fromJson(v));
      });
    }
    totalbankgrantee = json['total_bank_grantee'];
    totalduebankgrantee = json['total_due_bank_grantee'];
    totalemsd = json['total_emsd'];
    totaldueemsd = json['total_due_emsd'];
    a030 = json['a_0_30'];
    a3160 = json['a_31_60'];
    a6190 = json['a_61_90'];
    a91180 = json['a_91_180'];
    a181365 = json['a_181_365'];
    a366above = json['a_366_above'];
    totaloutstanding = json['total_outstanding'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['condition'] = condition;
    data['message'] = this.message;
    data['period_from'] = periodfrom;
    data['period_to'] = periodto;
    data['sale_person_name'] = salepersonname;
    data['sale_person_emp_code'] = salepersonempcode;
    data['region_head'] = regionhead;
    data['cluster_head'] = clusterhead;
    data['new_account'] = newaccount;
    data['existing_account'] = existingaccount;
    data['total_account'] = totalaccount;
    data['account_covered_current_month'] = accountcoveredcurrentmonth;
    data['account_covered_previous_month'] = accountcoveredpreviousmonth;
    data['fresh_account_covered_current_month'] = freshaccountcoveredcurrentmonth;
    data['total_account_covered'] = totalaccountcovered;
    data['working_days'] = workingdays;
    data['new_call'] = newcall;
    data['follow_up_call'] = followupcall;
    data['payment_call'] = paymentcall;
    data['total_call'] = totalcall;
    data['total_orders'] = totalorders;
    data['orders_value'] = ordersvalue;
    data['call_rate'] = callrate;
    data['call_rate_target_achieve'] = callratetargetachieve;
    data['new_call_per'] = newcallper;
    data['new_call_target_achieve'] = newcalltargetachieve;
    data['strike_rate'] = strikerate;
    data['strike_rate_target_achieve'] = strikeratetargetachieve;
    data['dsar_per'] = dsarper;
    data['dsar_target_achieve'] = dsartargetachieve;
    data['avg_order_size'] = avgordersize;
    data['target_achievement'] = targetachievement;
    data['business_tour_days'] = businesstourdays;
    data['current_month_suspect'] = currentmonthsuspect;
    data['current_month_prospect'] = currentmonthprospect;
    data['current_month_propose'] = currentmonthpropose;
    data['current_financial_year_suspect'] = currentfinancialyearsuspect;
    data['current_financial_year_prospect'] = currentfinancialyearprospect;
    data['current_financial_year_propose'] = currentfinancialyearpropose;
    data['current_month_total_funnel'] = currentmonthtotalfunnel;
    data['current_financial_year_total_funnel'] = currentfinancialyeartotalfunnel;
    data['month_wise_total_funnel'] =monthwisetotalfunnel != null ? monthwisetotalfunnel!.map((v) => v?.toJson()).toList() : null;
    data['first_quater_suspect'] = firstquatersuspect;
    data['first_quater_prospect'] = firstquaterprospect;
    data['first_quater_propose'] = firstquaterpropose;
    data['first_quater_total_funnel'] = firstquatertotalfunnel;
    data['second_quater_suspect'] = secondquatersuspect;
    data['second_quater_prospect'] = secondquaterprospect;
    data['second_quater_propose'] = secondquaterpropose;
    data['second_quater_total_funnel'] = secondquatertotalfunnel;
    data['third_quater_suspect'] = thirdquatersuspect;
    data['third_quater_prospect'] = thirdquaterprospect;
    data['third_quater_propose'] = thirdquaterpropose;
    data['third_quater_total_funnel'] = thirdquatertotalfunnel;
    data['fourth_quater_suspect'] = fourthquatersuspect;
    data['fourth_quater_prospect'] = fourthquaterprospect;
    data['fourth_quater_propose'] = fourthquaterpropose;
    data['fourth_quater_total_funnel'] = fourthquatertotalfunnel;
    data['total_funnel_financial_year'] = totalfunnelfinancialyear;
    data['new_prospects_generated_current_month'] = newprospectsgeneratedcurrentmonth;
    data['carry_forward_prospects_previous_months'] = carryforwardprospectspreviousmonths;
    data['previous_month_order_won'] = previousmonthorderwon;
    data['previous_month_order_lost'] = previousmonthorderlost;
    data['current_month_order_won'] = currentmonthorderwon;
    data['current_month_order_lost'] = currentmonthorderlost;
    data['order_lost_fy'] = orderlostfy;
    data['order_won_fy'] = orderwonfy;
    data['commitment_pre_month'] = commitmentpremonth;
    data['booking_commitment_current_month'] = bookingcommitmentcurrentmonth;
    data['actual_booking_prev_month'] = actualbookingprevmonth;
    data['actual_booking_current_month'] = actualbookingcurrentmonth;
    data['booking_achive_prev_month_per'] = bookingachiveprevmonthper;
    data['booking_achive_current_month_per'] = bookingachivecurrentmonthper;
    data['booking_ao_current_month'] = bookingaocurrentmonth;
    data['ao_vs_booking_achive_current_month_per'] = aovsbookingachivecurrentmonthper;
    data['booking_ao_current_fy'] = bookingaocurrentfy;
    data['actual_booking_current_fy'] = actualbookingcurrentfy;
    data['ao_vs_booking_achive_fy_per'] = aovsbookingachivefyper;
    data['orders_above_15_Lakh_current_month'] = ordersabove15Lakhcurrentmonth;
    data['orders_above_20_Lakh_current_month'] = ordersabove20Lakhcurrentmonth;
    data['orders_above_15_Lakh_fy'] = ordersabove15Lakhfy;
    data['orders_above_20_Lakh_fy'] = ordersabove20Lakhfy;
    data['month_wise_commitment'] =monthwisecommitment != null ? monthwisecommitment!.map((v) => v?.toJson()).toList() : null;
    data['total_month_wise_commitment'] =totalmonthwisecommitment != null ? totalmonthwisecommitment!.map((v) => v?.toJson()).toList() : null;
    data['month_wise_final_booking_commitment'] =monthwisefinalbookingcommitment != null ? monthwisefinalbookingcommitment!.map((v) => v?.toJson()).toList() : null;
    data['total_month_wise_final_booking_commitment'] =totalmonthwisefinalbookingcommitment != null ? totalmonthwisefinalbookingcommitment!.map((v) => v?.toJson()).toList() : null;
    data['month_wise_ao_vs_booking_achive'] =monthwiseaovsbookingachive != null ? monthwiseaovsbookingachive!.map((v) => v?.toJson()).toList() : null;
    data['prev_month_collection_commitment'] = prevmonthcollectioncommitment;
    data['prev_month_collection_actual'] = prevmonthcollectionactual;
    data['current_month_collection_commitment'] = currentmonthcollectioncommitment;
    data['current_month_collection_actual'] = currentmonthcollectionactual;
    data['prev_month_collection_plan_achive_per'] = prevmonthcollectionplanachiveper;
    data['current_month_collection_plan_achive_per'] = currentmonthcollectionplanachiveper;
    data['month_wise_collection_commitment_vs_actual_collection_achive'] =monthwisecollectioncommitmentvsactualcollectionachive != null ? monthwisecollectioncommitmentvsactualcollectionachive!.map((v) => v?.toJson()).toList() : null;
    data['financial_year_collection_commitment_vs_actual_collection_achive'] =financialyearcollectioncommitmentvsactualcollectionachive != null ? financialyearcollectioncommitmentvsactualcollectionachive!.map((v) => v?.toJson()).toList() : null;
    data['total_bank_grantee'] = totalbankgrantee;
    data['total_due_bank_grantee'] = totalduebankgrantee;
    data['total_emsd'] = totalemsd;
    data['total_due_emsd'] = totaldueemsd;
    data['a_0_30'] = a030;
    data['a_31_60'] = a3160;
    data['a_61_90'] = a6190;
    data['a_91_180'] = a91180;
    data['a_181_365'] = a181365;
    data['a_366_above'] = a366above;
    data['total_outstanding'] = totaloutstanding;
    return data;
  }
}

class TotalMonthWiseCommitment {
  String? monthyearvalue;

  TotalMonthWiseCommitment({this.monthyearvalue});

  TotalMonthWiseCommitment.fromJson(Map<String, dynamic> json) {
    monthyearvalue = json['month_year_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['month_year_value'] = monthyearvalue;
    return data;
  }
}

class TotalMonthWiseFinalBookingCommitment {
  String? monthyearvalue;

  TotalMonthWiseFinalBookingCommitment({this.monthyearvalue});

  TotalMonthWiseFinalBookingCommitment.fromJson(Map<String, dynamic> json) {
    monthyearvalue = json['month_year_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['month_year_value'] = monthyearvalue;
    return data;
  }
}
class FinancialYearCollectionCommitmentVsActualCollectionAchive {
  String? financialyearcollectioncommitmentvalue;
  String? financialyearactualcollectionvalue;
  dynamic? financialyearcollectionvalueper;

  FinancialYearCollectionCommitmentVsActualCollectionAchive({this.financialyearcollectioncommitmentvalue, this.financialyearactualcollectionvalue, this.financialyearcollectionvalueper});

  FinancialYearCollectionCommitmentVsActualCollectionAchive.fromJson(Map<String, dynamic> json) {
    financialyearcollectioncommitmentvalue = json['financial_year_collection_commitment_value'];
    financialyearactualcollectionvalue = json['financial_year_actual_collection_value'];
    financialyearcollectionvalueper = json['financial_year_collection_value_per'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['financial_year_collection_commitment_value'] = financialyearcollectioncommitmentvalue;
    data['financial_year_actual_collection_value'] = financialyearactualcollectionvalue;
    data['financial_year_collection_value_per'] = financialyearcollectionvalueper;
    return data;
  }
}

class MonthWiseAoVsBookingAchive {
  String? monthyeardate;
  String? monthyearname;
  String? monthname;
  String? monthyearbookingaovalue;
  String? monthyearactualbookingvalue;
  String? monthyearaoachivevalue;

  MonthWiseAoVsBookingAchive({this.monthyeardate, this.monthyearname, this.monthname, this.monthyearbookingaovalue, this.monthyearactualbookingvalue, this.monthyearaoachivevalue});

  MonthWiseAoVsBookingAchive.fromJson(Map<String, dynamic> json) {
    monthyeardate = json['month_year_date'];
    monthyearname = json['month_year_name'];
    monthname = json['month_name'];
    monthyearbookingaovalue = json['month_year_booking_ao_value'];
    monthyearactualbookingvalue = json['month_year_actual_booking_value'];
    monthyearaoachivevalue = json['month_year_ao_achive_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['month_year_date'] = monthyeardate;
    data['month_year_name'] = monthyearname;
    data['month_name'] = monthname;
    data['month_year_booking_ao_value'] = monthyearbookingaovalue;
    data['month_year_actual_booking_value'] = monthyearactualbookingvalue;
    data['month_year_ao_achive_value'] = monthyearaoachivevalue;
    return data;
  }
}

class MonthWiseCollectionCommitmentVsActualCollectionAchive {
  String? monthyeardate;
  String? monthyearname;
  String? monthname;
  String? monthyearcollectioncommitmentvalue;
  String? monthyearactualcollectionvalue;

  MonthWiseCollectionCommitmentVsActualCollectionAchive({this.monthyeardate, this.monthyearname, this.monthname, this.monthyearcollectioncommitmentvalue, this.monthyearactualcollectionvalue});

  MonthWiseCollectionCommitmentVsActualCollectionAchive.fromJson(Map<String, dynamic> json) {
    monthyeardate = json['month_year_date'];
    monthyearname = json['month_year_name'];
    monthname = json['month_name'];
    monthyearcollectioncommitmentvalue = json['month_year_collection_commitment_value'];
    monthyearactualcollectionvalue = json['month_year_actual_collection_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['month_year_date'] = monthyeardate;
    data['month_year_name'] = monthyearname;
    data['month_name'] = monthname;
    data['month_year_collection_commitment_value'] = monthyearcollectioncommitmentvalue;
    data['month_year_actual_collection_value'] = monthyearactualcollectionvalue;
    return data;
  }
}

class MonthWiseCommitment {
  String? monthyeardate;
  String? monthyearname;
  String? monthname;
  String? monthyearvalue;

  MonthWiseCommitment({this.monthyeardate, this.monthyearname, this.monthname, this.monthyearvalue});

  MonthWiseCommitment.fromJson(Map<String, dynamic> json) {
    monthyeardate = json['month_year_date'];
    monthyearname = json['month_year_name'];
    monthname = json['month_name'];
    monthyearvalue = json['month_year_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['month_year_date'] = monthyeardate;
    data['month_year_name'] = monthyearname;
    data['month_name'] = monthname;
    data['month_year_value'] = monthyearvalue;
    return data;
  }
}

class MonthWiseFinalBookingCommitment {
  String? monthyeardate;
  String? monthyearname;
  String? monthname;
  String? monthyearvalue;

  MonthWiseFinalBookingCommitment({this.monthyeardate, this.monthyearname, this.monthname, this.monthyearvalue});

  MonthWiseFinalBookingCommitment.fromJson(Map<String, dynamic> json) {
    monthyeardate = json['month_year_date'];
    monthyearname = json['month_year_name'];
    monthname = json['month_name'];
    monthyearvalue = json['month_year_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['month_year_date'] = monthyeardate;
    data['month_year_name'] = monthyearname;
    data['month_name'] = monthname;
    data['month_year_value'] = monthyearvalue;
    return data;
  }
}

class MonthWiseTotalFunnel {
  String? monthyeardate;
  String? monthyearname;
  String? monthname;
  String? monthyearvalue;

  MonthWiseTotalFunnel({this.monthyeardate, this.monthyearname, this.monthname, this.monthyearvalue});

  MonthWiseTotalFunnel.fromJson(Map<String, dynamic> json) {
    monthyeardate = json['month_year_date'];
    monthyearname = json['month_year_name'];
    monthname = json['month_name'];
    monthyearvalue = json['month_year_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['month_year_date'] = monthyeardate;
    data['month_year_name'] = monthyearname;
    data['month_name'] = monthname;
    data['month_year_value'] = monthyearvalue;
    return data;
  }
}

