import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:navigation_drawer_flutter/viewModel/SessionManagment/session_managment.dart';

import '../../constants/static_methods.dart';
import '../../models/common_response/common_response.dart';
import '../../models/service_managment_model_directory/regionModel/region_model.dart';
import '../../models/user_expense_model/category_response.dart';
import '../../models/user_expense_model/expense_Line_Submit_model.dart';
import '../../models/user_expense_model/user_expense_model.dart';
import '../../reources/app_url/app_url.dart';
import '../../reources/routes/routes_name.dart';
import '../../repository/user_expense_repository/user_expense_repository.dart';
import '../../utils/app_utils.dart';
import 'package:http/http.dart' as http;
class UserExpenseViewModel extends GetxController{
  RxBool loading =false.obs;
  RxBool isCompleteBtn = false.obs;
  final _api=UserExpenseRepository();
  RxBool isPogressIndicator = false.obs;
  final ImagePicker _picker = ImagePicker();
  SessionManagement sessionManagement= SessionManagement();

//todo for get pending headerlines...............
  String pending_header_amt='0';
  String under_approval_header_amt='0';
  String unpaid_header_amt='0';
  String email="";
  String document_no = "";
  RxBool isshowDate = false.obs;
  RxBool isshowtotalKm = false.obs;
  RxString region_name = "".obs;
  RxString region_code = "".obs;
  RxBool isShowMyExpensesLines = false.obs;
  List<ExpenseHeaderResponse> header_response_list = [];
  RxBool isLinesVisible = false.obs;
  RxBool isAddLinesVisible = false.obs;
  RxBool isLinesSubmit = false.obs;
  List<ExpenseLinesSubmittedResponse> expense_line_submit_list = [];
  RxInt selectedContainerIndex = 0.obs;
  List<RegionModel> region_name_list = [];
  RxString file_path0 = ''.obs;
  RxString file_path1 = ''.obs;
  RxString file_path2 = ''.obs;
  RxString file_path3 = ''.obs;
  RxString image_url = ''.obs;
  RxString image_url1 = ''.obs;
  RxString image_url2 = ''.obs;
  RxString image_url3 = ''.obs;

//todo by default false from pristineseeds........
  RxBool iscategoryExpense = false.obs;


  RxInt isLodging = 0.obs;
  RxInt files_count = 0.obs;
  String grade = "";
  String company_id = "";
  RxInt imageCount = 0.obs;
  RxBool isShowImage = false.obs;
  var expense_catagory_controller = TextEditingController();
  var region_catagory_controller = TextEditingController();
  var date_controller = TextEditingController();
  var from_date_controller = TextEditingController();
  var to_date_controller = TextEditingController();
  var description_controller = TextEditingController();
  var amount_controller = TextEditingController();
  var remark_controller = TextEditingController();
  var total_km_controller = TextEditingController();
  RxBool addFileButton = true.obs;
  RxInt isKm = 0.obs;
  RxInt image_requred = 0.obs;
  List<CatagoryResponse> expense_catagory_list = [];

  @override
  void onInit() async {
    email=await sessionManagement.getEmail()??"";
    grade = await sessionManagement.getGrade() ?? '';
    company_id = await sessionManagement.getCompanyId() ?? '';
    getRegionsList();
    getExpenseHeader('pending');
  }

