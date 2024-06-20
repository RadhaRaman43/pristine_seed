import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navigation_drawer_flutter/repository/expense_approver_repository/expense_approver_repository.dart';
import 'package:navigation_drawer_flutter/viewModel/SessionManagment/session_managment.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../models/api_default_entity.dart';
import '../../models/checkInModel/employee_master_model.dart';
import '../../models/check_in_approval_model/check_in_approval_entity_model.dart';
import '../../models/user_expense_model/expense_Line_Submit_model.dart';
import '../../reources/routes/routes_name.dart';
import '../../utils/app_utils.dart';

class ExpensesApproverViewModel extends GetxController{
    final _api=ExpenseApproverRepository();
   RxBool loading =false.obs;
   SessionManagement sessionManagement = SessionManagement();
   String pending_count = "0", like_count = "0", dislike_count = "0";
   String email="";
    List<EmpMasterResponse> employess_List = [];
    List<CheckInApproveEntity> approver_list_data = [];
    var typeAheadControllerEmployee = TextEditingController();

    var filter_date_controller = TextEditingController();
    var remarks_controller = TextEditingController();
    String selection_type = "";
    RxList<ExpenseLinesSubmittedResponse> expense_header_detail_list = <ExpenseLinesSubmittedResponse>[].obs;

    @override
  void onInit() async  {
     email=await sessionManagement.getEmail()?? "";
     this.getEmployeeMasterApi('');
//
  }

   getEmployeeMasterApi(String filter_login) {
     this.loading.value = true;
     Map data = {'email_id': email};
     _api.getEmployeeTeam(data, sessionManagement).then((value) {
       try {
         List<EmpMasterResponse> emp_masterResponse =
         (json.decode(value) as List)
             .map((i) => EmpMasterResponse.fromJson(i))
             .toList();
         if (emp_masterResponse[0]?.condition.toString() == "True") {
           employess_List = emp_masterResponse;
         } else {
           employess_List = [];
         }
       } catch (e) {
         employess_List = [];
       }
     }).onError((error, stackTrace) {
       employess_List = [];
       Utils.showErrorToastification('Api Exception onError', error.toString());
     }).whenComplete(() {
       this.loading.value = false;
       this.getApprovalList();
     });
   }
    //todo for create expense...................
    expenseCreateApi(String documentNo) {

      loading.value = true;
      Map data = {
        'document_no': documentNo,
        'created_by': email
      };
      _api.expenseCreate(data, sessionManagement).then((value) {
        try {
          final jsonResponse = json.decode(value);
          if (jsonResponse is List) {
            List<ExpenseLinesSubmittedResponse> responses = jsonResponse
                .map((data) => ExpenseLinesSubmittedResponse.fromJson(data))
                .toList();
            if (responses!=null && responses.length>0 && responses[0].condition == 'True') {
              loading.value = false;
              expense_header_detail_list.value = responses;
              Get.toNamed(RoutesName.expenseApprovarHeaderScreen);
            } else {
              expense_header_detail_list.value = [];
              loading.value = false;
              Utils.sanckBarError('False Message!', responses[0].message.toString());
            }
          } else {
            expense_header_detail_list.value = [];
            loading.value = false;
            Utils.sanckBarError('API Error',jsonResponse.toString());
            print(jsonResponse);
          }
        } catch (e) {
          expense_header_detail_list.value = [];
          loading.value = false;
          printError();
        }
      }).onError((error, stackTrace) {
        expense_header_detail_list.value = [];
        print(error);
        loading.value = false;
      });
    }

    getApprovalList() {
      loading.value = true;
      Map data = {
        'email_id': email,
        'filter_date': filter_date_controller.text.toString(),
        'filter_created_by': typeAheadControllerEmployee.text.toString(),
        'approve_status': selection_type
      };
      _api.GetApproverData(data, sessionManagement).then((value) {
        try {
          List<CheckInApproveEntity> approver_list = (json.decode(value) as List)
              .map((i) => CheckInApproveEntity.fromJson(i))
              .toList();
          if (approver_list[0].condition.toString() == "True") {
            approver_list_data = approver_list;
            pending_count = approver_list_data[0].pendingCount;
            like_count = approver_list_data[0].likeCount;
            dislike_count = approver_list_data[0].dislikeCount;
          } else {
            approver_list_data = [];
            pending_count = approver_list[0].pendingCount;
            like_count = approver_list[0].likeCount;
            dislike_count = approver_list[0].dislikeCount;
          }
        } catch (e) {
          approver_list_data = [];
          pending_count = "0";
          like_count = "0";
          dislike_count = "0";
        }
      }).onError((error, stackTrace) {
        approver_list_data = [];
        pending_count = "0";
        like_count = "0";
        dislike_count = "0";
        Utils.sanckBarError('Api Exception onError', error.toString());
      }).whenComplete(() => {this.loading.value = false});
    }


