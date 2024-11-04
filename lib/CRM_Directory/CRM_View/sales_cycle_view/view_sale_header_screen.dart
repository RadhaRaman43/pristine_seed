import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:navigation_drawer_flutter/CRM_Directory/CRM_Models/AccountMaster_model/getMasterTypeModel.dart';
import 'package:navigation_drawer_flutter/CRM_Directory/CRM_Models/sale_cycle_modal/productCategoryWiseAmtModel.dart';
import 'package:navigation_drawer_flutter/component/default_button.dart';
import 'package:navigation_drawer_flutter/constants/static_methods.dart';
import '../../../component/back_button.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../utils/app_utils.dart';
import '../../../view/custom_drawer.dart';
import '../../CRM_Models/TaskMaster_model/Item_Category_Mast_model.dart';
import '../../CRM_Models/sale_cycle_modal/sales_cycle_modal.dart';
import '../../CRM_VIewModels/Task_master_vm/TaskMasterVM.dart';
import '../../CRM_VIewModels/account_master_vm/accountMasterVM.dart';
import '../../CRM_VIewModels/contact_master_vm/contact_master_vm/ContactMasterVM.dart';
import '../../CRM_VIewModels/quote_approval_list_vm/quote_approval_list_vm.dart';
import '../../CRM_VIewModels/sales_cycle_vm/sales_cycle_vm.dart';

class ViewSaleHeaderScreen extends StatelessWidget{
  ViewSaleHeaderScreen({super.key});
  final saleCycleController=Get.put(SalesCycleVm());
  final TaskMaster_page_controller=Get.put(Taskmastervm());
  final accountMaster_page_controller=Get.put(Accountmastervm());
  final contact_vm_controller = Get.put(ContactMasterVM());
  final quoteApprovalController=Get.put(QuoteApprovalListVm());

  static String _displayCustomerNeedIdentityStatusForOption(String option) =>
      option;

  static String _displayItemCatMasterForOption(ItemCategoryMstModel option) =>
      option.categoryName!;

  static String _displayPurchaseProcessForOption(CustomList option) =>
      option.value!;

  static String _displayPurchaseTimeFrameForOption(CustomList option) =>
      option.value!;

  static String _displayDecisionMakerForOption(String option) =>
      option;

  Size size=Get.size;

   int count=1;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if(saleCycleController.FromPage == 'Sales'){
          print('Yaha Se1...');
          saleCycleController.accountNameController.value.clear();
          saleCycleController.contactNameController.value.clear();
          saleCycleController.ApprovalStatusController.value.clear();
          saleCycleController.pageNumber = 0;
          saleCycleController.getsalesCycleData(saleCycleController.pageNumber, "", "",'Sales');
          Get.toNamed(RoutesName.salesCycleScreen);
        }else if(saleCycleController.FromPage == 'Task'){
          TaskMaster_page_controller.getTaskMaster(0,
              TaskMaster_page_controller.is_Active
                  .toString(),
              TaskMaster_page_controller
                  .Task_Master_list[0].taskId,
              '', 'GET FROM TASK ID', TaskMaster_page_controller.date_filter, TaskMaster_page_controller.is_done.value);
          Get.toNamed(RoutesName.taskMasterDetails_screen);
        }else if(saleCycleController.FromPage=="QuoteApprovalPage"){
          quoteApprovalController.getQuoteHeaderData(0);
          Get.toNamed(RoutesName.quoteApprovalListScreen);
        }
        else if(saleCycleController.FromPage=="FromTaskScreen"){
          Get.offAllNamed(RoutesName.taskMaster_screen);
        }
        else if(saleCycleController.FromPage=="FromDashboard"){
          Get.toNamed(RoutesName.AccountDashboardDataSales_Screen);
        }

        else {
          print('Yaha Se...');
          saleCycleController.accountNameController.value.clear();
          saleCycleController.contactNameController.value.clear();
          saleCycleController.ApprovalStatusController.value.clear();
          //saleCycleController.getsalesCycleData(0, "", "",'');
          Get.toNamed(RoutesName.salesCycleScreen);
        }