  //todo for create expense...................
  expenseCreateApi() {
    if (description_controller.text.isEmpty ||
        description_controller.text == null) {
      Utils.sanckBarError('Error : ', 'Please Enter Description.');
      return;
    }
    if (date_controller.text.isEmpty || date_controller.text == null) {
      Utils.sanckBarError('Error : ', 'Please Select Date.');
      return;
    }
    if (expense_catagory_controller.text.isEmpty || expense_catagory_controller.text == null) {
      Utils.sanckBarError('Error : ', 'Please Select Expense.');
      return;
    }
    if (isLodging>0 && (from_date_controller.text.isEmpty || from_date_controller.text == null)) {
      Utils.sanckBarError('Error : ', 'Please Select From Date.');
      return;
    }
    if (isLodging>0 && (to_date_controller.text.isEmpty || to_date_controller.text == null)) {
      Utils.sanckBarError('Error : ', 'Please Select To Date.');
      return;
    }

    if (isLodging>0 && (region_catagory_controller.text.isEmpty || region_catagory_controller.text == null)) {
      Utils.sanckBarError('Error : ', 'Please Select Region.');
      return;
    }
    if (isKm>0 && (total_km_controller.text.isEmpty || total_km_controller.text == null)) {
      Utils.sanckBarError('Error : ', 'Please Enter Total Km.');
      return;
    }

    if (amount_controller.text.isEmpty || amount_controller.text == null) {
      Utils.sanckBarError('Error : ', 'Please Enter Total Amount.');
      return;
    }
    if ((file_path0 == null || file_path0.isEmpty )&& image_requred > 0) {
      Utils.sanckBarError('Error : ', 'Please Select Image.');
      return;
    }
    //  this.loading.value = true;
    isPogressIndicator.value=true;

    Map data = {
      'document_no': '',
      'grade': grade,
      'expense_date':
      StaticMethod.convertDateFormat(date_controller.text.toString()),
      'remarks': description_controller.text.toString(),
      'da_code': '',
      'da_name': '',
      'da_amount': '0',
      'created_by': email
    };
    _api.expenseCreate(data, sessionManagement).then((value) {
      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<ExpenseLinesSubmittedResponse> responses = jsonResponse
              .map((data) => ExpenseLinesSubmittedResponse.fromJson(data))
              .toList();
          if (responses[0].condition == 'True') {
            //  loading.value = false;
            isPogressIndicator.value=false;
            hitExpenseLineSubmit(responses[0].documentNo, '',responses);
          } else {
            isPogressIndicator.value=false;
            //loading.value = false;
            Utils.sanckBarError(
                'False Message!', responses[0].message.toString());
          }
        } else {
          //loading.value = false;
          isPogressIndicator.value=false;
          Utils.sanckBarError('API Error',jsonResponse.toString());
          print(jsonResponse);
        }
      } catch (e) {
        isPogressIndicator.value=false;
        //  loading.value = false;
        printError();
      }
    }).onError((error, stackTrace) {
      print(error);
      isPogressIndicator.value=false;
      //loading.value = false;
    });
  }
  //todo hit for expense line submit...............
  Future<void> hitExpenseLineSubmit(String? documentNo, String flag, List<ExpenseLinesSubmittedResponse> ?header_response) async {
    if (flag == 'expense') {
      if (expense_catagory_controller.text.isEmpty ||
          expense_catagory_controller.text == null) {
        Utils.sanckBarError('Error : ', 'Please Enter Expense Category.');
        return;
      }
      if (amount_controller.text.isEmpty || amount_controller.text == null) {
        Utils.sanckBarError('Error : ', 'Please Enter Total Amount.');
        return;
      }
      if(expense_catagory_controller.text=="Lodging"){
        if ((file_path0 == null || file_path0.isEmpty )&& image_url.value.isEmpty) {
          Utils.sanckBarError('Error : ', 'Please Select Image.');
          return;
        }
      }

    }

    print(documentNo);
    print("regoin....${region_catagory_controller.text}");
    var totalKmText = total_km_controller.text;
    var totalKm = totalKmText.isNotEmpty ? totalKmText : '0';
    isPogressIndicator.value=true;
    // loading.value = true;

    final server_uri = Uri.parse(AppUrl.expenseLinesSubmit);
    final clint_request = http.MultipartRequest('POST', server_uri);
    var lodging_from_date=  StaticMethod.convertDateFormat(from_date_controller.text.toString()) ?? '' ;
    var lodging_to_date= StaticMethod.convertDateFormat(to_date_controller.text.toString())?? '';
    var fields = <String, String>{
      "document_no": documentNo.toString().isNotEmpty
          ? documentNo.toString()
          : expense_line_submit_list[0].documentNo.toString(),
      "expense_name": expense_catagory_controller.text,
      "expense_amount": amount_controller.text,
      "lodging_from_date": lodging_from_date.toString(),
      "lodging_to_date": lodging_to_date.toString(),
      "total_km_travel":totalKm,
      "expense_remark":remark_controller.text ??'',
      "region_code":region_code.value ??'',
      "region_name":region_catagory_controller.text ??''
    };
    clint_request.fields.addAll(fields);
    if (file_path0.isNotEmpty) {
      clint_request.files
          .add(await http.MultipartFile.fromPath('image1', file_path0.value));
    }
    if (file_path1.isNotEmpty) {
      clint_request.files
          .add(await http.MultipartFile.fromPath('image2', file_path1.value));
    }
    if (file_path2.isNotEmpty) {
      clint_request.files
          .add(await http.MultipartFile.fromPath('image3', file_path2.value));
    }
    if (file_path3.isNotEmpty) {
      clint_request.files
          .add(await http.MultipartFile.fromPath('image4', file_path3.value));
    }
    isLinesVisible.value = false;
    //--hit api
    _api.expenseLinesSubmit(clint_request, sessionManagement).then((value) {
      print(value);
      final jsonResponse = json.decode(value);
      try {
        print(value);
        if (jsonResponse is List) {
          List<ExpenseLinesSubmittedResponse> response = jsonResponse
              .map((data) => ExpenseLinesSubmittedResponse.fromJson(data))
              .toList();
          if (response[0].condition == 'True') {
            print(response);
            isPogressIndicator.value=false;
            //   loading.value = false;
            isLinesVisible.value = true;
            isAddLinesVisible.value = false;
            isLinesSubmit.value = true;
            isCompleteBtn.value = true;
            expense_line_submit_list = response;
            print("jekfjkerjfkfjkvjwfkvg");
            resetAllFields();
            Utils.sanckBarSuccess(
                'True Message', expense_line_submit_list[0].message.toString());

            Get.toNamed(RoutesName.expenseScreen);
          }
          else {
            if(flag==''){
              isPogressIndicator.value=false;
              //  loading.value = false;
              isshowDate.value=true;
              isshowtotalKm.value=true;
              isLinesVisible.value = true;
              isAddLinesVisible.value = true;
              isLinesSubmit.value = true;
              isCompleteBtn.value = false;

              expense_line_submit_list = header_response!;
              //resetAllFields();
              Utils.sanckBarError(
                  'False Message!', response[0].message.toString());

              Get.toNamed(RoutesName.expenseScreen);
            }else{
              isLinesVisible.value = true;
              //isshowDate.value=true;
              //expense_line_submit_list = [];
              isPogressIndicator.value=false;
              //  loading.value = false;
              Utils.sanckBarError(
                  'False Message!', response[0].message.toString());
            }

          }
        } else {
          isPogressIndicator.value=false;
          // loading.value = false;
          isLinesVisible.value = true;
          Utils.sanckBarError('API Response Error ', jsonResponse?? '');
          print(jsonResponse);
        }
      } catch (e) {
        print(e);
      }
    }).onError((error, stackTrace) {
      isLinesVisible.value = true;
      print(error);
      isPogressIndicator.value=false;
      //loading.value = false;
      Utils.sanckBarError('Error!', "Api Response Error ${error}");
    });
  }


  //todo show line details for editing
  showExpenseLineDetails(int position) {
    var inputFormat = DateFormat('yyyy-MM-dd');
    var outputFormat = DateFormat('dd-MM-yyyy');
    isCompleteBtn.value = false;
    isAddLinesVisible.value = true;
    isLinesSubmit.value = false;
    isShowImage.value = true;
    print( ' islodging ::${expense_line_submit_list[0].lines![position].isLodging}');
    expense_catagory_controller.text = expense_line_submit_list[0].lines![position].expenseName!;
    amount_controller.text = expense_line_submit_list[0].lines![position].expenseAmount.toString()!;
    remark_controller.text=expense_line_submit_list[0].lines![position].expenseRemark!;
    if(expense_line_submit_list[0].lines![position].isLodging!>0){
      String lodgingFromDate = expense_line_submit_list[0].lines?[position]?.lodgingFromDate ?? "";
      print('loging...${lodgingFromDate}');
      String lodgingtoDate = expense_line_submit_list[0].lines?[position]?.lodgingToDate ?? "";
      DateTime? parsedfromDate = inputFormat.parse(lodgingFromDate, true);
      DateTime? parsedtoDate = inputFormat.parse(lodgingtoDate, true);
      String formattedDate = outputFormat.format(parsedfromDate);
      String formattedtoDate = outputFormat.format(parsedtoDate);

      from_date_controller.text=formattedDate/*expense_line_submit_list[0].lines![position].lodgingFromDate!*/;
      to_date_controller.text=formattedtoDate/*expense_line_submit_list[0].lines![position].lodgingToDate!*/;
      region_catagory_controller.text=expense_line_submit_list[0].lines![position].regionName!;
      isshowDate.value=true;
      isLodging.value=expense_line_submit_list[0].lines![position].isLodging!;
      region_code.value=expense_line_submit_list[0].lines![position].regionCode!;
    }
    else{
      isLodging.value=0;
    }

    if(expense_line_submit_list[0].lines![position].isKm!>0){
      total_km_controller.text=expense_line_submit_list[0].lines![position].totalKmTravel.toString();
      isshowtotalKm.value=true;
      isKm.value=expense_line_submit_list[0].lines![position].isKm!;
    }
    else{
      isKm.value=0;
    }
    print('imageUrl'+expense_line_submit_list[0].lines![position].imageUrl.toString());
    if (expense_line_submit_list[0].lines![position].imageUrl!.isNotEmpty) {
      image_url.value = expense_line_submit_list[0].lines![position].imageUrl.toString()!;
      //files_count.value++;
    }

    if (expense_line_submit_list[0].lines![position].imageUrl1!.isNotEmpty) {
      image_url1.value = expense_line_submit_list[0].lines![position].imageUrl1.toString()!;
      // files_count.value++;
    }
    if (expense_line_submit_list[0].lines![position].imageUrl2!.isNotEmpty) {
      image_url2.value = expense_line_submit_list[0].lines![position].imageUrl2.toString()!;
      //files_count.value++;
    }
    if (expense_line_submit_list[0].lines![position].imageUrl3!.isNotEmpty) {
      image_url3.value = expense_line_submit_list[0].lines![position].imageUrl3.toString()!;
      //files_count.value++;
    }

    if (files_count.value >= 0 && files_count.value<=3) {
      addFileButton.value = true;
    }
    expenseAttachmentCount();

  }


  getExpenseHeader(String status) {
    this.loading.value = true;
    Map<String, String> data = {'email_id': email, 'status': status};
    isShowMyExpensesLines.value = false;
    _api.getExpenseHeader(data, sessionManagement).then((value) {
      print(value);

      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<ExpenseHeaderResponse> header_response = jsonResponse
              .map((data) => ExpenseHeaderResponse.fromJson(data))
              .toList();
          if (header_response != null &&
              header_response.length > 0 &&
              header_response[0].condition == 'True') {
            pending_header_amt=header_response[0].pendingAmount.toString();
            under_approval_header_amt=header_response[0].underApproveAmount.toString();
            unpaid_header_amt=header_response[0].unpaidAmount.toString();
            header_response_list = header_response;

            loading.value = false;
            isShowMyExpensesLines.value = true;

            //Utils.sanckBarSuccess('True Message!', header_response[0].condition.toString());
          } else {
            pending_header_amt=header_response[0].pendingAmount.toString();
            under_approval_header_amt=header_response[0].underApproveAmount.toString();
            unpaid_header_amt=header_response[0].unpaidAmount.toString();
            isShowMyExpensesLines.value = true;
            loading.value = false;
            header_response_list = [];
          }
        } else {
          pending_header_amt='0';
          under_approval_header_amt='0';
          unpaid_header_amt='0';
          loading.value = false;
          Utils.showErrorToastification(
              'API Error',
              jsonResponse["message"] == null
                  ? 'Invalid response format'
                  : jsonResponse["message"]);
        }
      } catch (e) {
        pending_header_amt='0';
        under_approval_header_amt='0';
        unpaid_header_amt='0';
        loading.value = false;
        printError();
        print(e);
      }
    }).onError((error, stackTrace) {
      pending_header_amt='0';
      under_approval_header_amt='0';
      unpaid_header_amt='0';
      print(error);
      loading.value = false;
    });
  }
  Future getFile(String flag) async {
    print(flag);
    FilePickerResult? result =
    await FilePicker.platform.pickFiles(allowMultiple: false);
    try {
      if (result != null) {
        List<File> files = result.paths.map((path) => File(path!)).toList();
        if (files.isNotEmpty) {
          /* String outputPath = files[0].path;
          int maxSizeInBytes = 3000 * 1024;

          // Compress and save the selected image
          await compressAndSaveImage(files[0], outputPath, maxSizeInBytes);*/
          // Set the selected file path to the appropriate observable based on selectedContainerIndex
          isShowImage.value = false;
          if (flag.isEmpty) {
            if (selectedContainerIndex.value == 0) {
              file_path0.value = files[0].path;
              imageCount+=1;
            } else if (selectedContainerIndex.value == 1) {
              file_path1.value = files[0].path;
              imageCount+=1;

            } else if (selectedContainerIndex.value == 2) {
              file_path2.value = files[0].path;
              imageCount+=1;

            } else if (selectedContainerIndex.value == 3) {
              file_path3.value = files[0].path;
              imageCount+=1;

            }
            selectedContainerIndex.value++;
          } else {
            if (flag == 'file_one') {
              if(file_path0.value.isEmpty){
                imageCount+=1;
              }
              file_path0.value = files[0].path;

            } else if (flag == 'file_two') {
              if(file_path1.value.isEmpty){
                imageCount+=1;
              }
              file_path1.value = files[0].path;

            } else if (flag == 'file_three') {
              if(file_path2.value.isEmpty){
                imageCount+=1;

              }
              file_path2.value = files[0].path;

            } else if (flag == 'file_four') {
              if(file_path3.value.isEmpty){
                imageCount+=1;
                addFileButton.value=false;
                addFileButton.value=true;
              }
              file_path3.value = files[0].path;
            }

          }
          isShowImage.value = true;
          //todo Increment the index for the next container


          // todo Reset the index to 0 if it goes beyond 3 (assuming you have 4 containers)
          /*  if (selectedContainerIndex.value > 3) {
             selectedContainerIndex.value = 0;
          }*/
        }
        expenseAttachmentCount();
        print(flag + ' aaa ${file_path2.value} bb  ${files[0].path}');
      }
      if (selectedContainerIndex > 3) {
        addFileButton.value = false;
      } else {
        //Utils.sanckBarError('Image!', 'No Select Any Image');
      }
    } catch (e) {
      print(e);
      Utils.sanckBarError('Image Error!', e.toString());
    }
  }

  //todo for create expense...................
  getExpensesHeaderLinesApi(String documentNo) {
    this.loading.value = true;
    Map data = {'document_no': documentNo, 'created_by': email};

    _api.expenseCreate(data, sessionManagement).then((value) {
      try {
        final jsonResponse = json.decode(value);
        print(value);
        if (jsonResponse is List) {
          List<ExpenseLinesSubmittedResponse> header_lines_response =
          jsonResponse
              .map((data) => ExpenseLinesSubmittedResponse.fromJson(data))
              .toList();
          if (header_lines_response[0].condition == 'True') {
            loading.value = false;
            isLinesVisible.value = true;
            isAddLinesVisible.value = false;
            isLinesSubmit.value = true;
            //isCompleteBtn.value=true;
            expense_line_submit_list = header_lines_response;


            if (expense_line_submit_list[0].isDone! > 0) {
              isCompleteBtn.value = false;
            } else {
              isCompleteBtn.value = true;
            }

            print('doc no:-  ${expense_line_submit_list[0].documentNo}');
            Get.toNamed(RoutesName.expenseScreen);
          } else {
            expense_line_submit_list = [];
            loading.value = false;
            Utils.sanckBarError(
                'False Message!', header_lines_response[0].message.toString());
          }
        } else {
          loading.value = false;
          expense_line_submit_list = [];
          Utils.sanckBarError(
              'API Error',
              jsonResponse["message"] == null
                  ? 'Invalid response format'
                  : jsonResponse["message"]);
        }
      } catch (e) {
        expense_line_submit_list = [];
        loading.value = false;
        printError();
      }
    }).onError((error, stackTrace) {
      print(error);
      loading.value = false;
      expense_line_submit_list = [];
    });
  }


  //todo hit for get expense catagories.............
  getExpenseCatagory(String flag) {
    selectedContainerIndex.value = 0;
    files_count.value = 0;
    addFileButton.value = true;
    file_path0.value = '';
    file_path1.value = '';
    file_path2.value = '';
    file_path3.value = '';
    image_url.value = '';
    image_url1.value = '';
    image_url2.value = '';
    image_url3.value = '';
    expense_catagory_controller.text = '';
    amount_controller.text = '';
    remark_controller.text='';
    from_date_controller.text= '';
    to_date_controller.text= '';
    region_catagory_controller.text= '';
    total_km_controller.text= '';

    this.loading.value = true;
    Map data = {'flag': 'GetExpense'};
    _api.getExpenseCatagory(data, sessionManagement).then((value) {
      try {
        List<CatagoryResponse> expense_response = (json.decode(value) as List)
            .map((i) => CatagoryResponse.fromJson(i))
            .toList();
        if (expense_response.length != null &&
            expense_response.length > 0 &&
            expense_response[0].condition == 'True') {
          expense_catagory_list = expense_response;
          if (flag != 'add_new')
            Get.toNamed(RoutesName.createExpenseScreen);

        } else {
          expense_catagory_list = [];
          Utils.sanckBarError(
              'Message False!', 'Expenses Categories Not Found');


        }
      } catch (e) {
        expense_catagory_list = [];
      }
    }).onError((error, stackTrace) {
      expense_catagory_list = [];
      Utils.sanckBarError('Api Exception onError', error.toString());
    }).whenComplete(() => {this.loading.value = false});
  }


  //todo hit for get expense lines.....
  Future<void> getRegionsList() async {
    // this.loading.value = true;
    isPogressIndicator.value=true;
    Map<String, String> data = {
      'grade': grade,
    };
    _api.getRegion(data,sessionManagement).then((value) {
      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<RegionModel> responses = jsonResponse
              .map((data) => RegionModel.fromJson(data))
              .toList();
          if (responses != null && responses.length > 0) {
            //loading.value = false;
            isPogressIndicator.value=false;
            region_name_list=responses;
          } else {
            // loading.value = false;
            isPogressIndicator.value=false;
            region_name_list=[];
          }
        } else {
          // loading.value = false;
          isPogressIndicator.value=false;
          region_name_list=[];
          Utils.sanckBarError(
              'API Error',
              jsonResponse["message"] == null
                  ? 'Invalid response format'
                  : jsonResponse["message"]);
        }
      } catch (e) {
        isPogressIndicator.value=false;
        // loading.value = false;
        region_name_list=[];
        printError();
      }
    }).onError((error, stackTrace) {
      print(error);
      //  loading.value = false;
      isPogressIndicator.value=false;
      region_name_list=[];
    });
  }


  void upLoadImage(BuildContext context, String flag) async{
    var image = await _picker.pickImage(source: ImageSource.camera, maxHeight:500,maxWidth:500,imageQuality: 70);
    if (image != null) {
      isShowImage.value = false;
      if (flag.isEmpty) {
        if (selectedContainerIndex.value == 0) {
          file_path0.value = image.path;
          imageCount+=1;
        } else if (selectedContainerIndex.value == 1) {
          file_path1.value = image.path;
          imageCount+=1;

        } else if (selectedContainerIndex.value == 2) {
          file_path2.value = image.path;
          imageCount+=1;

        } else if (selectedContainerIndex.value == 3) {
          file_path3.value = image.path;
          imageCount+=1;

        }
        selectedContainerIndex.value++;
      } else {
        if (flag == 'file_one') {
          if(file_path0.value.isEmpty){
            imageCount+=1;
          }
          file_path0.value = image.path;

        } else if (flag == 'file_two') {
          if(file_path1.value.isEmpty){
            imageCount+=1;

          }
          file_path1.value = image.path;

        } else if (flag == 'file_three') {
          if(file_path2.value.isEmpty){
            imageCount+=1;

          }
          file_path2.value = image.path;

        } else if (flag == 'file_four') {
          if(file_path3.value.isEmpty){
            imageCount+=1;
            addFileButton.value=false;
            addFileButton.value=true;
          }
          file_path3.value = image.path;
        }

      }
      isShowImage.value = true;

      expenseAttachmentCount();
      if (selectedContainerIndex > 3) {
        addFileButton.value = false;
      } else {
        //Utils.sanckBarError('Image!', 'No Select Any Image');
      }
    }
  }

  expenseAttachmentCount(){
    files_count.value=0;
    if (image_url.isNotEmpty || file_path0.isNotEmpty) {
      files_count.value++;
    }
    if (image_url1.isNotEmpty || file_path1.isNotEmpty) {
      files_count.value++;
    }
    if (image_url2.isNotEmpty || file_path2.isNotEmpty ){
      files_count.value++;
    }
    if (image_url3.isNotEmpty || file_path3.isNotEmpty ) {
      files_count.value++;
    }

  }



  //todo hit for complete expense..............
  expenseCompleteApiHit() {
    //this.loading.value = true;
    isPogressIndicator.value=true;
    Map data = {
      'document_no': expense_line_submit_list[0].documentNo,
      'email_id': email
    };
    _api.expenseComplete(data, sessionManagement).then((value) {
      print('complete doc no:-  ${expense_line_submit_list[0].documentNo}');
      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<CommonResponse> responses = jsonResponse
              .map((data) => CommonResponse.fromJson(data))
              .toList();
          if (responses[0].condition == 'True') {
            //loading.value = false;
            isPogressIndicator.value=false;
            Utils.sanckBarSuccess(
                'True Message!', responses[0].message.toString());
            expense_line_submit_list = [];
            Get..offAllNamed(RoutesName.myExpenseScreen);
           // Get.toNamed(RoutesName.myExpenseScreen, preventDuplicates: false);
          } else {
            // loading.value = false;
            isPogressIndicator.value=false;
            Utils.showErrorToastification(
                'False Message!', responses[0].message.toString());
          }
        } else {
          //loading.value = false;
          isPogressIndicator.value=false;
          Utils.sanckBarError('API Response Error: ', jsonResponse);
        }
      } catch (e) {
        //loading.value = false;
        isPogressIndicator.value=false;
        printError();
      }
    }).onError((error, stackTrace) {
      print(error);
      //loading.value = false;
      isPogressIndicator.value=false;
    });
  }

  void resetAllFields() {
    expense_catagory_controller.text='';
    iscategoryExpense.value=false;
    //  expense_catagory_list.clear();
    isshowDate.value = false;
    isshowtotalKm.value = false;
    isShowImage.value=false;
    iscategoryExpense.value=true;
    addFileButton.value = true;
    isLodging.value=0;
    isKm.value=0;
    description_controller.text = '';
    date_controller.text = '';
    amount_controller.text = '';
    from_date_controller.text= '';
    to_date_controller.text= '';
    region_catagory_controller.text= '';
    total_km_controller.text= '';
    remark_controller.text= '';
    selectedContainerIndex.value = 0;
    imageCount.value=0;
    file_path0.value = '';
    file_path1.value = '';
    file_path2.value = '';
    file_path3.value = '';

  }



  //todo reset all fields......
  resetAllfieldsAndPath(){
    expense_catagory_controller.text=expense_catagory_controller.text.isNotEmpty?'':'';
    amount_controller.text= amount_controller.text.isNotEmpty?'':'';
    from_date_controller.text= from_date_controller.text.isNotEmpty?'':'';
    to_date_controller.text= to_date_controller.text.isNotEmpty?'':'';
    region_catagory_controller.text= region_catagory_controller.text.isNotEmpty?'':'';
    total_km_controller.text= total_km_controller.text.isNotEmpty?'':'';
    remark_controller.text= remark_controller.text.isNotEmpty?'':'';

    image_url.value=image_url.value.isNotEmpty?'':'';
    image_url1.value=image_url1.value.isNotEmpty?'':'';
    image_url2.value=image_url2.value.isNotEmpty?'':'';
    image_url3.value=image_url3.value.isNotEmpty?'':'';

    file_path0.value=file_path0.value.isNotEmpty?'':'';
    file_path1.value=file_path1.value.isNotEmpty?'':'';
    file_path2.value=file_path2.value.isNotEmpty?'':'';
    file_path3.value=file_path3.value.isNotEmpty?'':'';

    isshowDate.value=false;
    addFileButton.value=false;
    isshowtotalKm.value=false;
    isShowImage.value = false;
    addFileButton.value = false;
    files_count.value = 0;
  }

}