    markApproveReject(String document_no,String doctype, String approve_status,String remarks) {
      this.loading.value = true;
      Map data = {
        'document_no': document_no,
        'document_type': doctype,
        'approve_status': approve_status,
        'approve_by': email,
        'remark':remarks
      };
      _api.markApproveReject(data, sessionManagement).then((value) {
        try {
          print(value);
          List<ApiDefaultEntity> approver_list = (json.decode(value) as List)
              .map((i) => ApiDefaultEntity.fromJson(i))
              .toList();
          //   print(approver_list);
          if (approver_list[0].condition == "True") {
            this.loading.value = false;

            //todo ritik change....

            //if(selection_type==""){
            Get.offAllNamed(RoutesName.expenseApprovarScreen);
            //}

            this.getApprovalList();
            Utils.sanckBarSuccess('Message : ', approver_list[0].message);
          } else {
            this.loading.value = false;
            Utils.sanckBarError('Message : ', approver_list[0].message);
          }
        } catch (e) {
          this.loading.value = false;
          Utils.sanckBarError('Exception : ', e.toString());
        }
      }).onError((error, stackTrace) {
        this.loading.value = false;
        Utils.sanckBarError('Api Exception onError', error.toString());
      });
    }

    void showLineImagesPopup(BuildContext context,List<Lines> linesList,int position) {
      Size size = Get.size;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          RxInt selectedindex=0.obs;
          List<String> imageUrls = [];
          try{
            print(linesList[position].imageUrl);
            print(linesList[position].imageUrl1);

            if(linesList[position].imageUrl!.isNotEmpty){
              imageUrls.add(linesList[position].imageUrl!);
            }
            if(linesList[position].imageUrl1!.isNotEmpty){
              imageUrls.add(linesList[position].imageUrl1!);
            }
            if(linesList[position].imageUrl2!.isNotEmpty){
              imageUrls.add(linesList[position].imageUrl2!);
            }
            if(linesList[position].imageUrl3!.isNotEmpty){
              imageUrls.add(linesList[position].imageUrl3!);
            }
          }catch(e){
            print(e);
          }
          return Dialog(
            insetPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppBar(
                    title: Text('Line Images', style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.sisxteen,
                        fontWeight: FontWeight.w700
                    ),),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                  SizedBox(height: size.height*.2,),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Obx((){
                            return Container(
                              width: size.width * .97,
                              height: size.height * .5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                border: Border.all(color: AllColors.primaryliteColor, width: .5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Image.network(
                                  (imageUrls.length > 0 && imageUrls != null && imageUrls.isNotEmpty)
                                      ? imageUrls[selectedindex.value]
                                      : 'https://dev4.pristinefulfil.com/assets/images/vendor_panel_img/mylogo.png',
                                  fit: BoxFit.cover,
                                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child; // Return the image if it's fully loaded
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(color: AllColors.primaryDark1), // Show a progress indicator while loading
                                      );
                                    }
                                  },
                                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                    return Center(
                                      child: Text('Failed to load image'+exception.toString()), // Show an error message if image loading fails
                                    );
                                  },
                                ),
                              ),
                            );
                          }),
                          Padding(
                            padding: const EdgeInsets.only(top: 6.0,bottom: 6.0),
                            child: Divider(color: AllColors.primaryliteColor,height: 1,),
                          ),//
                          SizedBox(height: 20),
                          Container(
                            height: 100,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: imageUrls.length,
                                itemBuilder: (BuildContext context, int index) {
                                  //return BindListView(context,imageUrls!, index);
                                  return Container(
                                    width: 100,
                                    margin: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: Colors.blueGrey, width: 0.5),
                                    ),
                                    child: InkWell(
                                      onTap: (){
                                        selectedindex.value=index;
                                        print(selectedindex.value);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Image.network(
                                          imageUrls[index],
                                          fit: BoxFit.cover,
                                          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child; // Return the image if it's fully loaded
                                            } else {
                                              return Center(
                                                child: CircularProgressIndicator(color: AllColors.primaryDark1), // Show a progress indicator while loading
                                              );
                                            }
                                          },
                                          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                            return Center(
                                              child: Text('Failed to load image'), // Show an error message if image loading fails
                                            );
                                          },

                                        ),
                                      ),
                                    ),
                                  );
                                }
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

}