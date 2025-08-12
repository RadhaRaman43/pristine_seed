class SaleDashboardDataModel {
  String? condition;
  String? message;
  String? periodFrom;
  String? periodTo;
  String? salePersonName;
  String? salePersonEmpCode;
  String? regionHead;
  String? clusterHead;
  dynamic newAccount;
  dynamic existingAccount;
  dynamic totalAccount;
  dynamic accountCoveredCurrentMonth;
  dynamic accountCoveredPreviousMonth;
  dynamic freshAccountCoveredCurrentMonth;
  dynamic totalAccountCovered;
  dynamic workingDays;
  dynamic newCall;
  dynamic followUpCall;
  dynamic paymentCall;
  dynamic totalCall;
  dynamic totalOrders;
  dynamic ordersValue;
  dynamic callRate;
  dynamic callRateTargetAchieve;
  dynamic newCallPer;
  dynamic newCallTargetAchieve;
  dynamic strikeRate;
  dynamic strikeRateTargetAchieve;
  dynamic dsarPer;
  dynamic dsarTargetAchieve;
  dynamic avgOrderSize;
  dynamic targetAchievement;
  dynamic businessTourDays;
  dynamic currentMonthSuspect;
  dynamic currentMonthProspect;
  dynamic currentMonthPropose;
  dynamic currentFinancialYearSuspect;
  dynamic currentFinancialYearProspect;
  dynamic currentFinancialYearPropose;
  dynamic currentMonthTotalFunnel;
  dynamic currentFinancialYearTotalFunnel;
  List<MonthWiseTotalFunnel>? monthWiseTotalFunnel;
  dynamic firstQuaterSuspect;
  dynamic firstQuaterProspect;
  dynamic firstQuaterPropose;
  dynamic firstQuaterTotalFunnel;
  dynamic secondQuaterSuspect;
  dynamic secondQuaterProspect;
  dynamic secondQuaterPropose;
  dynamic secondQuaterTotalFunnel;
  dynamic thirdQuaterSuspect;
  dynamic thirdQuaterProspect;
  dynamic thirdQuaterPropose;
  dynamic thirdQuaterTotalFunnel;
  dynamic fourthQuaterSuspect;
  dynamic fourthQuaterProspect;
  dynamic fourthQuaterPropose;
  dynamic fourthQuaterTotalFunnel;
  dynamic newProspectsGeneratedCurrentMonth;
  dynamic carryForwardProspectsPreviousMonths;
  dynamic previousMonthOrderWon;
  dynamic previousMonthOrderLost;
  dynamic currentMonthOrderWon;
  dynamic currentMonthOrderLost;
  dynamic orderLostFy;
  dynamic orderWonFy;
  dynamic commitmentPreMonth;
  dynamic bookingCommitmentCurrentMonth;
  dynamic actualBookingPrevMonth;
  dynamic actualBookingCurrentMonth;
  dynamic bookingAchivePrevMonthPer;
  dynamic bookingAchiveCurrentMonthPer;
  dynamic bookingAoCurrentMonth;
  dynamic aoVsBookingAchiveCurrentMonthPer;
  dynamic bookingAoCurrentFy;
  dynamic actualBookingCurrentFy;
  dynamic aoVsBookingAchiveFyPer;
  dynamic ordersAbove15LakhCurrentMonth;
  dynamic ordersAbove20LakhCurrentMonth;
  dynamic ordersAbove15LakhFy;
  dynamic ordersAbove20LakhFy;
  List<MonthWiseCommitment>? monthWiseCommitment;
  List<MonthWiseAoVsBookingAchive>? monthWiseAoVsBookingAchive;
  dynamic prevMonthCollectionCommitment;
  dynamic prevMonthCollectionActual;
  dynamic currentMonthCollectionCommitment;
  dynamic currentMonthCollectionActual;
  dynamic preMonthCollectionPlanVsAchievementPer;
  dynamic currentMonthCollectionPlanVsAchievementPer;

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
        this.preMonthCollectionPlanVsAchievementPer,
        this.currentMonthCollectionPlanVsAchievementPer});

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
    newProspectsGeneratedCurrentMonth = json['new_prospects_generated_current_month'];
    carryForwardProspectsPreviousMonths = json['carry_forward_prospects_previous_months'];
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
    aoVsBookingAchiveCurrentMonthPer = json['ao_vs_booking_achive_current_month_per'];
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
    currentMonthCollectionCommitment = json['current_month_collection_commitment'];
    currentMonthCollectionActual = json['current_month_collection_actual'];
    preMonthCollectionPlanVsAchievementPer = json['pre_month_collection_plan_vs_achievement_per'];
    currentMonthCollectionPlanVsAchievementPer = json['current_month_collection_plan_vs_achievement_per'];
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
    data['pre_month_collection_plan_vs_achievement_per'] =
        this.preMonthCollectionPlanVsAchievementPer;
    data['current_month_collection_plan_vs_achievement_per'] =
        this.currentMonthCollectionPlanVsAchievementPer;
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

class MonthWiseTotalFunnel {
  String? monthYearDate;
  String? monthYearName;
  String? monthName;
  dynamic monthYearValue;

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

class MonthWiseAoVsBookingAchive {
  String? monthYearDate;
  String? monthYearName;
  String? monthName;
  dynamic monthYearBookingAoValue;
  dynamic monthYearActualBookingValue;
  dynamic monthYearAoAchiveValue;

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