        return false;
      },
      child: Scaffold(
      appBar:  AppBar(
          backgroundColor: AllColors.primaryDark1,
          iconTheme: IconThemeData(
            color: AllColors.whiteColor,
          ),
          title:Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'View Sales',
                    style: GoogleFonts.poppins(
                      color: AllColors.whiteColor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    '(${saleCycleController.saleCycleList[0].salesCycleId.toString()})',
                    style: GoogleFonts.poppins(
                      color: AllColors.whiteColor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Spacer(),
             Obx((){
              return Visibility(
                 visible:saleCycleController.saleCycleList[0].createdBy==saleCycleController.email &&
                     saleCycleController.saleCycleList[0].salesCycleStatus!.toUpperCase()=="PROPOSE" &&
                     saleCycleController.FromPage == 'Sales' &&
                     saleCycleController.saleCycleList[0].isReadySendForApproval==1 &&
                     saleCycleController.saleCycleList[0].isSalesCycleClosed!=1?true:false,
                 child: GestureDetector(
                   onTap: (){
                     saleCycleController.updateQuoteAccetedCycleController.value.clear();
                     saleCycleController.saleCycleController.value.clear();
                     saleCycleController.isChooseQuote.value = false;
                     saleCycleController.isApprove.value=false;
                     saleCycleController.isReject.value=false;
                     saleCycleController.isCheck.value = -1;
                     saleCycleController.checkBoxValues.updateAll((key, value) => false);
                     saleCycleController.Quote_Selected_list.clear();
                     saleCycleController.showDialogForsalescycleUpdate(context, saleCycleController.saleCycleList[0]);

                     //showDialogForHeaderUpdate(context);
                   },
                   child: Container(
                     child: Padding(
                       padding: const EdgeInsets.all(7.0),
                       child: Icon(Icons.update, color: AllColors.whiteColor,),
                     ),
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(30),
                         border: Border.all(color: AllColors.whiteColor)
                     ),
                   ),
                 ),
               );
             })

            ],
          )
      ),
      drawer: CustomDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx((){
            return Visibility(
              visible:saleCycleController.loading.value ,
              child: LinearProgressIndicator(
                backgroundColor: AllColors.primaryDark1,
                color: AllColors.textColor,
              ),
            );
          }),
        Expanded(
          child: Container(
            child: ListView(
                children: [
                  Obx((){
                    return BindSalesData(context);
                  }),
                  SizedBox(height: 20,),
                  Obx((){
                    return bindsaleStatus(context);
                  }),
                  SizedBox(height: 10,),

                  Obx((){
                    return Visibility(
                      visible: saleCycleController.saleCycleList[0].salesCycleStatus=="Suspect" ?true:false,
                      child: Container(
                        child:Column(
                            children: [
                              bindClosureDate(context),
                              SizedBox(height: 10,),
                              bindIdentifyDecisionMaker(context),
                              SizedBox(height: 10,),
                              bindSaleCycleCommit(context),
                              SizedBox(height: 10,),
                              bindPurchaseProcessDropDown(context),
                              SizedBox(height: 10,),
                              bindPurchaseTimeFrameDropDown(context),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  bindProductCategoryDropDown(context),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(15, 5, 15, 10),
                                    width: size.width/2,
                                    child: IgnorePointer(
                                      ignoring: (saleCycleController.saleCycleList[0].isReadySendForApproval==0   &&
                                          (saleCycleController.FromPage.value == 'Sales' || saleCycleController.FromPage.value == 'FromTaskScreen'
                                          )) || saleCycleController.FromPage.value == 'Task' || saleCycleController.FromPage.value == 'FromTaskScreen'?true:false,
                                      child: DefaultButton(
                                        press: (){
                                          if(saleCycleController.productCategoryController.value.text.isEmpty || saleCycleController.productCategoryController.value.text == "" ){
                                            Utils.showErrorToastification("Product Category", "Please select product category");
                                            return;
                                          }
                                          if(saleCycleController.budgetAmountController.value.text.isEmpty || saleCycleController.budgetAmountController.value.text == "" ){
                                            Utils.showErrorToastification("Budget Amount", "Please enter budget amount");
                                            return;
                                          }
                                          if(saleCycleController.expectedAmountController.value.text.isEmpty || saleCycleController.expectedAmountController.value.text == "" ){
                                            Utils.showErrorToastification("Expected Amount", "Please enter expected amount");
                                            return;
                                          }

                                          saleCycleController.ProductCategoryWiseAmtCreateApiHit(0);

                                        },
                                        text: "Save",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                bindBudgetAmount(context),
                                bindExpectedAmount(context)

                              ],
                            ),
                            /*SizedBox(height: 5,),
                            Text(
                              "Amount Table",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.sisxteen,
                                fontWeight: FontWeight.w700,
                              ),
                            ),*/

                            SizedBox(height: 10,),

                            Container(
                              margin: EdgeInsets.only(left: 15, right: 15),
                             /* width: double.infinity,
                              height: size.height*.4,*/
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  BindAmmountTable(context),
                                ],
                              ),
                            )

                          ],
                        ),
                      ),
                    );
                  }),

                     Column(
                       children: [
                         Container(
                           child:Row(
                             children: [
                               Obx((){
                                 return  Expanded(child: Visibility(
                                     visible:saleCycleController.saleCycleList[0].salesCycleStatus!.toUpperCase()=="PROSPECT"?true:false,
                                     child: bindCustomerNeedIdentity(context)));
                               }),

                               SizedBox(width: 10,),
                               Obx((){
                                 return Expanded(child: Visibility(
                                     visible: (saleCycleController.saleCycleList[0].salesCycleStatus!.toUpperCase()=="PROSPECT") && saleCycleController.ischangeNeedIdentity.value,
                                     child: bindSolutionAccepted(context)));
                               })

                             ],
                           ),
                         ),
                         Obx((){
                           return Visibility(
                               visible: (saleCycleController.saleCycleList[0].salesCycleStatus!.toUpperCase()=="PROSPECT")
                                   && (saleCycleController.ischangeNeedIdentity.isFalse || saleCycleController.ischangesolutionAccepted.isFalse)
                                   ?true:false,
                               child: bindSolutionRejectedRemarks(context));
                         }),
                         Obx((){
                           return Visibility(
                               visible: saleCycleController.saleCycleList[0].salesCycleStatus!.toUpperCase()=="PROSPECT" &&
                                   saleCycleController.ischangeNeedIdentity.value &&
                                   saleCycleController.ischangesolutionAccepted.value &&
                                   (saleCycleController.ischangeNeedIdentity.value && saleCycleController.ischangesolutionAccepted.value)?true:false,
                               child: BindProposedSolution(context));
                         }),
                       ],
                     ),


                  Obx((){
                    return   Visibility(
                      visible: saleCycleController.saleCycleList[0].salesCycleStatus!.toUpperCase()=="PROPOSE"?true:false,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0, right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Quote List", style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.eighteen,
                                    fontWeight: FontWeight.w700,
                                  ), ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: (){
                                          showDialogForFilter(context);
                                        },
                                        child: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(7.0),
                                            child: Icon(Icons.filter_alt_rounded, color: AllColors.primaryDark1,),
                                          ),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(30),
                                              border: Border.all(color: AllColors.primaryDark1)
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Visibility(
                                        visible: saleCycleController.saleCycleList[0].createdBy==saleCycleController.email && saleCycleController.FromPage == 'Sales'?true:false,
                                        child: GestureDetector(
                                          onTap: (){
                                            saleCycleController.contactCode.value=saleCycleController.saleCycleList[0].contactCode??"";
                                            saleCycleController.accountCode.value=saleCycleController.saleCycleList[0].accountCode??"";
                                            saleCycleController.accountNameController.value.text=saleCycleController.saleCycleList[0].accountName??"";
                                            saleCycleController.contactNameController.value.text=saleCycleController.saleCycleList[0].contactName??"";
                                            saleCycleController.ApprovalStatusController.value.text=saleCycleController.saleCycleList[0].salesCycleApprovalStatus??"";
                                            saleCycleController.expectedClosuredateController.value.text=saleCycleController.saleCycleList[0].estClosureDate??"";
                                            saleCycleController.contactQuoteCommitController.value.text ="No";
                                            saleCycleController.selectedItem.value = -1;
                                            saleCycleController.shippingController.value.text=saleCycleController.saleCycleList[0].shippingAddress??"";
                                            saleCycleController.Shipping_PostCode_Controller.value.text=saleCycleController.saleCycleList[0].shippingPostCode??"";
                                            saleCycleController.Shipping_City_Controller.value.text=saleCycleController.saleCycleList[0].shippingCity??"" ;
                                            saleCycleController.Shipping_State_Controller.value.text=saleCycleController.saleCycleList[0].shippingStateName??"";
                                            saleCycleController.Shipping_phone_Controller.value.text=saleCycleController.saleCycleList[0].shippingPhoneNo??"";
                                            saleCycleController.Shipping_email_Controller.value.text=saleCycleController.saleCycleList[0].shippingEmailId??"";
                                            saleCycleController.itemCategorySelectedlist.value = [];
                                            saleCycleController.getItemCategoryMstApi(saleCycleController.saleCycleList[0].salesCycleId!, saleCycleController.saleCycleList[0].taskId!);
                                            Get.toNamed(RoutesName.salesCycleCreateQuoteScreen);
                                          },
                                          child: Container(
                                            child: Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Icon(Icons.add, color: AllColors.primaryDark1,),
                                            ),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(30),
                                                border: Border.all(color: AllColors.primaryDark1)
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 10,),
                            Divider(height: 1,color: AllColors.bluegrayColor,),
                            //SizedBox(height: 10,),
                            Obx((){
                              return  bindQuoteData(context);
                            }),

                          ],
                        ),
                      ),
                    );
                  })

                ]

            ),
          ),
        ),
          Visibility(
            visible:saleCycleController.saleCycleList[0].createdBy==saleCycleController.email && saleCycleController.FromPage=="Sales"?true:false,
              child: Stack(
            children: [
              Obx((){
                return Visibility(
                  // visible: saleCycleController.saleCycleList[0].createdBy==saleCycleController.email,
                  visible:(saleCycleController.saleCycleList[0].salesCycleStatus!.toUpperCase()=="PROSPECT") && (saleCycleController.ischangeNeedIdentity.value && saleCycleController.ischangesolutionAccepted.value) &&
                      (saleCycleController.saleCycleList[0].salesCycleApprovalStatus!="Rejected")?true:false,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          AllColors.primaryDark1,
                        ),
                      ),
                      onPressed: ()  {
                        saleCycleController.salesCycleMstUpdateApiHit(saleCycleController.saleCycleList[0],
                            saleCycleController.proposedSolutionController.value.text, "", "", "", "Approved");
                      },
                      child: Container(
                        width: size.width,
                        child: Center(
                          child: Text('Next',
                            style: GoogleFonts.poppins(
                              color: AllColors.whiteColor,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );}
              ),
              Obx((){
                return Visibility(
                  visible:(saleCycleController.saleCycleList[0].salesCycleStatus=="Prospect") &&
                      (saleCycleController.ischangeNeedIdentity.isFalse ||
                          saleCycleController.ischangesolutionAccepted.isFalse) &&  (saleCycleController.saleCycleList[0].salesCycleApprovalStatus!="Rejected")
                      ?true:false,
                  /* visible:saleCycleController.saleCycleList[0].salesCycleStatus=="Prospect" &&
                 saleCycleController.ischangeNeedIdentity.value && saleCycleController.ischangesolutionAccepted.value?false:true,*/
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          AllColors.redColor,
                        ),
                      ),
                      onPressed: ()  {
                        saleCycleController.salesCycleMstUpdateApiHit(saleCycleController.saleCycleList[0],
                            "", "", "", "", "Rejected");
                      },
                      child: Container(
                        width: size.width,
                        child: Center(
                          child: Text('Reject',
                            style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );}
              ),
            ],
          )),


        Visibility(
            visible:saleCycleController.FromPage=="Sales"?true:false,
          child: Wrap(
            children: [
              Obx((){
                if(saleCycleController.saleCycleList[0].isReadySendForApproval==1 && saleCycleController.saleCycleList[0].salesCycleStatus!.toUpperCase()=="Suspect"){
                  saleCycleController.isApprovalVisible.value=true;
                }
                else{
                  saleCycleController.isApprovalVisible.value=false;
                }
                return  Visibility(
                // visible: saleCycleController.isApprovalVisible.isTrue?true:false,
                 visible:  saleCycleController.saleCycleList[0].salesCycleStatus!.toUpperCase()=="SUSPECT" && saleCycleController.saleCycleList[0].isReadySendForApproval==1?true:false,
                  child: Container(
                    margin: EdgeInsets.only(left: 15, right: 15, bottom: 10),
                    child: DefaultButton(
                      press: (){
                        if(saleCycleController.budgetAmountList.isEmpty || saleCycleController.budgetAmountList.length <= 0){
                          Utils.showErrorToastification("Error!", "Please add at least one product category");
                          return;
                        }

                        openConfirmationDialog(context, saleCycleController.saleCycleList[0], "Pending For Approval", "Approve");
                      },
                      text: "Sent For Approval",
                    ),
                  ),
                );
              }),
              Obx((){
                return Visibility(
                  visible: saleCycleController.saleCycleList[0].isReadyForApprove==1 && saleCycleController.FromPage == 'Sales'?true:false,
                  child:Container(
                   margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: DefaultButton(
                            text: "Approve",
                            press: () {
                              openConfirmationDialog(context, saleCycleController.saleCycleList[0], "Approved", "Approve");
                            },

                          ),
                        ),
                        SizedBox(width: size.width * .02),
                        Expanded(
                          child: DefaultButton(
                            text: "Reject",
                            press: () {
                              openConfirmationDialog(context, saleCycleController.saleCycleList[0], "Rejected", "Reject");
                            },

                          ),
                        ),
                        // }),
                      ],
                    ),
                  ),
                );
              })
            ],
          ),
        ),

      ],)
    ),
    );
  }

  Widget bindsaleStatus(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  children: [
                    Container(
                      height: 30.0,
                      width: 30.0,
                      decoration:
                      new BoxDecoration(
                        color:
                        saleCycleController.saleCycleList[0].salesCycleStatus!.toUpperCase()=="SUSPECT"? Colors.lightBlue:Colors.blueGrey,
                        borderRadius:
                        BorderRadius
                            .circular(20),
                      ),
                      child: Center(
                        child: Text("1",
                          style: GoogleFonts.poppins(
                            color: AllColors.whiteColor,
                            fontSize: AllFontSize.ten,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 2,),
                    Text("Suspect", style: GoogleFonts.poppins(
                      color:saleCycleController.saleCycleList[0].salesCycleStatus!.toUpperCase()=="SUSPECT"? AllColors.primaryDark1:Colors.blueGrey,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500,
                    ),),
                    Container(width: size.width*.09,height: 1,color: AllColors.lightgreyColor,),
                  ],
                ),
              ),

              Container(
                child: Row(
                  children: [
                    Container(
                      height: 30.0,
                      width: 30.0,
                      decoration:
                      new BoxDecoration(
                        color:
                        saleCycleController.saleCycleList[0].salesCycleStatus!.toUpperCase()=="PROSPECT"? Colors.lightBlue:Colors.blueGrey,
                        borderRadius:
                        BorderRadius
                            .circular(20),
                      ),
                      child: Center(
                        child: Text("2",
                          style: GoogleFonts.poppins(
                            color: AllColors.whiteColor,
                            fontSize: AllFontSize.ten,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 2,),
                    Text("Prospect", style: GoogleFonts.poppins(
                      color: saleCycleController.saleCycleList[0].salesCycleStatus!.toUpperCase()=="PROSPECT"? AllColors.primaryDark1:Colors.blueGrey,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500,
                    ),),

                    Container(width: size.width*.09,height: 1,color: AllColors.lightgreyColor,),

                  ],
                ),
              ),

              Container(
                child: Row(
                  children: [
                    Container(
                      height: 30.0,
                      width: 30.0,
                      decoration:
                      new BoxDecoration(
                        color: saleCycleController.saleCycleList[0].salesCycleStatus!.toUpperCase()=="PROPOSE"? Colors.lightBlue:Colors.blueGrey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text("3",
                          style: GoogleFonts.poppins(
                            color:AllColors.whiteColor,
                            fontSize: AllFontSize.ten,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 2,),
                    Text("Propose", style: GoogleFonts.poppins(
                      color: saleCycleController.saleCycleList[0].salesCycleStatus!.toUpperCase()=="PROPOSE"? AllColors.primaryDark1:Colors.blueGrey,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500,
                    ),),

                  ],
                ),
              ),

            ],
          ),


    );
  }

 Widget bindClosureDate(BuildContext context) {
   return Padding(
     padding: const EdgeInsets.only(left: 15, right: 15),
     child: TextField(
       cursorColor:AllColors.primaryDark1 ,
       readOnly: (saleCycleController.saleCycleList[0].isReadySendForApproval==0 && (saleCycleController.FromPage.value == 'Sales'
           || saleCycleController.FromPage.value == 'FromTaskScreen' || saleCycleController.FromPage.value == 'Task' ))
           || saleCycleController.FromPage.value == 'Task' ||
           saleCycleController.FromPage.value == 'FromTaskScreen'?true:false,
       controller: saleCycleController.closureDateController.value,
       decoration: InputDecoration(
         contentPadding: EdgeInsets.symmetric(
             vertical: AllFontSize.two, horizontal: AllFontSize.ten
         ),
         hintText: 'Select Estimated Closure Date',
         labelText: 'Estimated Closure Date',
           hintStyle: GoogleFonts.poppins(
               color: AllColors.lightblackColor,
               fontWeight: FontWeight.w300,
               fontSize: AllFontSize.ten),
           labelStyle: GoogleFonts.poppins(
               color: AllColors.primaryDark1,
               fontWeight: FontWeight.w500,
               fontSize: AllFontSize.fourtine),
         enabledBorder: OutlineInputBorder(
           borderRadius: BorderRadius.all(Radius.circular(10)),
         ),
           focusedBorder: OutlineInputBorder(
             borderRadius: BorderRadius.all(Radius.circular(10)),
           )
       ),
       onTap: () async {
         if(saleCycleController.saleCycleList[0].isReadySendForApproval==1 && saleCycleController.FromPage.value == 'Sales'){
           DateTime? initialDate;
           if (saleCycleController.closureDateController.value.text.isNotEmpty) {
             initialDate = DateFormat('yyyy-MM-dd').parse(
               saleCycleController.closureDateController.value.text,
             );
             // Ensure initialDate is not before firstDate
             if (initialDate.isBefore(DateTime.now())) {
               initialDate = DateTime.now();
             }
           } else {
             initialDate = DateTime.now();
           }

           DateTime ending_date = new DateTime(2200);
           FocusScope.of(context).requestFocus(new FocusNode());
           DateTime? date = await showDatePicker(
             context: context,
             initialDate: initialDate,
             firstDate: DateTime.now(),
             lastDate: ending_date,
             builder: (BuildContext context, Widget? child) {
               return Theme(
                 data: ThemeData.light().copyWith(
                   primaryColor: AllColors.primaryDark1, // Header background color
                   //accentColor: AllColors.primaryDark1, // Color of the buttons
                   colorScheme: ColorScheme.light(primary: AllColors.primaryDark1),
                   buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
                 ),
                 child: child!,
               );
             },

           );
           var outputFormat = DateFormat('yyyy-MM-dd');
           if (date != null && date != "")
             saleCycleController.closureDateController.value.text= outputFormat.format(date);
          /* else
             saleCycleController.closureDateController.value.text = "";*/
         }



       },
     ),
   );
  }

  bindBudgetAmount(BuildContext context) {
    print("fgdsgh ${ saleCycleController.saleCycleList[0].isReadySendForApproval} ${saleCycleController.FromPage.value}");
      return Container(
        padding: EdgeInsets.fromLTRB(15, 5, 15, 10),
        width: size.width/2,
        child: TextField(
          readOnly:  (saleCycleController.saleCycleList[0].isReadySendForApproval==0   &&
              (saleCycleController.FromPage.value == 'Sales' || saleCycleController.FromPage.value == 'FromTaskScreen'
                 )) || saleCycleController.FromPage.value == 'Task' || saleCycleController.FromPage.value == 'FromTaskScreen'?true:false,
          cursorColor:AllColors.primaryDark1 ,
          controller: saleCycleController.budgetAmountController.value,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten),
            hintText: 'Enter Budget Amount',
            labelText: 'Budget Amount',
            hintStyle: GoogleFonts.poppins(
                color: AllColors.lightblackColor,
                fontWeight: FontWeight.w300,
                fontSize: AllFontSize.ten),
            labelStyle: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontWeight: FontWeight.w500,
                fontSize: AllFontSize.fourtine),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            )
          ),
        ),
      );

  }

  void openConfirmationDialog(BuildContext context, SalesCycleModal saleCycleList, String payloadMessage, String message) {
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title:  Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.check_circle, color: AllColors.lightredColor,),
                SizedBox(width: 5,),
                Text(
                    'Confirmation !',
                    style: GoogleFonts.poppins(
                      fontSize: AllFontSize.sisxteen,
                      fontWeight: FontWeight.w700,
                      color: AllColors.primaryDark1,
                    ))
              ],
            ),
            content: Container(
                /*height: size.height*.21,
                width: size.width*4,*/
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                        'Do you want to ${message} this sales cycle ?',
                        style: GoogleFonts.poppins(
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                          color: AllColors.primaryDark1,
                        )),
                    SizedBox(height: 10),
                   Obx((){
                     return Visibility(
                       visible: payloadMessage=="Rejected"?true:false,
                         child: bindRejectreason(context));
                   }),
            
                    SizedBox(height: 10),
                    Container(
                      width: size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                  AllColors.lightredColor,
                                ),
                              ),
                              onPressed: ()  {
                                Get.back();
                              },
                              child: Container(
                                child: Text('Cancel',
                                  /*accountMaster_page_controller.UploadImageType_controller.value =="Url"? 'Upload Url':'Choose files',*/
                                  style: GoogleFonts.poppins(
                                    color: AllColors.blackColor,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                  AllColors.greenblue,
                                ),
                              ),
                              onPressed: ()  {
                                print("message ...${payloadMessage}");
                                if(payloadMessage=="Pending For Approval") {
                                  saleCycleController.salesCycleMstUpdateApiHit(saleCycleList, 
                                      saleCycleController.proposedSolutionController.value.text, "", "", "", "Pending For Approval");
                                }
                                else{
                                  saleCycleController.salesCycleMstApprovereject(saleCycleList, saleCycleController.rejectReasonController.value.text, payloadMessage);
                                }

                                Get.back();
                              },
                              child: Container(
                                child: Text('Confirm',
                                  style: GoogleFonts.poppins(
                                    color: AllColors.blackColor,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
            ),
          );

        });

  }

  Widget bindRejectreason(BuildContext context) {
   return  TextField(
     cursorColor:AllColors.primaryDark1 ,
     controller: saleCycleController.rejectReasonController.value,
     decoration: InputDecoration(
         contentPadding: EdgeInsets.symmetric(
             vertical: AllFontSize.two, horizontal: AllFontSize.ten),
         hintText: 'Enter Reject Reason',
         labelText: 'Reject Reason',
         hintStyle: GoogleFonts.poppins(
             color: AllColors.lightblackColor,
             fontWeight: FontWeight.w300,
             fontSize: AllFontSize.ten),
         labelStyle: GoogleFonts.poppins(
             color: AllColors.primaryDark1,
             fontWeight: FontWeight.w500,
             fontSize: AllFontSize.sisxteen),
         enabledBorder: OutlineInputBorder(
           borderRadius: BorderRadius.all(Radius.circular(10)),
         ),
         border: OutlineInputBorder(
           borderRadius: BorderRadius.all(Radius.circular(10)),
         )
     ),
   );
  }


  /*Widget bindQuoteRejectreason(BuildContext context) {
    return  TextField(
      cursorColor:AllColors.primaryDark1 ,
      controller: saleCycleController.quoteRejectReasonController.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
          hintText: 'Quote Reject Reason',
          labelText: 'Quote Reject Reason',
          hintStyle: GoogleFonts.poppins(
              color: AllColors.lightblackColor,
              fontWeight: FontWeight.w300,
              fontSize: AllFontSize.ten),
          labelStyle: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontWeight: FontWeight.w500,
              fontSize: AllFontSize.sisxteen),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )
      ),
    );
  }*/

 Widget bindCustomerNeedIdentity(BuildContext context) {
   return Container(
     padding: const EdgeInsets.only(left: 15,  bottom: 10),
     child: DropdownMenu<String>(
       width: MediaQuery.of(context).size.width/2-16,
       controller: saleCycleController.customerNeedIdetityController.value,
       label: Text(
         "Customer Need Identity",
         style: GoogleFonts.poppins(
             color: AllColors.primaryDark1,
             fontSize: AllFontSize.fourtine,
             fontWeight: FontWeight.w700),
       ),

       inputDecorationTheme: const InputDecorationTheme(
         enabledBorder: OutlineInputBorder(
           borderRadius: BorderRadius.all(Radius.circular(10)),
           borderSide: BorderSide(
             color: AllColors.primaryDark1,),
         ),
         focusedBorder: OutlineInputBorder(
           borderSide: BorderSide(
               color: AllColors.primaryDark1), // Change the color to green
         ),

         border: OutlineInputBorder(
           borderSide: BorderSide(
               color: AllColors.primaryDark1), // Change the color to green
         ),
         filled: false,
         contentPadding: EdgeInsets.symmetric(
             vertical: AllFontSize.two, horizontal: AllFontSize.ten),
       ),
       //enabled: saleCycleController.saleCycleList[0].isReadySendForApproval!=1?false:true,
       enabled: saleCycleController.saleCycleList[0].approvedBy==saleCycleController.email || saleCycleController.saleCycleList[0].salesCycleApprovalStatus=="Rejected" || saleCycleController.FromPage != 'Sales'?false:true,
       onSelected: (String? selection) {
         print(selection);

         saleCycleController.customerNeedIdetityController.value.text =
             _displayCustomerNeedIdentityStatusForOption(selection!).toString();
         print('IsActive.....${saleCycleController.customerNeedIdetityController.value.text}');
         if(saleCycleController.customerNeedIdetityController.value.text=="Yes"){
           print('IsActive.....${saleCycleController.customerNeedIdetityController.value.text}');
           saleCycleController.ischangeNeedIdentity.value=true;
         }
         else{
           saleCycleController.ischangeNeedIdentity.value=false;
         }
       },

       dropdownMenuEntries: saleCycleController.customerNeedIdentityList.map<DropdownMenuEntry<String>>((String e) {
         return DropdownMenuEntry<String>(value: e, label: e!,style: ButtonStyle(
           foregroundColor: MaterialStateProperty.all<Color>(AllColors.primaryDark1),));
       }).toList(),
     ),
   );

  }

 Widget bindSolutionAccepted(BuildContext context) {
   return Container(
     padding: const EdgeInsets.only(left: 15,  bottom: 10),
     child: DropdownMenu<String>(
       width: MediaQuery.of(context).size.width*.94/2-16,
       controller: saleCycleController.solutionAcceptedController.value,
       label: Text(
         "Solution Accepted",
         style: GoogleFonts.poppins(
             color: AllColors.primaryDark1,
             fontSize: AllFontSize.fourtine,
             fontWeight: FontWeight.w700),
       ),

       inputDecorationTheme: const InputDecorationTheme(
         enabledBorder: OutlineInputBorder(
           borderSide: BorderSide(
             color: AllColors.primaryDark1,),
           borderRadius: BorderRadius.all(Radius.circular(10)),
         ),
         focusedBorder: OutlineInputBorder(
           borderSide: BorderSide(
               color: AllColors.primaryDark1), // Change the color to green
         ),
         border: OutlineInputBorder(
           borderSide: BorderSide(
               color: AllColors.primaryDark1), // Change the color to green
         ),
         filled: false,
         contentPadding: EdgeInsets.symmetric(
             vertical: AllFontSize.two, horizontal: AllFontSize.ten),
       ),
       //enabled: saleCycleController.saleCycleList[0].isReadySendForApproval!=1?false:true,
       enabled: saleCycleController.saleCycleList[0].approvedBy==saleCycleController.email || saleCycleController.saleCycleList[0].salesCycleApprovalStatus=="Rejected" || saleCycleController.FromPage != 'Sales'?false:true,
       onSelected: (String? selection) {
         print(selection);
         saleCycleController.solutionAcceptedController.value.text =
             _displayCustomerNeedIdentityStatusForOption(selection!).toString();
         print('IsActive.....${saleCycleController.solutionAcceptedController.value.text}');
         if(saleCycleController.solutionAcceptedController.value.text=="Yes"){
           saleCycleController.ischangesolutionAccepted.value=true;
         }else{
           saleCycleController.ischangesolutionAccepted.value=false;
         }
       },
       dropdownMenuEntries:
       saleCycleController.customerNeedIdentityList.map<DropdownMenuEntry<String>>((String e) {
         return DropdownMenuEntry<String>(value: e, label: e!,style: ButtonStyle(
           foregroundColor: MaterialStateProperty.all<Color>(AllColors.primaryDark1),));
       }).toList(),
     ),
   );

  }
  Widget BindProposedSolution(BuildContext context) {
    print("");
    return Container(
      margin: EdgeInsets.only(bottom: 30, left: 15, right: 15),
      child: TextField(
        //readOnly: saleCycleController.saleCycleList[0].isReadySendForApproval!=1?true:false,
        readOnly: saleCycleController.saleCycleList[0].approvedBy==saleCycleController.email ||  saleCycleController.saleCycleList[0].salesCycleApprovalStatus=="Rejected" ||
            saleCycleController.FromPage == 'Task' || saleCycleController.FromPage == 'FromTaskScreen'?true:false,
        cursorColor:AllColors.primaryDark1 ,
        controller: saleCycleController.proposedSolutionController.value,
        maxLength: 500,
        maxLines: 2,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.seven, horizontal: AllFontSize.ten),
            hintText: 'Proposed Solution',
            labelText: 'Proposed Solution',
            hintStyle: GoogleFonts.poppins(
                color: AllColors.lightblackColor,
                fontWeight: FontWeight.w300,
                fontSize: AllFontSize.ten),
            labelStyle: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontWeight: FontWeight.w700,
                fontSize: AllFontSize.sisxteen),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            )
        ),
      ),
    );
  }


  Widget BindSalesData(BuildContext context) {
    String? dateTimeCreatedOn=StaticMethod.dateTimeToDate(saleCycleController.saleCycleList[0].createdOn ?? "");
    String? dateTimeApprovedOn=StaticMethod.dateTimeToDate(saleCycleController.saleCycleList[0].approvedOn ?? "");
    String? expClosureDate=StaticMethod.convertDateFormat1(saleCycleController.saleCycleList[0].estClosureDate ?? "");
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.only(left: 15.0, right: 15.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: AllColors.grayColor, // Set the border color here
                width: 1.0, // Adjust the border width if necessary
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: InputDecorator(
              decoration: InputDecoration(
                labelText: 'Sales Details',
                labelStyle: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontWeight: FontWeight.w700,
                    fontSize: AllFontSize.twentee),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),

              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Task ID",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.sisxteen,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: (){
                          accountMaster_page_controller.view='Sales';
                          TaskMaster_page_controller.getTaskMaster(0,
                              TaskMaster_page_controller.is_Active
                                  .toString(),
                              saleCycleController
                                  .saleCycleList[0]
                                  .taskId,
                              '', 'GET FROM TASK ID', TaskMaster_page_controller.date_filter, TaskMaster_page_controller.is_done.value);
                          Get.toNamed(RoutesName.taskMasterDetails_screen);
                        },
                        child: Text(
                          saleCycleController
                              .saleCycleList[0]
                              .taskId ?? "",
                          style: GoogleFonts.poppins(
                            color: Colors.blueAccent,
                            fontSize: AllFontSize.sisxteen,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                            decorationStyle: TextDecorationStyle.wavy,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    children: [
                      Text(
                        "Sales Cycle Status",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Text(
                        saleCycleController
                            .saleCycleList[0]
                            .salesCycleStatus ?? "",
                        style: GoogleFonts.poppins(
                          color: AllColors.textColor,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    children: [
                      Text(
                        "Approval Status",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: size.width*.32,
                        child: Tooltip(
                          message: saleCycleController
                              .saleCycleList[0]
                              .salesCycleApprovalStatus.toString(),
                          child: Text(
                            saleCycleController
                                .saleCycleList[0]
                                .salesCycleApprovalStatus ?? "",
                            style: GoogleFonts.poppins(
                              color: AllColors.textColor,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.end,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),

                  Row(
                    children: [
                      Text(
                        "Account Name",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        child: Container(
                          width: size.width * .4,
                          child: Tooltip(
                            message: saleCycleController
                                .saleCycleList[0].accountName?? "",
                            child: Text(
                              saleCycleController
                                  .saleCycleList[0]
                                  .accountName ??
                                  "" ,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
                              style: GoogleFonts.poppins(
                                color: Colors.blueAccent,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline,
                                decorationStyle: TextDecorationStyle.wavy,),
                            ),
                          ),
                        ),
                        onTap: (){
                          accountMaster_page_controller.view='FromSaleDetailsScreen';
                          contact_vm_controller.view='FromSaleDetailsScreen';

                          accountMaster_page_controller.getAccMasterBuyCodeApi(saleCycleController
                              .saleCycleList[0]
                              .accountCode!);
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),

                  Row(
                    children: [
                      Text(
                        'Contact Name',
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Text(
                        saleCycleController
                            .saleCycleList[0]
                            .contactName ?? "",
                        style: GoogleFonts.poppins(
                          color: AllColors.textColor,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),

                  Row(
                    children: [
                      Text(
                        "Product Category",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Container(
                            width: size.width*.4,
                            child: Tooltip(
                              message:  saleCycleController
                                  .saleCycleList[0]
                                  .productCategory ?? "",
                              child: Text(
                                saleCycleController
                                    .saleCycleList[0]
                                    .productCategory!,
                                style: GoogleFonts.poppins(
                                  color: AllColors.textColor,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ),
                          SizedBox(width: 2,),
                          Visibility(
                            visible: saleCycleController.FromPage.value =='' || saleCycleController.email==saleCycleController
                                .saleCycleList[0].approvedBy ?false:true,
                            child: InkWell(
                                onTap: () {
                                  saleCycleController.itemCategorySelectedlist.value = [];
                                  for (int i = 0; i < saleCycleController.productCategoryList.length; i++) {
                                    if (saleCycleController.productCategoryList[i].isSelected == 1) {
                                      saleCycleController.itemCategorySelectedlist.add(
                                          saleCycleController.productCategoryList[i]);
                                      //TaskMaster_page_controller.Item_Category_code_list.add(TaskMaster_page_controller.Item_Category_master_list[i].categoryCode!);

                                      print(
                                          'LIstSIze.....${saleCycleController
                                              .itemCategorySelectedlist
                                              .length}');
                                    }
                                    else {
                                      print('NoLIstSIze.....');
                                    }
                                  }
                                  saleCycleController.productCategoryController.value.clear();
                                  showProductCatDialog(context);
                                },
                                child: Icon(Icons.add)),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),


                  Row(
                    children: [
                      Text(
                        "Created By",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: size.width *.4,
                        child: Tooltip(
                          message: saleCycleController
                              .saleCycleList[0].createdFullName ?? "",
                          child: Text(
                            saleCycleController
                                .saleCycleList[0].createdFullName ?? "",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.end,
                            style: GoogleFonts.poppins(
                                color: AllColors.textColor,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),

                  Row(
                    children:   [
                      Text(
                        "Created on",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Text(
                        dateTimeCreatedOn.toString(),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                        style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    children: [
                      Text(
                        "Manager Name",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: size.width *.3,
                        child: Obx(() {
                          return Tooltip(
                            message: saleCycleController
                                .saleCycleList[0].approvedFullName ?? '',

                            child: Text(
                              saleCycleController
                                  .saleCycleList[0]
                                  .approvedFullName ?? "",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
                              style: GoogleFonts.poppins(
                                  color: AllColors.textColor,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500),
                            ),
                          );

                        }),
                      )

                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),

                  Row(
                    children: [
                      Text(
                        "Approved On",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Text(
                        dateTimeApprovedOn.toString(),
                        style: GoogleFonts.poppins(
                          color: AllColors.textColor,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),


                  Row(
                    children: [
                      Text(
                        "Sales Cycle Remarks",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: size.width*.4,
                        child: Tooltip(
                          message: saleCycleController
                              .saleCycleList[0]
                              .salesCycleRemarks ?? "",
                          child: Text(
                            saleCycleController
                                .saleCycleList[0]
                                .salesCycleRemarks ?? "",
                            style: GoogleFonts.poppins(
                              color: AllColors.textColor,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    children: [
                      Text(
                        "Reject Reason",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: size.width*.4,
                        child: Tooltip(
                          message: saleCycleController
                              .saleCycleList[0]
                              .rejectReason!.toString(),
                          child: Text(
                            saleCycleController
                                .saleCycleList[0]
                                .rejectReason ?? "",
                            style: GoogleFonts.poppins(
                              color: AllColors.textColor,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),

                  Row(
                    children: [
                      Text(
                        "No. of Quotation",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Text(
                        saleCycleController
                            .saleCycleList[0]
                            .noOfQuotation.toString(),
                        style: GoogleFonts.poppins(
                          color: AllColors.textColor,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    children: [
                      Text(
                        "Est. Closure Date",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Text(
                        expClosureDate.toString(),
                        style: GoogleFonts.poppins(
                          color: AllColors.textColor,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    children:   [
                      Text(
                        "Budget Amount",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: size.width *.4,
                        child: Tooltip(
                          message: saleCycleController.budgetAmountList.isEmpty?
                          saleCycleController
                              .saleCycleList[0]
                              .budgetAmount!.toString():saleCycleController.budgetAmountList[0].totalBudgetAmount,
                          child: Text(
                            saleCycleController.budgetAmountList.isEmpty?
                            saleCycleController
                                .saleCycleList[0]
                                .budgetAmount!.toString():saleCycleController.budgetAmountList[0].totalBudgetAmount??"",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.end,
                            style: GoogleFonts.poppins(
                                color: AllColors.textColor,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    children:   [
                      Text(
                        "Expected Amount",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: size.width *.4,
                        child: Tooltip(
                          message: saleCycleController.budgetAmountList.isEmpty?
                          saleCycleController
                              .saleCycleList[0]
                              .estBudgetAmount!.toString():saleCycleController.budgetAmountList[0].totalEstimatedAmount,
                          child: Text(
                            saleCycleController.budgetAmountList.isEmpty?
                            saleCycleController
                                .saleCycleList[0]
                                .estBudgetAmount!.toString():saleCycleController.budgetAmountList[0].totalEstimatedAmount??"",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.end,
                            style: GoogleFonts.poppins(
                                color: AllColors.textColor,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    children: [
                      Text(
                        "Customer Need Identity",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Text(
                        saleCycleController
                            .saleCycleList[0]
                            .isCustomerNeedIdentify==0?"No":"Yes",
                        style: GoogleFonts.poppins(
                          color: AllColors.textColor,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    children: [
                      Text(
                        "Solution Accepted",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Text(
                        saleCycleController
                            .saleCycleList[0]
                            .isSolutionAccepted==0?"No":"Yes",
                        style: GoogleFonts.poppins(
                          color: AllColors.textColor,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    children: [
                      Text(
                        "Proposed Solution",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: size.width*.4,
                        child: Tooltip(
                          message: saleCycleController
                              .saleCycleList[0]
                              .proposedSolution.toString(),
                          child: Text(saleCycleController
                              .saleCycleList[0]
                              .proposedSolution==null?"":
                            saleCycleController
                                .saleCycleList[0]
                                .proposedSolution.toString(),
                            style: GoogleFonts.poppins(
                              color: AllColors.textColor,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.end,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),

                  Row(
                    children: [
                      Text(
                        "Quote Accepted",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: (){
                          saleCycleController.quoteWonList.length>0?
                          ShowQuoteWon(context):"";
                        },
                        child: Container(
                          width: size.width*.4,
                          child: Tooltip(
                            message: saleCycleController
                                .saleCycleList[0]
                                .quoteAccepted.toString(),
                            child: Text(saleCycleController
                                .saleCycleList[0]
                                .quoteAccepted==null?"":
                            saleCycleController
                                .saleCycleList[0]
                                .quoteAccepted.toString(),
                              style: GoogleFonts.poppins(
                                color: Colors.blueAccent,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline,
                                decorationStyle: TextDecorationStyle.wavy,),
                              textAlign: TextAlign.end,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    children: [
                      Text(
                        "Competitor Name",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: size.width*.4,
                        child: Tooltip(
                          message: saleCycleController
                              .saleCycleList[0]
                              .competitorName.toString(),
                          child: Text(saleCycleController
                              .saleCycleList[0]
                              .competitorName==null?"":
                          saleCycleController
                              .saleCycleList[0]
                              .competitorName.toString(),
                            style: GoogleFonts.poppins(
                              color: AllColors.textColor,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.end,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    children: [
                      Text(
                        "Quote Reject Reason",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: size.width*.4,
                        child: Tooltip(
                          message: saleCycleController
                              .saleCycleList[0]
                              .quoteRejectedReason.toString(),
                          child: Text(saleCycleController
                              .saleCycleList[0]
                              .quoteRejectedReason==null?"":
                          saleCycleController
                              .saleCycleList[0]
                              .quoteRejectedReason.toString(),
                            style: GoogleFonts.poppins(
                              color: AllColors.textColor,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.end,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),

                  Obx((){
                    return Visibility(
                        visible: saleCycleController.saleCycleList[0].salesCycleStatus!.toUpperCase()=="PROSPECT" || saleCycleController.saleCycleList[0].salesCycleStatus!.toUpperCase()=="PROPOSE"?true:false,
                        child: Row(
                          children: [
                            Text(
                              "Product Category Table",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            InkWell(
                              onTap: (){
                                ShowProductCategoryTable(context, saleCycleController.budgetAmountList);
                                //showInfraLeadDetails(context, saleCycleController.saleCycleList);
                              },
                              child: Text('View',
                                style: GoogleFonts.poppins(
                                  color: Colors.blueAccent,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                  decorationStyle: TextDecorationStyle.wavy,),
                                textAlign: TextAlign.end,

                              ),
                            ),
                          ],
                        ),);
                  }),

                  Obx((){
                    return Visibility(
                      visible: saleCycleController.saleCycleList[0].salesCycleStatus!.toUpperCase()=="PROSPECT" || saleCycleController.saleCycleList[0].salesCycleStatus!.toUpperCase()=="PROPOSE"?true:false,
                        child:
                        SizedBox(
                          height: 3,
                        ),);
                  }),


                  Row(
                    children: [
                      Text(
                        "Is Infra Lead",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: (){
                          showInfraLeadDetails(context, saleCycleController.saleCycleList);
                        },
                        child: Text(saleCycleController
                            .saleCycleList[0]
                            .isInfraLead==1?"Yes":"No",
                          style: GoogleFonts.poppins(
                            color: Colors.blueAccent,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                            decorationStyle: TextDecorationStyle.wavy,),
                          textAlign: TextAlign.end,

                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                ],
              ),

            ),
          ),
        ],
      ),
    );
    }

Widget bindQuoteData(BuildContext context) {
    print("Lengh${saleCycleController.quoteList.value.length}");
  if (saleCycleController.quoteList.value.isNotEmpty && saleCycleController.quoteList.value.length > 0) {
    ScrollController scrollController = ScrollController();
    scrollController.addListener(() {
      print("ghdjhgf");
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {

        int total_page = (saleCycleController.total_rows /
            saleCycleController.rowsPerPage)
            .toInt();
        if ((saleCycleController.total_rows %
            saleCycleController.rowsPerPage) >
            0) total_page += 1;

        print(
            "last index ${saleCycleController.pageNumberForQuote} ${saleCycleController.total_rows} ${saleCycleController.rowsPerPage} ${total_page}");
        if (saleCycleController.pageNumberForQuote + 1 < total_page) {
          saleCycleController.getQuoteHeaderData(saleCycleController.pageNumberForQuote + 1,saleCycleController.salesCycleId.value, '');
          saleCycleController.pageNumberForQuote += 1;
        }
      }
    });
    return Obx(() {
      return  Container(
        height: size.height/2,
        child: ListView.separated(
            controller: scrollController,
            padding: EdgeInsets.only(bottom: 10),
            separatorBuilder: (context, index) => Divider(height: .05, color: Colors.transparent,),
            shrinkWrap: true,
            itemCount: saleCycleController.quoteList.value.length,
            itemBuilder: (BuildContext context, int index) {
              return bindPendingListView(context, index);
            }),
      );
    },
    );
  }
  else {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 18.0),
        child: Text(
          'No Record Found.',
          style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontSize: AllFontSize.twentee,
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  }

  Widget bindPendingListView(BuildContext context, int index) {
    String? expClosureDate=StaticMethod.convertDateFormat1(saleCycleController.quoteList[index].expClosureDate ?? "");
    String? quoteValidity=StaticMethod.convertDateFormat1(saleCycleController.quoteList[index].quoteValidity ?? "");
    String saleCycleStatus = saleCycleController.quoteList[index].quoteStatus??"";
    Color getStatusColor(String status) {
      switch (status) {
        case 'Pending':
          return Colors.yellow[700]!;
        case 'REGRET':
          return Colors.red;
        case 'Approved':
          return Colors.green;
        case 'WON':
          return Colors.green;
        case 'PENDING FOR APPROVAL':
          return Colors.yellow[700]!;
        default:
          return Colors.black;
      }
    }
    String? dateCreatedOn=StaticMethod.dateTimeToDate(saleCycleController.quoteList[index].createdOn??"");
       return Card(
         //margin: EdgeInsets.all(5),
         child: ListTile(
           contentPadding: EdgeInsets.only(left: 5, right: 10),
           title:Row(
             children: [
               Text(
                 "Quote Id : ",
                 style: GoogleFonts.poppins(
                   color: AllColors.primaryDark1,
                   fontSize: AllFontSize.fourtine,
                   fontWeight: FontWeight.w800,
                 ),
               ),
               Text(
                 saleCycleController
                     .quoteList[index]
                     .quoteId??"",
                 style: GoogleFonts.poppins(
                   color: AllColors.textColor,
                   fontSize: AllFontSize.fourtine,
                   fontWeight: FontWeight.w800,
                 ),
               ),
             ],
           ),
             subtitle: Column(
               mainAxisAlignment: MainAxisAlignment.start,
               children: [
                 Row(
                   children: [
                     Text(
                       "Quote Version : ",
                       style: GoogleFonts.poppins(
                         color: AllColors.primaryDark1,
                         fontSize: AllFontSize.twelve,
                         fontWeight: FontWeight.w500,
                       ),
                     ),
                     Text(
                       (saleCycleController
                           .quoteList[index]
                           .quoteVersion.toString()) ,
                       style: GoogleFonts.poppins(
                         color: AllColors.textColor,
                         fontSize: AllFontSize.twelve,
                         fontWeight: FontWeight.w500,
                       ),
                     ),
                   ],
                 ),

                 Row(
                   children: [
                     Text(
                       "Product Category : ",
                       style: GoogleFonts.poppins(
                         color: AllColors.primaryDark1,
                         fontSize: AllFontSize.twelve,
                         fontWeight: FontWeight.w500,
                       ),
                     ),

                     Container(
                       width: size.width*.4,
                       child: Tooltip(
                         message:  saleCycleController
                             .quoteList[index]
                             .productCategory ?? "",
                         child: Text(
                           saleCycleController
                               .quoteList[index]
                               .productCategory ??"",
                           style: GoogleFonts.poppins(
                             color: AllColors.textColor,
                             fontSize: AllFontSize.twelve,
                             fontWeight: FontWeight.w500,
                           ),
                           overflow: TextOverflow.ellipsis,
                           textAlign: TextAlign.start,
                         ),
                       ),
                     ),
                   ],
                 ),
                 Row(

                   children: [
                     Text(
                       "Quote Status : ",
                       style: GoogleFonts.poppins(
                         color:AllColors.primaryDark1,
                         fontSize: AllFontSize.twelve,
                         fontWeight: FontWeight.w500,
                       ),
                     ),
                     Text(
                       saleCycleController
                           .quoteList[index]
                           .quoteStatus??"",
                       style: GoogleFonts.poppins(
                         color: getStatusColor(saleCycleStatus),
                         fontSize: AllFontSize.twelve,
                         fontWeight: FontWeight.w500,
                       ),
                     ),
                   ],
                 ),
                 Row(
                   children: [
                     Text(
                       "Quote Validity : ",
                       style: GoogleFonts.poppins(
                         color: AllColors.primaryDark1,
                         fontSize: AllFontSize.twelve,
                         fontWeight: FontWeight.w500,
                       ),
                     ),

                     Text(
                      quoteValidity.toString(),
                       style: GoogleFonts.poppins(
                         color: AllColors.textColor,
                         fontSize: AllFontSize.twelve,
                         fontWeight: FontWeight.w500,
                       ),
                     ),
                   ],
                 ),
                /* Row(

                   children: [
                     Text(
                       "Contact Person Name : ",
                       style: GoogleFonts.poppins(
                         color: AllColors.primaryDark1,
                         fontSize: AllFontSize.twelve,
                         fontWeight: FontWeight.w500,
                       ),
                     ),

                     Text(
                       saleCycleController
                           .quoteList[index]
                           .contactName??"",
                       style: GoogleFonts.poppins(
                         color: AllColors.textColor,
                         fontSize: AllFontSize.twelve,
                         fontWeight: FontWeight.w500,
                       ),
                     ),
                   ],
                 ),*/
                 Row(
                   children: [
                     Text(
                       "Expected Closure Date : ",
                       style: GoogleFonts.poppins(
                         color: AllColors.primaryDark1,
                         fontSize: AllFontSize.twelve,
                         fontWeight: FontWeight.w500,
                       ),
                     ),

                     Text(
                       expClosureDate.toString(),
                       style: GoogleFonts.poppins(
                         color: AllColors.textColor,
                         fontSize: AllFontSize.twelve,
                         fontWeight: FontWeight.w500,
                       ),
                     ),
                   ],
                 ),

                 Row(
                   children: [
                     Text(
                       "Quote Total Amount : ",
                       style: GoogleFonts.poppins(
                         color: AllColors.primaryDark1,
                         fontSize: AllFontSize.twelve,
                         fontWeight: FontWeight.w500,
                       ),
                     ),

                     Text(
                       saleCycleController
                           .quoteList[index]
                           .quoteTotalAmount.toString(),
                       style: GoogleFonts.poppins(
                         color: AllColors.textColor,
                         fontSize: AllFontSize.twelve,
                         fontWeight: FontWeight.w500,
                       ),
                     ),
                   ],
                 ),
                 Row(
                   children: [
                     Text(
                       "Quote GST Amount : ",
                       style: GoogleFonts.poppins(
                         color: AllColors.primaryDark1,
                         fontSize: AllFontSize.twelve,
                         fontWeight: FontWeight.w500,
                       ),
                     ),

                     Text(
                       saleCycleController
                           .quoteList[index]
                           .quoteGstAmount.toString(),
                       style: GoogleFonts.poppins(
                         color: AllColors.textColor,
                         fontSize: AllFontSize.twelve,
                         fontWeight: FontWeight.w500,
                       ),
                     ),
                   ],
                 ),
                 Row(
                   children: [
                     Text(
                       "Quote Gross Amount : ",
                       style: GoogleFonts.poppins(
                         color: AllColors.primaryDark1,
                         fontSize: AllFontSize.twelve,
                         fontWeight: FontWeight.w500,
                       ),
                     ),

                     Text(
                       saleCycleController
                           .quoteList[index]
                           .quoteGrossAmount.toString(),
                       style: GoogleFonts.poppins(
                         color: AllColors.textColor,
                         fontSize: AllFontSize.twelve,
                         fontWeight: FontWeight.w500,
                       ),
                     ),
                   ],
                 ),

                 Row(
                   children: [
                     Text(
                       "Created By :",
                       style: GoogleFonts.poppins(
                         color: AllColors.primaryDark1,
                         fontSize: AllFontSize.twelve,
                         fontWeight: FontWeight.w500,
                       ),
                     ),

                     Text(
                       saleCycleController
                           .quoteList[index]
                           .createdFullName??"",
                       style: GoogleFonts.poppins(
                         color: AllColors.textColor,
                         fontSize: AllFontSize.twelve,
                         fontWeight: FontWeight.w500,
                       ),
                     ),
                   ],
                 ),
                 Row(

                   children: [
                     Text(
                       "Created On : ",
                       style: GoogleFonts.poppins(
                         color: AllColors.primaryDark1,
                         fontSize: AllFontSize.twelve,
                         fontWeight: FontWeight.w500,
                       ),
                     ),

                     Text(
                       dateCreatedOn.toString(),
                       style: GoogleFonts.poppins(
                         color: AllColors.textColor,
                         fontSize: AllFontSize.twelve,
                         fontWeight: FontWeight.w500,
                       ),
                     ),
                   ],
                 ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.end,
                   children: [
                     Text(
                       "Is Active : ",
                       style: GoogleFonts.poppins(
                         color: AllColors.primaryDark1,
                         fontSize: AllFontSize.twelve,
                         fontWeight: FontWeight.w500,
                       ),
                     ),
                     SizedBox(width: 10),
                     Text(
                       saleCycleController
                           .quoteList[index]
                           .isActive==0?"No":"Yes",
                       style: GoogleFonts.poppins(
                         color: AllColors.textColor,
                         fontSize: AllFontSize.twelve,
                         fontWeight: FontWeight.w500,
                       ),
                     ),
                   ],
                 ),
               ],
             ),
           trailing: Row(
             mainAxisSize: MainAxisSize.min,
             children: [
               Visibility(
                 //visible: true,
                 visible: saleCycleController.saleCycleList[0].createdBy==saleCycleController.email && saleCycleController.FromPage == 'Sales'?true:false,
                 child: InkWell(
                   onTap: (){
                      showConfirmationDialog(context, saleCycleController
                          .quoteList[index]
                          .quoteId??"");
                   },
                     child: Icon(Icons.add_chart ,color: Colors.blueAccent,)),
               ),
               SizedBox(width: 8,),
               InkWell(
                   onTap: (){
                     saleCycleController.quoteId.value=saleCycleController.quoteList[index].quoteId!;
                     saleCycleController.getQuoteHeaderInformation(saleCycleController.quoteList[index].quoteId, "");
                   },
                   child: Icon(Icons.remove_red_eye, color: Colors.blueAccent,)),
             ],
           ),
         ),
       );
  }

  /*Widget bindUpdateSalesCycle(BuildContext context) {
    *//*return DropdownMenu<String>(
      width: size.width-195,
      controller: saleCycleController.updateQuoteAccetedCycleController.value,
      label: Text(
        "Quote Accepted",
        style: GoogleFonts.poppins(
            color: AllColors.primaryDark1,
            fontSize: AllFontSize.fourtine,
            fontWeight: FontWeight.w700),
      ),

      inputDecorationTheme: const InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: AllColors.primaryDark1,),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: AllColors.primaryDark1), // Change the color to green
        ),

        border: OutlineInputBorder(
          borderSide: BorderSide(
              color: AllColors.primaryDark1), // Change the color to green
        ),
        filled: false,
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.ten),
      ),
      enabled: saleCycleController.saleCycleList[0].isReadySendForApproval!=1?false:true,
      onSelected: (String? selection) {
        print(selection);
        saleCycleController.updateQuoteAccetedCycleController.value.text =
            _displayCustomerNeedIdentityStatusForOption(selection!).toString();
        print('IsActive.....${saleCycleController.updateQuoteAccetedCycleController.value.text}');
        if(saleCycleController.updateQuoteAccetedCycleController.value.text=="WON"){
          saleCycleController.isApprove.value=true;
          saleCycleController.isReject.value=false;
        }
        else if(saleCycleController.updateQuoteAccetedCycleController.value.text=="LOSS"){
          saleCycleController.competitorNameController.value.clear();
          saleCycleController.quoteRejectReasonController.value.clear();
          saleCycleController.isReject.value=true;
          saleCycleController.isApprove.value=false;
        }
        else{
          saleCycleController.isApprove.value=false;
          saleCycleController.isReject.value=false;
        }
      },

      dropdownMenuEntries: saleCycleController.quoteAcceptedList.map<DropdownMenuEntry<String>>((String e) {
        return DropdownMenuEntry<String>(value: e, label: e!,style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(AllColors.primaryDark1),));
      }).toList(),
    );*//*

    return Autocomplete<String>(
      displayStringForOption: _displayCustomerNeedIdentityStatusForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return saleCycleController.quoteAcceptedList;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return saleCycleController.quoteAcceptedList
            .where((String option) {
          return option
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (String selection) {
        print(selection);
        saleCycleController.updateQuoteAccetedCycleController.value.text =
            _displayCustomerNeedIdentityStatusForOption(selection!).toString();
        print('IsActive.....${saleCycleController.updateQuoteAccetedCycleController.value.text}');
        if(saleCycleController.updateQuoteAccetedCycleController.value.text=="WON"){
          saleCycleController.selectedQuotationIdController.value.clear();
          saleCycleController.isChooseQuote.value = true;
          saleCycleController.isApprove.value=false;
          saleCycleController.isReject.value=false;
        }
        else if(saleCycleController.updateQuoteAccetedCycleController.value.text=="LOSS"){
          saleCycleController.competitorNameController.value.clear();
          saleCycleController.quoteRejectReasonController.value.clear();
          saleCycleController.isReject.value=true;
          saleCycleController.isApprove.value=false;
          saleCycleController.isChooseQuote.value = false;
        }
        else{
          saleCycleController.isApprove.value=false;
          saleCycleController.isReject.value=false;
          saleCycleController.isChooseQuote.value = false;
        }
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          onTap: (){
            saleCycleController.updateQuoteAccetedCycleController.value.clear();
          },
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text =  saleCycleController.updateQuoteAccetedCycleController.value.text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
              suffixIcon: Icon(Icons.arrow_drop_down_sharp),
              contentPadding: EdgeInsets.symmetric(
                  vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
              hintText: 'Quote Accepted',
              labelText: 'Quote Accepted',
              hintStyle: GoogleFonts.poppins(
                  color: AllColors.lightblackColor,
                  fontWeight: FontWeight.w300,
                  fontSize: AllFontSize.ten),
              labelStyle: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w500,
                  fontSize: AllFontSize.sisxteen),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              )
          ),
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<String> onSelected,
          Iterable<String> suggestions) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: Container(
              width: size.width*.5,
              constraints: BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final String option =
                  suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option,
                        style: GoogleFonts.poppins(
                            color: AllColors.blackColor,
                            fontWeight: FontWeight.w300,
                            fontSize: AllFontSize
                                .sisxteen // Change the text color here
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );

  }*/

  Widget bindQuoteWonData(BuildContext context) {
    print("Lengh${saleCycleController.quoteWonList.value.length}");
    if (saleCycleController.quoteWonList.value.isNotEmpty && saleCycleController.quoteWonList.value.length > 0) {
      ScrollController scrollController = ScrollController();
      /*scrollController.addListener(() {
        print("ghdjhgf");
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {

          int total_page = (saleCycleController.total_rows /
              saleCycleController.rowsPerPage)
              .toInt();
          if ((saleCycleController.total_rows %
              saleCycleController.rowsPerPage) >
              0) total_page += 1;

          print(
              "last index ${saleCycleController.pageNumberForQuote} ${saleCycleController.total_rows} ${saleCycleController.rowsPerPage} ${total_page}");
          if (saleCycleController.pageNumberForQuote + 1 < total_page) {
            //saleCycleController.getQuoteWonData(pageNumberForQuote,saleCycleList[0].salesCycleId!);
            saleCycleController.getQuoteWonData(saleCycleController.pageNumberForQuote + 1,saleCycleController.salesCycleId.value);
            saleCycleController.pageNumberForQuote += 1;
          }
        }
      });*/
      return Obx(() {
        return  Container(
          height: size.height/2,
          child: ListView.separated(
              controller: scrollController,
              padding: EdgeInsets.only(bottom: 10),
              separatorBuilder: (context, index) => Divider(height: .05, color: Colors.transparent,),
              shrinkWrap: true,
              itemCount: saleCycleController.quoteWonList.value.length,
              itemBuilder: (BuildContext context, int index) {
                return bindQuoteWonListView(context, index);
              }),
        );
      },
      );
    }
    else {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Text(
            'No Record Found.',
            style: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontSize: AllFontSize.twentee,
                fontWeight: FontWeight.w700),
          ),
        ),
      );
    }

  }

  Widget bindQuoteWonListView(BuildContext context, int index) {
   // String? expClosureDate=StaticMethod.convertDateFormat1(saleCycleController.quoteList[index].expClosureDate ?? "");
    //String? quoteValidity=StaticMethod.convertDateFormat1(saleCycleController.quoteList[index].quoteValidity ?? "");
    //String saleCycleStatus = saleCycleController.quoteList[index].quoteStatus??"";
    /*Color getStatusColor(String status) {
      switch (status) {
        case 'Pending':
          return Colors.yellow[700]!;
        case 'WON':
          return Colors.red;
        case 'Approved':
          return Colors.green;
        case 'PENDING FOR APPROVAL':
          return Colors.yellow[700]!;
        default:
          return Colors.black;
      }
    }*/
   // String? dateCreatedOn=StaticMethod.dateTimeToDate(saleCycleController.quoteList[index].createdOn??"");
    return Card(
      //margin: EdgeInsets.all(5),
      child: ListTile(
        onTap: (){
          saleCycleController.quoteId.value=saleCycleController.quoteList[index].quoteId!;
          saleCycleController.getQuoteHeaderInformation(saleCycleController.quoteList[index].quoteId, "");
        },
        contentPadding: EdgeInsets.only(left: 5, right: 10),
        title:Row(
          children: [
            Text(
              "Quote Id : ",
              style: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontSize: AllFontSize.fourtine,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              saleCycleController
                  .quoteWonList[index]
                  .quoteId??"",
              style: GoogleFonts.poppins(
                color: AllColors.textColor,
                fontSize: AllFontSize.fourtine,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        /*subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Quote Version : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  (saleCycleController
                      .quoteList[index]
                      .quoteVersion.toString()) ,
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Text(
                  "Product Category : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                Container(
                  width: size.width*.4,
                  child: Tooltip(
                    message:  saleCycleController
                        .quoteList[index]
                        .productCategory ?? "",
                    child: Text(
                      saleCycleController
                          .quoteList[index]
                          .productCategory ??"",
                      style: GoogleFonts.poppins(
                        color: AllColors.textColor,
                        fontSize: AllFontSize.twelve,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
              ],
            ),
            Row(

              children: [
                Text(
                  "Quote Status : ",
                  style: GoogleFonts.poppins(
                    color:AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  saleCycleController
                      .quoteList[index]
                      .quoteStatus??"",
                  style: GoogleFonts.poppins(
                    color: getStatusColor(saleCycleStatus),
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Quote Validity : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                Text(
                  quoteValidity.toString(),
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
             Row(

                   children: [
                     Text(
                       "Contact Person Name : ",
                       style: GoogleFonts.poppins(
                         color: AllColors.primaryDark1,
                         fontSize: AllFontSize.twelve,
                         fontWeight: FontWeight.w500,
                       ),
                     ),

                     Text(
                       saleCycleController
                           .quoteList[index]
                           .contactName??"",
                       style: GoogleFonts.poppins(
                         color: AllColors.textColor,
                         fontSize: AllFontSize.twelve,
                         fontWeight: FontWeight.w500,
                       ),
                     ),
                   ],
                 ),
            Row(
              children: [
                Text(
                  "Expected Closure Date : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                Text(
                  expClosureDate.toString(),
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Text(
                  "Quote Total Amt. : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                Text(
                  saleCycleController
                      .quoteList[index]
                      .quoteTotalAmount.toString()??"",
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Quote Gross Amt. : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                Text(
                  saleCycleController
                      .quoteList[index]
                      .quoteGrossAmount.toString()??"",
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Quote Gross Amt. : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                Text(
                  saleCycleController
                      .quoteList[index]
                      .quoteGrossAmount.toString()??"",
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Text(
                  "Created By :",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                Text(
                  saleCycleController
                      .quoteList[index]
                      .createdFullName??"",
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Row(

              children: [
                Text(
                  "Created On : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                Text(
                  dateCreatedOn.toString(),
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Is Active : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  saleCycleController
                      .quoteList[index]
                      .isActive==0?"No":"Yes",
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),*/
        trailing: InkWell(
            onTap: (){
              saleCycleController.quoteId.value=saleCycleController.quoteList[index].quoteId!;
              saleCycleController.getQuoteHeaderInformation(saleCycleController.quoteList[index].quoteId, "");
            },
            child: Icon(Icons.remove_red_eye, color: Colors.blueAccent,)),
      ),
    );
  }

  showConfirmationDialog(context, String quoteId){
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title:  Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.check_circle, color: AllColors.lightredColor,),
                SizedBox(width: 5,),
                Text(
                    'Update!',
                    style: GoogleFonts.poppins(
                      fontSize: AllFontSize.sisxteen,
                      fontWeight: FontWeight.w700,
                      color: AllColors.primaryDark1,
                    ))
              ],
            ),
            content: Wrap(
                children: [
                  Column(
                    children: [
                      Text(
                          'Do you want to Create Duplicate Header of this Quote Id ?',
                          style: GoogleFonts.poppins(
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500,
                            color: AllColors.primaryDark1,
                          )),

                      SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                AllColors.lightredColor,
                              ),
                            ),
                            onPressed: ()  {
                              Get.back();

                            },
                            child: Container(
                              width: 60,
                              alignment: Alignment.center,
                              child: Text('Cancel',
                                style: GoogleFonts.poppins(
                                  color: AllColors.blackColor,
                                  fontSize: AllFontSize.twelve,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                AllColors.greenblue,
                              ),
                            ),
                            onPressed: ()  {
                              saleCycleController.QuoteHeaderDupicateCreate(quoteId);
                              Get.back();
                            },
                            child: Container(
                              width: 60,
                              alignment: Alignment.center,
                              child: Text('Confirm',
                                style: GoogleFonts.poppins(
                                  color: AllColors.blackColor,
                                  fontSize: AllFontSize.twelve,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ]),
          );

        });
  }

  /*showWonLossConfirmationDialog(context, SalesCycleModal saleCycleList){
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title:  Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.check_circle, color: AllColors.lightredColor,),
                SizedBox(width: 5,),
                Text(
                    'Update!',
                    style: GoogleFonts.poppins(
                      fontSize: AllFontSize.sisxteen,
                      fontWeight: FontWeight.w700,
                      color: AllColors.primaryDark1,
                    ))
              ],
            ),
            content: Wrap(
                children: [
                  Column(
                    children: [
                      Text(
                          'Do you want to update Sales Cycle ?',
                          style: GoogleFonts.poppins(
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500,
                            color: AllColors.primaryDark1,
                          )),

                      SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                AllColors.lightredColor,
                              ),
                            ),
                            onPressed: ()  {
                              Get.back();
                              *//*saleCycleController.salesCycleMstUpdateApiHit(saleCycleList,
                                  saleCycleController.proposedSolutionController.value.text, saleCycleController.updateQuoteAccetedCycleController.value.text
                                  , saleCycleController.competitorNameController.value.text, saleCycleController.quoteRejectReasonController.value.text, "");
*//*

                            },
                            child: Container(
                              width: 60,
                              alignment: Alignment.center,
                              child: Text('Cancel',
                                style: GoogleFonts.poppins(
                                  color: AllColors.blackColor,
                                  fontSize: AllFontSize.twelve,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                AllColors.greenblue,
                              ),
                            ),
                            onPressed: ()  {
                              saleCycleController.salesCycleMstUpdateApiHit(saleCycleList,
                                  saleCycleController.proposedSolutionController.value.text, saleCycleController.updateQuoteAccetedCycleController.value.text
                                  , "", "", "");
                              Get.back();
                            },
                            child: Container(
                              width: 60,
                              alignment: Alignment.center,
                              child: Text('Confirm',
                                style: GoogleFonts.poppins(
                                  color: AllColors.blackColor,
                                  fontSize: AllFontSize.twelve,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ]),
          );

        });
  }*/

/*
  void showDialogForsalescycleUpdate(BuildContext context, SalesCycleModal saleCycleList, ) {
    showDialog(
      // barrierDismissible: false,
        context: context,
        builder: (context){
          return AlertDialog(
            title:  Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.check_circle, color: AllColors.lightredColor,),
                SizedBox(width: 5,),
                Text(
                    'Update Sales Cycles',
                    style: GoogleFonts.poppins(
                      fontSize: AllFontSize.sisxteen,
                      fontWeight: FontWeight.w700,
                      color: AllColors.primaryDark1,
                    ))
              ],
            ),
            content: Container(
                */
/*height: size.height*.3,
                width: size.width*4,*//*

                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                     bindUpdateSalesCycle(context),

                    SizedBox(height: 10,),

                    Obx(() {
                      return Visibility(

                        //visible: saleCycleController.selectedQuotationIdController.value.text.isNotEmpty,
                          visible: saleCycleController.isApprove.value,
                          child: selectedQuotation(context));

                    }),
                    SizedBox(height: 10,),

                    Obx((){
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Visibility(
                            visible: saleCycleController.isChooseQuote.value,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                  AllColors.greenblue,
                                ),
                              ),
                              onPressed: ()  {
                                saleCycleController.pageNumberForQuote = 0;
                                saleCycleController.getQuoteHeaderData(saleCycleController.pageNumberForQuote,saleCycleController.salesCycleId.value, "Approved");
                                */
/*Get.toNamed(RoutesName.approvedQuotationListScreen)?.then((_) {
                                  print('Reopen Dialog');
                                  // Reopen the dialog when coming back from the other page
                                  showDialogForsalescycleUpdate(context, saleCycleList);
                                });*//*

                               // navigateAndShowDialog(context, saleCycleList);
                                Get.toNamed(RoutesName.approvedQuotationListScreen);

                              //  showApprovedQuotation(context);


                              },
                              child: Container(
                                child: Text('Choose Quotation',
                                  style: GoogleFonts.poppins(
                                    color: AllColors.blackColor,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),

                        ],
                      );
                    }),
                    Obx((){
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Visibility(
                            visible: saleCycleController.isApprove.value,
                           // visible: saleCycleController.selectedQuotationIdController.value.text == '' ? false:true,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                  AllColors.greenblue,
                                ),
                              ),
                              onPressed: ()  {
                                navigator?.pop(context);
                                showWonLossConfirmationDialog(context, saleCycleList);

                              },
                              child: Container(
                                child: Text('Approve',
                                  style: GoogleFonts.poppins(
                                    color: AllColors.blackColor,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),

                        ],
                      );
                    }),
                    Obx((){
                      return   Visibility(
                        visible: saleCycleController.isReject.value,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            competitorname( context),
                            SizedBox(height: 10),
                            bindQuoteRejectreason(context),
                            SizedBox(height: 6,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(
                                      AllColors.redColor,
                                    ),
                                  ),
                                  onPressed: ()  {
                                    if(saleCycleController.competitorNameController.value.text.isEmpty){
                                      Utils.showErrorToastification('Error', 'Please Enter Competitor Name');
                                      return;
                                    }else if(saleCycleController.quoteRejectReasonController.value.text.isEmpty){
                                      Utils.showErrorToastification('Error', 'Please Enter Reject Reason Name');
                                      return;
                                    }
                                    showWonLossConfirmationDialog(context, saleCycleList);

                                    },
                                  child: Container(
                                    child: Text('Reject',
                                      style: GoogleFonts.poppins(
                                        color: AllColors.blackColor,
                                        fontSize: AllFontSize.fourtine,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),


                  ],
                )
            ),
          );

        });
  }
*/

 /* Widget selectedQuotation(BuildContext context) {
    return  TextField(
      readOnly: true,
      cursorColor:AllColors.primaryDark1 ,
      controller: saleCycleController.selectedQuotationIdController.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
          hintText: 'Selected Quotation',
          labelText: 'Selected Quotation',
          hintStyle: GoogleFonts.poppins(
              color: AllColors.lightblackColor,
              fontWeight: FontWeight.w300,
              fontSize: AllFontSize.ten),
          labelStyle: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontWeight: FontWeight.w500,
              fontSize: AllFontSize.sisxteen),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )
      ),
    );
  }*/


  /*Widget competitorname(BuildContext context) {
    return  TextField(
      cursorColor:AllColors.primaryDark1 ,
      controller: saleCycleController.competitorNameController.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
          hintText: 'Competitor Name',
          labelText: 'Competitor Name',
          hintStyle: GoogleFonts.poppins(
              color: AllColors.lightblackColor,
              fontWeight: FontWeight.w300,
              fontSize: AllFontSize.ten),
          labelStyle: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontWeight: FontWeight.w500,
              fontSize: AllFontSize.sisxteen),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )
      ),
    );
  }*/


  Widget filterWithQuoteId(BuildContext context) {
    return  TextField(
      cursorColor:AllColors.primaryDark1 ,
      controller: saleCycleController.filterQuoteIdController.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
          hintText: 'Quote Id',
          labelText: 'Quote Id',
          hintStyle: GoogleFonts.poppins(
              color: AllColors.lightblackColor,
              fontWeight: FontWeight.w300,
              fontSize: AllFontSize.ten),
          labelStyle: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontWeight: FontWeight.w500,
              fontSize: AllFontSize.sisxteen),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )
      ),
    );
  }

  void showDialogForFilter(BuildContext context) {
    showModalBottomSheet(context: context,
        isScrollControlled: true,
        builder: (BuildContext context){
      return SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.shield_moon_rounded, color: AllColors.lightredColor,),
                  SizedBox(width: 5,),
                  Text(
                      'Filter',
                      style: GoogleFonts.poppins(
                        fontSize: AllFontSize.twenteetwo,
                        fontWeight: FontWeight.w700,
                        color: AllColors.primaryDark1,
                      )),
                  Spacer(),
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                      child: Icon(Icons.cancel, color: AllColors.lightredColor,)
                  ),
                ],
              ),
            ),
            Divider(height: 1,color: Colors.grey,),
            SingleChildScrollView(
              child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        filterWithQuoteId( context),
                        SizedBox(height: 10),
                        filterWithQuoteStatus( context),
                        SizedBox(height: 10),
                        filterWithQuoteValidity( context),
                        SizedBox(height: 10),
                        filterWithQuoteClosureDate( context),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(
                                    AllColors.redColor,
                                  ),
                                ),
                                onPressed: ()  {
                                  try{
                                    saleCycleController.filterQuoteIdController.value.clear();
                                    saleCycleController.filterQuoteStatusController.value.clear();
                                    saleCycleController.filterExpectedClosuredateController.value.clear();
                                    saleCycleController.filterQuoteValidityController.value.clear();
                                    saleCycleController.getQuoteHeaderData(saleCycleController.pageNumberForQuote,saleCycleController.salesCycleId.value, '');
                                    Navigator.pop(context);
                                  }catch(e){
                                    print("Exception..${e.toString()}");
                                  }

                                },
                                child: Container(
                                  child: Text('Clear',
                                    style: GoogleFonts.poppins(
                                      color: AllColors.blackColor,
                                      fontSize: AllFontSize.fourtine,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(
                                    AllColors.greenblue,
                                  ),
                                ),
                                onPressed: ()  {
                                  saleCycleController.getQuoteHeaderData(saleCycleController.pageNumberForQuote,saleCycleController.salesCycleId.value, '');
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  child: Text('Submit',
                                    style: GoogleFonts.poppins(
                                      color: AllColors.blackColor,
                                      fontSize: AllFontSize.fourtine,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )




                      ],
                    ),
                  )
              ),
            ),
          ],
        ),
      );
    });
  }

  filterWithQuoteStatus(BuildContext context) {
    return  TextField(
      cursorColor:AllColors.primaryDark1 ,
      controller: saleCycleController.filterQuoteStatusController.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
          hintText: 'Quote Status',
          labelText: 'Quote Status',
          hintStyle: GoogleFonts.poppins(
              color: AllColors.lightblackColor,
              fontWeight: FontWeight.w300,
              fontSize: AllFontSize.ten),
          labelStyle: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontWeight: FontWeight.w500,
              fontSize: AllFontSize.sisxteen),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )
      ),
    );
  }

  filterWithQuoteValidity(BuildContext context) {
    return TextField(
        cursorColor:AllColors.primaryDark1 ,
        controller: saleCycleController.filterQuoteValidityController.value,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten
            ),
            suffixIcon: Icon(Icons.calendar_month),
            hintText: 'Quote Validity',
            labelText: 'Quote Validity',
            hintStyle: GoogleFonts.poppins(
                color: AllColors.lightblackColor,
                fontWeight: FontWeight.w300,
                fontSize: AllFontSize.ten),
            labelStyle: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontWeight: FontWeight.w500,
                fontSize: AllFontSize.sisxteen),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            )
        ),
        onTap: () async {
          DateTime ending_date = new DateTime(2200);
          DateTime start_date = new DateTime(1900);
          FocusScope.of(context).requestFocus(new FocusNode());
          DateTime? date = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: start_date,
            lastDate: ending_date,
            builder: (BuildContext context, Widget? child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  primaryColor: AllColors.primaryDark1, // Header background color
                  //accentColor: AllColors.primaryDark1, // Color of the buttons
                  colorScheme: ColorScheme.light(primary: AllColors.primaryDark1),
                  buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
                ),
                child: child!,
              );
            },

          );
          var outputFormat = DateFormat('yyyy-MM-dd');
          if (date != null && date != "")
            saleCycleController.filterQuoteValidityController.value.text= outputFormat.format(date);
          else
            saleCycleController.filterQuoteValidityController.value.text = "";
        }

    );
  }

  filterWithQuoteClosureDate(BuildContext context) {
    return TextField(
        cursorColor:AllColors.primaryDark1 ,
        controller: saleCycleController.filterExpectedClosuredateController.value,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten
            ),
            suffixIcon: Icon(Icons.calendar_month),
            hintText: 'Expected Closure Date',
            labelText: 'Expected Closure Date',
            hintStyle: GoogleFonts.poppins(
                color: AllColors.lightblackColor,
                fontWeight: FontWeight.w300,
                fontSize: AllFontSize.ten),
            labelStyle: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontWeight: FontWeight.w500,
                fontSize: AllFontSize.sisxteen),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            )
        ),
        onTap: () async {
          DateTime start_date = new DateTime(1900);
          DateTime ending_date = new DateTime(2200);
          FocusScope.of(context).requestFocus(new FocusNode());
          DateTime? date = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: start_date,
            lastDate: ending_date,
            builder: (BuildContext context, Widget? child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  primaryColor: AllColors.primaryDark1, // Header background color
                  //accentColor: AllColors.primaryDark1, // Color of the buttons
                  colorScheme: ColorScheme.light(primary: AllColors.primaryDark1),
                  buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
                ),
                child: child!,
              );
            },

          );
          var outputFormat = DateFormat('yyyy-MM-dd');
          if (date != null && date != "")
            saleCycleController.filterExpectedClosuredateController.value.text= outputFormat.format(date);
          else
            saleCycleController.filterExpectedClosuredateController.value.text = "";
        }



    );
  }

  Widget bindIdentifyDecisionMaker(BuildContext context) {
    return IgnorePointer(
      ignoring: (saleCycleController.saleCycleList[0].isReadySendForApproval==0 && (saleCycleController.FromPage.value == 'Sales'
          || saleCycleController.FromPage.value == 'FromTaskScreen' || saleCycleController.FromPage.value == 'Task' ))
          || saleCycleController.FromPage.value == 'Task' ||
          saleCycleController.FromPage.value == 'FromTaskScreen'?true:false,
      child: Container(
        margin: const EdgeInsets.only(left: 15.0),
        width: double.infinity,
        child: DropdownMenu<String>(
          width: size.width-30,
          controller: saleCycleController.identifyDecisionMakerController.value,
          label: Text(
            "Identify Decision Maker",
            style: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontSize: AllFontSize.fourtine,
                fontWeight: FontWeight.w500),
          ),

          inputDecorationTheme: const InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                color: AllColors.primaryDark1,),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: AllColors.primaryDark1), // Change the color to green
            ),

            border: OutlineInputBorder(
              borderSide: BorderSide(
                  color: AllColors.primaryDark1), // Change the color to green
            ),
            filled: false,
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten),
          ),
          onSelected: (String? selection) {
            print(selection);
            saleCycleController.identifyDecisionMakerController.value.text =
                _displayDecisionMakerForOption(selection!).toString();


          },

          dropdownMenuEntries: saleCycleController.customerNeedIdentityList.map<DropdownMenuEntry<String>>((String e) {
            return DropdownMenuEntry<String>(value: e, label: e!,style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(AllColors.primaryDark1),));
          }).toList(),
        ),
      ),
    );
  }

  Widget bindSaleCycleCommit(BuildContext context) {
    return IgnorePointer(
      ignoring: (saleCycleController.saleCycleList[0].isReadySendForApproval==0 && (saleCycleController.FromPage.value == 'Sales'
          || saleCycleController.FromPage.value == 'FromTaskScreen' || saleCycleController.FromPage.value == 'Task' ))
          || saleCycleController.FromPage.value == 'Task' ||
          saleCycleController.FromPage.value == 'FromTaskScreen'?true:false,
      child: Container(
        margin: const EdgeInsets.only(left: 15.0),
        width: double.infinity,
        child: DropdownMenu<String>(
          width: size.width-30,
          controller: saleCycleController.saleCycleCommitController.value,
          label: Text(
            "Sales Cycle Commit",
            style: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontSize: AllFontSize.fourtine,
                fontWeight: FontWeight.w500),
          ),

          inputDecorationTheme: const InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                color: AllColors.primaryDark1,),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: AllColors.primaryDark1), // Change the color to green
            ),

            border: OutlineInputBorder(
              borderSide: BorderSide(
                  color: AllColors.primaryDark1), // Change the color to green
            ),
            filled: false,
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten),
          ),
          onSelected: (String? selection) {
            print(selection);
            saleCycleController.saleCycleCommitController.value.text =
                _displayDecisionMakerForOption(selection!).toString();


          },

          dropdownMenuEntries: saleCycleController.customerNeedIdentityList.map<DropdownMenuEntry<String>>((String e) {
            return DropdownMenuEntry<String>(value: e, label: e!,style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(AllColors.primaryDark1),));
          }).toList(),
        ),
      ),
    );
  }

  Widget bindPurchaseProcessDropDown(context){
    return IgnorePointer(
      ignoring: (saleCycleController.saleCycleList[0].isReadySendForApproval==0   &&
          (saleCycleController.FromPage.value == 'Sales' || saleCycleController.FromPage.value == 'FromTaskScreen'
          )) || saleCycleController.FromPage.value == 'Task' || saleCycleController.FromPage.value == 'FromTaskScreen'?true:false,
      child: Container(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Autocomplete<CustomList>(
          displayStringForOption: _displayPurchaseProcessForOption,
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return saleCycleController.get_PurchaseProcess_list.value;
              // return const Iterable<VehicleTypeResponse>.empty();
            }
            return saleCycleController.get_PurchaseProcess_list
                .where((CustomList option) {
              return option.value
                  .toString()
                  .toLowerCase()
                  .contains(textEditingValue.text.toLowerCase());
            }).toList();
          },
          onSelected: (CustomList selection) {
            saleCycleController.purchaseProcessController.value.text =
                _displayPurchaseProcessForOption(selection).toString();
            saleCycleController.purchaseProcessController.value.text = selection.value??"";
          },
          fieldViewBuilder: (BuildContext context, TextEditingController controller,
              FocusNode focusNode, VoidCallback onFieldSubmitted) {
            return TextField(
              readOnly:  (saleCycleController.saleCycleList[0].isReadySendForApproval==0   &&
                  (saleCycleController.FromPage.value == 'Sales' || saleCycleController.FromPage.value == 'FromTaskScreen'
                  )) || saleCycleController.FromPage.value == 'Task' || saleCycleController.FromPage.value == 'FromTaskScreen'?true:false,
              cursorColor: AllColors.primaryDark1,
              controller: controller
                ..text = saleCycleController.purchaseProcessController.value.text,
              focusNode: focusNode,
              decoration: InputDecoration(
                  suffixIcon: InkWell(
                      /*onTap: (){
                        focusNode.requestFocus();
                        controller.clear();
                      },*/
                      child: Icon(Icons.arrow_drop_down)),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
                  hintText: 'Purchase Process',
                  labelText: 'Purchase Process',

                  hintStyle: GoogleFonts.poppins(
                      color: AllColors.lightblackColor,
                      fontWeight: FontWeight.w300,
                      fontSize: AllFontSize.ten),
                  labelStyle: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontWeight: FontWeight.w500,
                      fontSize: AllFontSize.fourtine),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  )
              ),
            );
          },
          optionsViewBuilder: (BuildContext context,
              AutocompleteOnSelected<CustomList> onSelected,
              Iterable<CustomList> suggestions) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                elevation: 4.0,
                child: Container(
                  width: size.width*.8,
                  constraints: BoxConstraints(maxHeight: 200),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: suggestions.length,
                    itemBuilder: (context, index) {
                      final CustomList option =
                      suggestions.elementAt(index);
                      return GestureDetector(
                        onTap: () {
                          onSelected(option);
                        },
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            option.value.toString(),
                            style: GoogleFonts.poppins(
                                color: AllColors.blackColor,
                                fontWeight: FontWeight.w300,
                                fontSize: AllFontSize
                                    .sisxteen // Change the text color here
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget bindPurchaseTimeFrameDropDown(context){
    return IgnorePointer(
      ignoring: (saleCycleController.saleCycleList[0].isReadySendForApproval==0   &&
          (saleCycleController.FromPage.value == 'Sales' || saleCycleController.FromPage.value == 'FromTaskScreen'
          )) || saleCycleController.FromPage.value == 'Task' || saleCycleController.FromPage.value == 'FromTaskScreen'?true:false,
      child: Container(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Autocomplete<CustomList>(
          displayStringForOption: _displayPurchaseTimeFrameForOption,
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return saleCycleController.get_PurchaseTimeFrame_list.value;
              // return const Iterable<VehicleTypeResponse>.empty();
            }
            return saleCycleController.get_PurchaseTimeFrame_list
                .where((CustomList option) {
              return option.value
                  .toString()
                  .toLowerCase()
                  .contains(textEditingValue.text.toLowerCase());
            }).toList();
          },
          onSelected: (CustomList selection) {
            saleCycleController.purchasTimeFrameController.value.text =
                _displayPurchaseTimeFrameForOption(selection).toString();
            saleCycleController.purchasTimeFrameController.value.text = selection.value??"";
          },
          fieldViewBuilder: (BuildContext context, TextEditingController controller,
              FocusNode focusNode, VoidCallback onFieldSubmitted) {
            return TextField(
              readOnly:  (saleCycleController.saleCycleList[0].isReadySendForApproval==0   &&
                  (saleCycleController.FromPage.value == 'Sales' || saleCycleController.FromPage.value == 'FromTaskScreen'
                  )) || saleCycleController.FromPage.value == 'Task' || saleCycleController.FromPage.value == 'FromTaskScreen'?true:false,

              cursorColor: AllColors.primaryDark1,
              controller: controller
                ..text = saleCycleController.purchasTimeFrameController.value.text,
              focusNode: focusNode,
              decoration: InputDecoration(
                  suffixIcon: InkWell(
                     /* onTap: (){
                        focusNode.requestFocus();
                        controller.clear();
                      },*/
                      child: Icon(Icons.arrow_drop_down)),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
                  hintText: 'Purchase Time Frame',
                  labelText: 'Purchase Time Frame',

                  hintStyle: GoogleFonts.poppins(
                      color: AllColors.lightblackColor,
                      fontWeight: FontWeight.w300,
                      fontSize: AllFontSize.ten),
                  labelStyle: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontWeight: FontWeight.w500,
                      fontSize: AllFontSize.fourtine),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  )
              ),
            );
          },
          optionsViewBuilder: (BuildContext context,
              AutocompleteOnSelected<CustomList> onSelected,
              Iterable<CustomList> suggestions) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                elevation: 4.0,
                child: Container(
                  width: size.width*.8,
                  constraints: BoxConstraints(maxHeight: 200),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: suggestions.length,
                    itemBuilder: (context, index) {
                      final CustomList option =
                      suggestions.elementAt(index);
                      return GestureDetector(
                        onTap: () {
                          onSelected(option);
                        },
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            option.value.toString(),
                            style: GoogleFonts.poppins(
                                color: AllColors.blackColor,
                                fontWeight: FontWeight.w300,
                                fontSize: AllFontSize
                                    .sisxteen // Change the text color here
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget bindProductCategoryDropDown(context){
    return IgnorePointer(
      ignoring: (saleCycleController.saleCycleList[0].isReadySendForApproval==0   &&
          (saleCycleController.FromPage.value == 'Sales' || saleCycleController.FromPage.value == 'FromTaskScreen'
          )) || saleCycleController.FromPage.value == 'Task' || saleCycleController.FromPage.value == 'FromTaskScreen'?true:false,
      child: Container(
        padding: EdgeInsets.fromLTRB(15, 5, 15, 10),
        width: size.width/2,
        child: Autocomplete<ItemCategoryMstModel>(
          displayStringForOption: _displayItemCatMasterForOption,
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return saleCycleController.itemCategorySelectedlist.value;
              // return const Iterable<VehicleTypeResponse>.empty();
            }
            return saleCycleController.itemCategorySelectedlist
                .where((ItemCategoryMstModel option) {
              return option.categoryName
                  .toString()
                  .toLowerCase()
                  .contains(textEditingValue.text.toLowerCase());
            }).toList();
          },
          onSelected: (ItemCategoryMstModel selection) {
            saleCycleController.productCategoryController.value.text =
                _displayItemCatMasterForOption(selection).toString();
            saleCycleController.ProductCategoryCode.value = selection.categoryCode??"";

            /*if (!saleCycleController.itemCategorySelectedlist.contains(selection)) {
              saleCycleController.itemCategorySelectedlist.add(selection);
              Utils.showToastification('Success', 'Add Successfully');
            }else{
              Utils.showErrorToastification('Error', 'Already Selected');
            }
            print("list${saleCycleController.itemCategorySelectedlist.length}");*/

          },
          fieldViewBuilder: (BuildContext context, TextEditingController controller,
              FocusNode focusNode, VoidCallback onFieldSubmitted) {
            return TextField(
              readOnly:  (saleCycleController.saleCycleList[0].isReadySendForApproval==0   &&
                  (saleCycleController.FromPage.value == 'Sales' || saleCycleController.FromPage.value == 'FromTaskScreen'
                  )) || saleCycleController.FromPage.value == 'Task' || saleCycleController.FromPage.value == 'FromTaskScreen'?true:false,
              onTap: (){
                controller.clear();
              },
              cursorColor: AllColors.primaryDark1,
              controller: controller
                ..text = saleCycleController.productCategoryController.value.text,
              focusNode: focusNode,
              decoration: InputDecoration(
                  suffixIcon: InkWell(
                      onTap: (){
                        focusNode.requestFocus();
                        controller.clear();
                      },
                      child: Icon(Icons.arrow_drop_down)),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
                  hintText: 'Product Category',
                  labelText: 'Product Category',

                  hintStyle: GoogleFonts.poppins(
                      color: AllColors.lightblackColor,
                      fontWeight: FontWeight.w300,
                      fontSize: AllFontSize.ten),
                  labelStyle: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontWeight: FontWeight.w500,
                      fontSize: AllFontSize.fourtine),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  )
              ),
            );
          },
          optionsViewBuilder: (BuildContext context,
              AutocompleteOnSelected<ItemCategoryMstModel> onSelected,
              Iterable<ItemCategoryMstModel> suggestions) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                elevation: 4.0,
                child: Container(
                  width: size.width*.5,
                  constraints: BoxConstraints(maxHeight: 200),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: suggestions.length,
                    itemBuilder: (context, index) {
                      final ItemCategoryMstModel option =
                      suggestions.elementAt(index);
                      return GestureDetector(
                        onTap: () {
                          onSelected(option);
                        },
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            option.categoryName.toString(),
                            style: GoogleFonts.poppins(
                                color: AllColors.blackColor,
                                fontWeight: FontWeight.w300,
                                fontSize: AllFontSize
                                    .sisxteen // Change the text color here
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

 Widget bindExpectedAmount(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 5, 15, 10),
      width: size.width/2,
      child: TextField(
        readOnly:  (saleCycleController.saleCycleList[0].isReadySendForApproval==0 &&
            (saleCycleController.FromPage.value == 'Sales' || saleCycleController.FromPage.value == 'FromTaskScreen'
         || saleCycleController.FromPage.value == 'Task' )) || saleCycleController.FromPage.value == 'Task' || saleCycleController.FromPage.value == 'FromTaskScreen'?true:false,
        cursorColor:AllColors.primaryDark1 ,
        controller: saleCycleController.expectedAmountController.value,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten),
            hintText: 'Enter Expected Amount',
            labelText: 'Expected Amount',
            hintStyle: GoogleFonts.poppins(
                color: AllColors.lightblackColor,
                fontWeight: FontWeight.w300,
                fontSize: AllFontSize.ten),
            labelStyle: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontWeight: FontWeight.w500,
                fontSize: AllFontSize.fourtine),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            )
        ),
      ),
    );
  }

  Widget BindAmmountTable(BuildContext context){
    if(saleCycleController.budgetAmountList.length > 0 ){
      return
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: BindTableDate(context),
        );
    }else{
      return Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          children: [
            //Image(image: AssetImage("assets/images/no_results_found.jpg"), height: 450,width: 350,),
            Text(
              'No Record Found.',
              style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontSize: AllFontSize.twentee,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),

      );
  }

  }


  Widget BindTableDate(BuildContext context){
    return Container(
     // padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
     child:
      Obx((){
       return  SingleChildScrollView(
         scrollDirection: Axis.vertical,
         child: IgnorePointer(
           ignoring: (saleCycleController.saleCycleList[0].isReadySendForApproval==0   &&
               (saleCycleController.FromPage.value == 'Sales' || saleCycleController.FromPage.value == 'FromTaskScreen'
               )) || saleCycleController.FromPage.value == 'Task' || saleCycleController.FromPage.value == 'FromTaskScreen'?true:false,
           child: DataTable(
           // headingRowColor: WidgetStateProperty.all(Colors.blue[100]),
           columnSpacing: 30,
           decoration: BoxDecoration(
             border: Border(
               right: BorderSide(
                 color: Colors.grey,
                 width: 0.5,
               ),
               left: BorderSide(
                 color: Colors.grey,
                 width: 0.5,
               ),
               bottom: BorderSide(
                 color: Colors.grey,
                 width: 0.5,
               ),
             ),
           ),
           columns: [
             DataColumn(label: Text('Product\nCategory')),
             DataColumn(label: Text('Budget\nAmount')),
             DataColumn(label: Text('Expected\nAmount'),),
           ],
           rows: [
             ...saleCycleController.budgetAmountList.map((e) => DataRow(cells: [
                DataCell(
                  InkWell(
                    onTap: (){
                      saleCycleController.ProductCategoryCode.value = e.productCategory!;
                      saleCycleController.expectedAmountController.value.text = e.estimatedAmount.toString();
                      saleCycleController.budgetAmountController.value.text = e.budgetAmount.toString();
                      UpdateproductCategoryDailog(context, e.id);
                    },
                    child: Container(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                      e.productCategoryName.toString(),
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontWeight: FontWeight.w300,))),
                  )),
                DataCell(
                  InkWell(
                    onTap: (){
                      saleCycleController.ProductCategoryCode.value = e.productCategory!;
                      saleCycleController.expectedAmountController.value.text = e.estimatedAmount.toString();
                      saleCycleController.budgetAmountController.value.text = e.budgetAmount.toString();
                      UpdateBudgetAmountDailog(context, e.id);
                      print('id....Selected...${e.id}');
                    },
                    child: Container(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(e.budgetAmount.toString(),
                           style: GoogleFonts.poppins(
                           color: AllColors.primaryDark1,
                           fontWeight: FontWeight.w300,))),
                  )),

                DataCell(
                  InkWell(
                    onTap: (){
                      saleCycleController.ProductCategoryCode.value = e.productCategory!;
                      saleCycleController.budgetAmountController.value.text = e.budgetAmount.toString();
                      saleCycleController.expectedAmountController.value.text = e.estimatedAmount.toString();
                      UpdateEstimatedAmountDailog(context, e.id);
                      print('id....Selected...${e.id}');
                    },
                    child: Container(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(e.estimatedAmount.toString(),
                      style:GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontWeight: FontWeight.w300,) ,
                    )),
                  )),
              ])),
             DataRow(cells: [
               DataCell(Container(
                   alignment: AlignmentDirectional.centerStart,
                   child: Text('Total:', style: TextStyle(fontWeight: FontWeight.bold, color: AllColors.blackColor)))), // Empty cells for the total row
               DataCell(Container(
                   alignment: AlignmentDirectional.centerStart,
                   child: Text('${saleCycleController.budgetAmountList[0].totalBudgetAmount}', style: TextStyle(fontWeight: FontWeight.bold, color: AllColors.blackColor)))),
               DataCell(
                   Container(
                       alignment: AlignmentDirectional.centerStart,
                       child: Text('${saleCycleController.budgetAmountList[0].totalEstimatedAmount}', style: TextStyle(fontWeight: FontWeight.bold, color: AllColors.blackColor)))),
             ]),
           ],
                ),
         ),
       );
     })

    );

  }

  bindSolutionRejectedRemarks(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 30, left: 15, right: 15),
      child: TextField(
        readOnly:saleCycleController.saleCycleList[0].approvedBy==saleCycleController.email
            || saleCycleController.saleCycleList[0].salesCycleApprovalStatus=="Rejected" ||
            saleCycleController.FromPage == 'Task' || saleCycleController.FromPage == 'FromTaskScreen'?true:false,
        //readOnly: saleCycleController.saleCycleList[0].isReadySendForApproval!=1?true:false,
        cursorColor:AllColors.primaryDark1 ,
        controller: saleCycleController.solutionRejectedRemarkController.value,
        maxLength: 500,
        maxLines: 2,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.seven, horizontal: AllFontSize.ten),
            hintText: 'Solution Rejected Remarks',
            labelText: 'Solution Rejected Remarks',
            hintStyle: GoogleFonts.poppins(
                color: AllColors.lightblackColor,
                fontWeight: FontWeight.w300,
                fontSize: AllFontSize.ten),
            labelStyle: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontWeight: FontWeight.w700,
                fontSize: AllFontSize.sisxteen),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            )
        ),
      ),
    );
  }

  void showInfraLeadDetails(BuildContext context, RxList<SalesCycleModal> saleCycleList) {
    Size size=Get.size;
    showModalBottomSheet(context: context,
      builder: (BuildContext context) {
        return  Container(
          width: double.infinity,
          height: size.height/2,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    InkWell(
                      child: CircleBackButton(
                        press: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Text(
                        "Infra Lead Details",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.twentee,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: GestureDetector(
                          onTap: (){
                            Navigator.of(context).pop();
                          },
                          child: Icon(Icons.close, color: AllColors.primaryDark1,)),
                    )

                  ],
                ),
              ),
              Center(child: Divider(height: 1,color: AllColors.primaryDark1,)),
              // Obx(() {
              //  return
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "User Region",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Text(
                              saleCycleList[0].userRegion??"",
                              style: GoogleFonts.poppins(
                                color: AllColors.textColor,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),

                        Row(
                          children: [
                            Text(
                              "User Cluster",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Text(
                              saleCycleList[0].userClusture??"",
                              style: GoogleFonts.poppins(
                                color: AllColors.textColor,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            Text(
                              "Project Value",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Text(
                              saleCycleList[0].projectValue.toString(),
                              style: GoogleFonts.poppins(
                                color: AllColors.textColor,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            Text(
                              "Exp Date of Order",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Text(
                              saleCycleList[0].expectedDateOfOrder??"",
                              style: GoogleFonts.poppins(
                                color: AllColors.textColor,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            Text(
                              "Drawing Collected",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Text(
                              saleCycleList[0].drawingCollected==1?"Yes":"No",
                              style: GoogleFonts.poppins(
                                color: AllColors.textColor,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            Text(
                              "Proposal Submitted",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Text(
                              saleCycleList[0].proposalSubmitted==1?"Yes":"No",
                              style: GoogleFonts.poppins(
                                color: AllColors.textColor,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            Text(
                              "Inaugration Date of Project",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Text(
                              saleCycleList[0].inaugrationDateOfProject??"",
                              style: GoogleFonts.poppins(
                                color: AllColors.textColor,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            Text(
                              "Architect",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Text(
                              saleCycleList[0].architect??"",
                              style: GoogleFonts.poppins(
                                color: AllColors.textColor,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            Text(
                              "Executive Engineer",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Text(
                              saleCycleList[0].executiveEngineer??"",
                              style: GoogleFonts.poppins(
                                color: AllColors.textColor,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            Text(
                              "Name of Infra Department",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Text(
                              saleCycleList[0].nameOfInfraDepartment??"",
                              style: GoogleFonts.poppins(
                                color: AllColors.textColor,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            Text(
                              "Name of Agency Contactor",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Text(
                              saleCycleList[0].nameOfAgencyContrator??"",
                              style: GoogleFonts.poppins(
                                color: AllColors.textColor,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            Text(
                              "Expected Revenue",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Text(
                              saleCycleList[0].expectedRevenue.toString(),
                              style: GoogleFonts.poppins(
                                color: AllColors.textColor,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            Text(
                              "Value Of Quote",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Text(
                              saleCycleList[0].valueOfQuote.toString(),
                              style: GoogleFonts.poppins(
                                color: AllColors.textColor,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            Text(
                              "Expected Date Of Completion",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Text(
                              saleCycleList[0].expectedDateOfCompletion??"",
                              style: GoogleFonts.poppins(
                                color: AllColors.textColor,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                      ],
                    ),
                  ),
                ),
              ),


              //  })
            ],
          ),
        );
      },
    );
  }

  void ShowProductCategoryTable(BuildContext context, RxList<ProductCategoryWiseAmtModel> budgetAmountList) {
    Size size=Get.size;
    showModalBottomSheet(context: context,
      builder: (BuildContext context) {
        return  Container(
          width: double.infinity,
          height: size.height/2,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    InkWell(
                      child: CircleBackButton(
                        press: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Text(
                        "Product Category Table",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.sisxteen,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: GestureDetector(
                          onTap: (){
                            Navigator.of(context).pop();
                          },
                          child: Icon(Icons.close, color: AllColors.primaryDark1,)),
                    )

                  ],
                ),
              ),
              Center(child: Divider(height: 1,color: AllColors.primaryDark1,)),
              Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                width: double.infinity,
                //height: size.height*.6,
                child: BindAmmountTable(context),
              )
            ],
          ),
        );
      },
    );
  }

  void ShowQuoteWon(BuildContext context) {
   // Size size=Get.size;
    showModalBottomSheet(context: context,
      builder: (BuildContext context) {
        return  Container(
         /* width: double.infinity,
          height: size.height/2,*/
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    InkWell(
                      child: CircleBackButton(
                        press: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Text(
                        "Quote Won List",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.sisxteen,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: GestureDetector(
                          onTap: (){
                            Navigator.of(context).pop();
                          },
                          child: Icon(Icons.close, color: AllColors.primaryDark1,)),
                    )

                  ],
                ),
              ),
              Center(child: Divider(height: 1,color: AllColors.primaryDark1,)),
              Container(
                //margin: EdgeInsets.only(left: 15, right: 15),
                width: double.infinity,
                //height: size.height*.6,
                child: bindQuoteWonData(context),
              )
            ],
          ),
        );
      },
    );
  }

  UpdateproductCategoryDailog(context, int? id){
    // saleCycleController.budgetAmountController.value.clear();
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context){
          return AlertDialog(
            title:  Text(
              'Update Product Category',
              style: GoogleFonts.poppins(
                fontSize: AllFontSize.sisxteen,
                fontWeight: FontWeight.w700,
                color: AllColors.primaryDark1,
              ),
            ),
            content: Container(
              /*height: size.height*.15,
              width: size.width*4,*/
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  SizedBox(height: 15,),
                  bindProductCategoryDropDown(context),
                  SizedBox(height: 15,),

                  Row(
                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            AllColors.primaryDark1,
                          ),
                        ),
                        onPressed: ()  {
                          saleCycleController.ProductCategoryWiseAmtCreateApiHit(id!);
                          Get.back();

                        },
                        child: Container(
                          width: 60,
                          alignment: Alignment.center,
                          child: Text('Save'
                            /*accountMaster_page_controller.UploadImageType_controller.value =="Url"? 'Upload Url':'Choose files'*/,
                            style: GoogleFonts.poppins(
                              color: AllColors.customDarkerWhite,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            AllColors.primaryDark1,
                          ),
                        ),
                        onPressed: () {
                          saleCycleController.productCategoryController.value.clear();
                          saleCycleController.budgetAmountController.value.clear();
                          saleCycleController.expectedAmountController.value.clear();
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 60,
                          alignment: Alignment.center,
                          child: Text(
                            'Cancel',
                            style: GoogleFonts.poppins(
                              color: AllColors.customDarkerWhite,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],)
                ],
              ),
            ),
          );
        });
  }


  UpdateBudgetAmountDailog(context, int? id){
   // saleCycleController.budgetAmountController.value.clear();
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context){
          return AlertDialog(
            title:  Text(
              'Update Budget Amount',
              style: GoogleFonts.poppins(
                fontSize: AllFontSize.sisxteen,
                fontWeight: FontWeight.w700,
                color: AllColors.primaryDark1,
              ),
            ),
            content: Container(
              /*height: size.height*.15,
              width: size.width*4,*/
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  SizedBox(height: 15,),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    //padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    child: TextFormField(
                      controller: saleCycleController.budgetAmountController.value,
                      decoration: InputDecoration(
                          hintText: "Enter Budget Amount",
                          labelText: "Enter Budget Amount",
                          //suffixIcon: Icon(Icons.email),
                          contentPadding: EdgeInsets.symmetric(vertical: AllFontSize.ten,horizontal: AllFontSize.ten ),

                          /* focusedBorder: OutlineInputBorder(
                               borderSide: BorderSide(color: Colors.blue)
                           ),*/
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),

                    ),
                  ),
                  SizedBox(height: 15,),

                  Row(
                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            AllColors.primaryDark1,
                          ),
                        ),
                        onPressed: ()  {
                          saleCycleController.ProductCategoryWiseAmtCreateApiHit(id!);
                          Get.back();

                        },
                        child: Container(
                          width: 60,
                          alignment: Alignment.center,
                          child: Text('Save'
                            /*accountMaster_page_controller.UploadImageType_controller.value =="Url"? 'Upload Url':'Choose files'*/,
                            style: GoogleFonts.poppins(
                              color: AllColors.customDarkerWhite,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                       ElevatedButton(
                           style: ButtonStyle(
                             backgroundColor: MaterialStateProperty.all<Color>(
                               AllColors.primaryDark1,
                             ),
                           ),
                           onPressed: () {
                             saleCycleController.productCategoryController.value.clear();
                             saleCycleController.budgetAmountController.value.clear();
                             saleCycleController.expectedAmountController.value.clear();
                             Navigator.pop(context);
                           },
                           child: Container(
                             width: 60,
                             alignment: Alignment.center,
                             child: Text(
                               'Cancel',
                               style: GoogleFonts.poppins(
                                 color: AllColors.customDarkerWhite,
                                 fontSize: AllFontSize.fourtine,
                                 fontWeight: FontWeight.w700,
                               ),
                             ),
                           ),
                         ),
                    ],)
                ],
              ),
            ),
          );
        });
  }

  UpdateEstimatedAmountDailog(context, int? id){
    //saleCycleController.expectedAmountController.value.clear();
    showDialog(
       barrierDismissible: false,
        context: context,
        builder: (context){
          return AlertDialog(
            title:  Text(
              'Update Expected Amount',
              style: GoogleFonts.poppins(
                fontSize: AllFontSize.sisxteen,
                fontWeight: FontWeight.w700,
                color: AllColors.primaryDark1,
              ),
            ),
            content: Container(
              /*height: size.height*.15,
              width: size.width*4,*/
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  SizedBox(height: 15,),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    //padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    child: TextFormField(
                      controller: saleCycleController.expectedAmountController.value,
                      decoration: InputDecoration(
                          hintText: "Enter Expected Amount",
                          labelText: "Enter Expected Amount",
                          //suffixIcon: Icon(Icons.email),
                          contentPadding: EdgeInsets.symmetric(vertical: AllFontSize.ten,horizontal: AllFontSize.ten ),

                          /* focusedBorder: OutlineInputBorder(
                               borderSide: BorderSide(color: Colors.blue)
                           ),*/
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),

                    ),
                  ),
                  SizedBox(height: 15,),

                  Row(
                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            AllColors.primaryDark1,
                          ),
                        ),
                        onPressed: ()  {
                          saleCycleController.ProductCategoryWiseAmtCreateApiHit(id!);
                          Get.back();

                        },
                        child: Container(
                          width: 60,
                          alignment: Alignment.center,
                          child: Text('Save'
                            /*accountMaster_page_controller.UploadImageType_controller.value =="Url"? 'Upload Url':'Choose files'*/,
                            style: GoogleFonts.poppins(
                              color: AllColors.customDarkerWhite,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                       ElevatedButton(
                           style: ButtonStyle(
                             backgroundColor: MaterialStateProperty.all<Color>(
                               AllColors.primaryDark1,
                             ),
                           ),
                           onPressed: () {
                             saleCycleController.productCategoryController.value.clear();
                             saleCycleController.budgetAmountController.value.clear();
                             saleCycleController.expectedAmountController.value.clear();
                             Navigator.pop(context);
                           },
                           child: Container(
                             width: 60,
                             alignment: Alignment.center,
                             child: Text(
                               'Cancel',
                               style: GoogleFonts.poppins(
                                 color: AllColors.customDarkerWhite,
                                 fontSize: AllFontSize.fourtine,
                                 fontWeight: FontWeight.w700,
                               ),
                             ),
                           ),
                         ),
                    ],)
                ],
              ),
            ),
          );
        });
  }

  showProductCatDialog(context){
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            title: Text(
              'Product Category',
              style: GoogleFonts.poppins(
                fontSize: AllFontSize.sisxteen,
                fontWeight: FontWeight.w700,
                color: AllColors.primaryDark1,
              ),
            ),
            content: Container(
              //height: size.height*.3,
              width: size.width*4,
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              child: Wrap(
                children: [
                  bindItemCategoryDropDown(context),
                  SizedBox(height: 65,),
                  Obx((){
                    return Visibility(
                      visible: saleCycleController.itemCategorySelectedlist.length > 0 ? true : false,
                      child: Wrap(
                        spacing: 8.0,
                        children: saleCycleController.itemCategorySelectedlist.map((category) {
                          return Chip(
                            label: Text(category.categoryName??""),
                            onDeleted: () {
                              saleCycleController.itemCategorySelectedlist.remove(category);
                            },
                          );
                        }).toList(),
                      ),
                    );
                  }),
                  SizedBox(height: 15,),

                  Row(
                    mainAxisAlignment:MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            AllColors.primaryDark1,
                          ),
                        ),
                        onPressed: ()  {
                          saleCycleController.TaskSaleCatCreateApiHit(saleCycleController.saleCycleList[0].salesCycleId!, saleCycleController
                              .saleCycleList[0]
                              .taskId!);
                          Navigator.pop(context);

                        },
                        child: Container(
                          width: 100,
                          alignment: Alignment.center,
                          child: Text('Save'
                            /*accountMaster_page_controller.UploadImageType_controller.value =="Url"? 'Upload Url':'Choose files'*/,
                            style: GoogleFonts.poppins(
                              color: AllColors.customDarkerWhite,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),

                    ],)

                ],
              ),
            ),
          );
        });
  }

  Widget bindItemCategoryDropDown(context){
    return
      Autocomplete<ItemCategoryMstModel>(
        displayStringForOption: _displayItemCatMasterForOption,
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text.isEmpty) {
            return saleCycleController.productCategoryList;
            // return const Iterable<VehicleTypeResponse>.empty();
          }
          return saleCycleController.productCategoryList
              .where((ItemCategoryMstModel option) {
            return option.categoryName
                .toString()
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase());
          }).toList();
        },
        onSelected: (ItemCategoryMstModel selection) {
          // Update the TextField with the selected
          saleCycleController.productCategoryController.value.text =
              _displayItemCatMasterForOption(selection).toString();

          print('Controller.....${saleCycleController.productCategoryController.value.text}');
          if (!saleCycleController.itemCategorySelectedlist.contains(selection)) {
            //TaskMaster_page_controller.Item_Category_code_list.add(selection.categoryCode!);
            saleCycleController.itemCategorySelectedlist.add(selection);
            Utils.showToastification('Success', 'Add Successfully');
          }else{
            Utils.showErrorToastification('Error', 'Already Selected');
          }
          saleCycleController.productCategoryController.value.clear();
          // TaskMaster_page_controller.AccountOwner = selection.loginEmailId!;
        },
        fieldViewBuilder: (BuildContext context, TextEditingController controller,
            FocusNode focusNode, VoidCallback onFieldSubmitted) {
          return Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
            ),
            child: TextField(
              onTap: (){
                controller.clear();
              },
              cursorColor: AllColors.primaryDark1,
              controller: controller
                ..text = saleCycleController.productCategoryController.value
                    .text,
              focusNode: focusNode,
              //onSubmitted: onFieldSubmitted,
              decoration: InputDecoration(
                suffixIcon: InkWell(
                    onTap: (){
                      focusNode.requestFocus();
                      controller.clear();
                    },
                    child: Icon(Icons.arrow_drop_down)),
                contentPadding: EdgeInsets.symmetric(
                    vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
                hintText: 'Product Category',
                labelText: 'Product Category',

                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
              ),
            ),
          );
        },
        optionsViewBuilder: (BuildContext context,
            AutocompleteOnSelected<ItemCategoryMstModel> onSelected,
            Iterable<ItemCategoryMstModel> suggestions) {
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              elevation: 4.0,
              child: Container(
                width: size.width*.7,
                constraints: BoxConstraints(maxHeight: 200),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: suggestions.length,
                  itemBuilder: (context, index) {
                    final ItemCategoryMstModel option =
                    suggestions.elementAt(index);
                    return GestureDetector(
                      onTap: () {
                        onSelected(option);
                      },
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          option.categoryName.toString(),
                          style: GoogleFonts.poppins(
                              color: AllColors.blackColor,
                              fontWeight: FontWeight.w300,
                              fontSize: AllFontSize
                                  .sisxteen // Change the text color here
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      );
  }


}





