import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:navigation_drawer_flutter/models/order_model/order_item_category_model.dart';
import 'package:navigation_drawer_flutter/repository/order_repository/order_repository.dart';
import 'package:navigation_drawer_flutter/viewModel/SessionManagment/session_managment.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../models/order_model/consignee_Model.dart';
import '../../models/order_model/customer_model.dart';


import '../../models/order_model/order_header_create_model.dart';
import '../../models/order_model/order_item_get_model.dart';
import '../../models/order_model/order_list_screen.dart';
import '../../reources/routes/routes_name.dart';
import '../../utils/app_utils.dart';

class OrderViewModel extends GetxController{
  final _api=OrderRepository();

    SessionManagement sessionManagement=SessionManagement();
     RxBool loading=false.obs;
     String email='';
     int pageNumber=0;
     int rowsPerPage=10;
     int total_rows=0;

  RxBool isShowListView = false.obs;

  int index=0;

  bool isButtonEnabled = true;
  RxList<OrderHeaderGetModel> order_header_list=<OrderHeaderGetModel>[].obs;
  RxList<OrderHeaderCreateModel> order_details_list=<OrderHeaderCreateModel>[].obs;
  RxList<OrderItemCategoryModel> searchResult = <OrderItemCategoryModel>[].obs;
  RxList<OrderItemCategoryModel> order_item_category_list = <OrderItemCategoryModel>[].obs;
  RxList<OrderItemGetModel> order_item_get_list = <OrderItemGetModel>[].obs;
  List<CustomersModel> customers_list=[];
  RxList<ConsigneeModel> consignee_list = <ConsigneeModel>[].obs;
  Rx<CustomersModel> selected_customer=new CustomersModel().obs;
  RxBool isShowCustomerDetails = false.obs;
  RxBool isShowCheck = false.obs;
  RxBool isCheckBoxChecked = false.obs;
  RxBool isShowDropDown = true.obs;
  String selection_type = "";

  var search_item_category_crop_controller = TextEditingController();
  var qty_controller = TextEditingController();
  var customers_controller = TextEditingController();
  var order_date_controller = TextEditingController();
  var order_expiry_date_controller = TextEditingController();
  var consignee_name_drop_down_controller = TextEditingController();
  var global_search_controller = TextEditingController();
  var order_filter_date_controller = TextEditingController();
  var order_filter_customer_no_controller = TextEditingController();
  var order_filter_customer_name_controller = TextEditingController();
  var order_Complete_remark_controller = TextEditingController();


  RxString pending_amt = ''.obs;
  RxString under_approval_amt = ''.obs;
  RxString pending_shipment_amt = ''.obs;
  RxString status="Pending".obs;

  @override
  void onInit() async {
    email =await sessionManagement.getEmail()??"";
    orderHeaderApi(pageNumber);

  }

  String getCurrentExpryDate(int no_of_expiry_days) {
    var now = new DateTime.now();
    now=now.add(Duration( days: no_of_expiry_days));
    var formatter = new DateFormat('yyyy-MM-dd');
    print(formatter.format(now) +"  "+no_of_expiry_days.toString());
    return formatter.format(now);
  }

  orderHeaderApi(int page_no,{String global_search=""}){
    Map data;
    if(global_search!=null && global_search!='' && global_search.isNotEmpty){
      print("fjdbfgjdb");
      data={
        "order_no":global_search,
        "order_date": "",
        "customer_no": "",
        "customer_name": "",
        "consignee_id": "",
        "consignee_name": "",
        "order_status": status.value,
        "email_id": email,
        "rowsPerPage": rowsPerPage,
        "pageNumber": page_no
      };
    }else{
      data={
        "order_no":"",
        "order_date":order_filter_date_controller.text,
        "customer_no":order_filter_customer_no_controller.text,
        "customer_name":order_filter_customer_name_controller.text,
        "consignee_id": "",
        "consignee_name": "",
        "order_status": status.value,
        "email_id": email,
        "rowsPerPage": rowsPerPage,
        "pageNumber": page_no
      };
    }
    loading.value=true;
    _api.orderHeaderListApiHit(data, sessionManagement).then((value) {
      final jsonResponse = json.decode(value);
      try{
        if(jsonResponse is List ){
          List<OrderHeaderGetModel>  response = jsonResponse.map((data) => OrderHeaderGetModel.fromJson(data))
              .toList();
          if(response!=null && response.length>0 &&  response[0].condition=="True"){
            if(page_no==0){
              order_header_list.clear();
            }
            order_filter_date_controller.clear();
            order_filter_customer_no_controller.clear();
            order_filter_customer_name_controller.clear();
            order_header_list.addAll(response);
            total_rows!=response[0].totalRows!;
            pending_amt.value=response[0].pendingAmount.toString();
            under_approval_amt.value=response[0].underApproveAmount.toString();
            pending_shipment_amt.value=response[0].pendingShipmentAmount.toString();

          }else{
            pending_amt.value=response[0].pendingAmount.toString();
            under_approval_amt.value=response[0].underApproveAmount.toString();
            pending_shipment_amt.value=response[0].pendingShipmentAmount.toString();
             order_header_list.value=[];
          }
        }else{
          Utils.showErrorToastification("Api Error!", jsonResponse);
        }
      }catch(e){
        print(e);
      }finally{
        loading.value=false;
      }
    },).onError((error, stackTrace) {
      print(error);
      print(stackTrace);
      loading.value=false;
    },).whenComplete(() {
      loading.value=false;
    },);




  }



  Future<Iterable<CustomersModel>> searchCustomer(String query) async {

    if (query == '') {
      return const Iterable<CustomersModel>.empty();
    }
    Map data = {
      "customer_no": "",
      "customer_name": query,
      "state_code": "",
      "email_id": email,
      "row_per_page": 10,
      "page_number": 0
    };
    String customer_response =await _api.getCustomersApiHit(data, sessionManagement);
    print(customer_response);
    try {
      final jsonResponse = json.decode(customer_response);

      if (jsonResponse is List) {
        print(jsonResponse);
        List<CustomersModel> response =
        jsonResponse.map((data) => CustomersModel.fromJson(data)).toList();
        print('condition..'+response[0].condition.toString());
        if (response[0].condition == 'True') {
          print(jsonResponse);
          customers_list = response;
          print(customers_list[0].customerName);

        } else {
         /// Utils.showErrorToastification('False!', response[0].message!);
          customers_list = [];
        }
      } else {
        Utils.showErrorToastification('False!', jsonResponse.message);
        customers_list = [];
      }
    } catch (e) {
      Utils.showErrorToastification('Exception!', e.toString());
      customers_list = [];
    }
    return customers_list;
  }

  //todo for filter list........
  onSearchTextChanged(String text) async {
    try{
      if (text.isEmpty) {
        searchResult.value = await List.from(order_item_category_list);
        update();
        return;
      }
      searchResult.value = await order_item_category_list
          .where((item) => item.categoryCode!.toLowerCase().contains(text.toLowerCase()))
          .toList();
      update();
    }catch(e){
      print(e);
    }
  }
  orderDetailsApiHit(String order_no,String flag){
    Map data={
      "order_no": order_no,
      "email_id": email
    };
    print(data);
    loading.value=true;
    _api.orderDetailsApiHit(data, sessionManagement).then((value) {
      print(value);
      final jsonResponse = json.decode(value);
      try{
        if(jsonResponse is List ){
          List<OrderHeaderCreateModel>  response = jsonResponse.map((data) => OrderHeaderCreateModel.fromJson(data))
              .toList();
          if(response!=null && response.length>0 &&  response[0].condition=="True"){
            order_details_list.value=response;
            if(flag=='CART' || flag=='Shipped Details'){
               Get.toNamed(RoutesName.order_view_cart_screen);
            }
            else{
              Get.toNamed(RoutesName.order_item_category_screen);
            getOrderItemCategoryGet(order_details_list[0].orderNo!);
            }



          }else{
            order_details_list.value=[];
          }
        }else{
          Utils.showErrorToastification("Api Error!", jsonResponse);
        }
      }catch(e){
        print(e);
      }finally{
        loading.value=false;
      }
    },).onError((error, stackTrace) {
      print(error);
      print(stackTrace);
      loading.value=false;
    },).whenComplete(() {
      loading.value=false;
    },);

  }



  getOrderItemCategoryGet(String orderNo){
    Map<String, String> data = {
      'order_no':orderNo,
      'email_id':email
    };
    _api.orderItemCategoryApiHit(data, sessionManagement).then((value) {
      try {
        print(value);
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<OrderItemCategoryModel> response =
          jsonResponse.map((data) => OrderItemCategoryModel.fromJson(data)).toList();
          if (response!=null && response.isNotEmpty && response[0].condition == 'True') {
            isShowListView.value=true;
            order_item_category_list.value=response;
            searchResult.value=response;
            print('list length:: ${searchResult.length.toString()}');
          } else {
            order_item_category_list.value = [];
            Utils.showErrorToastification('API Error', 'Item Category Not Found Of This User.');
          }
        } else {
          order_item_category_list.value = [];
          Utils.showErrorToastification(
              'API Error',
              jsonResponse["message"] == null
                  ? 'Invalid response format'
                  : jsonResponse["message"]);
        }
      } catch (e) {
        order_item_category_list.value = [];
        print(e);
      }
    }).onError((error, stackTrace) {
      order_item_category_list.value = [];
    });
  }

  getOrderItemGet(String orderNo,String category_code, String flag){
    Map<String, String> data = {
      "order_no": orderNo,
      "email_id": email,
      "category_code":category_code,
      "group_code": ""
    };
    print(data);
    loading.value=true;
    _api.orderItemApiHit(data, sessionManagement).then((value) {
      try {
        print(value);
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<OrderItemGetModel> response =
          jsonResponse.map((data) => OrderItemGetModel.fromJson(data)).toList();
          if (response!=null && response.isNotEmpty && response[0].condition == 'True') {
            isShowListView.value=true;
            order_item_get_list.value=response;
            if(flag=='VARIETY'){
              Get.toNamed(RoutesName.order_variety_screen);
            }
             //Get.toNamed(RoutesName.order_variety_screen);
            print('list length:: ${searchResult.length.toString()}');
          } else {
            order_item_get_list.value = [];
            Utils.showErrorToastification('API Error', 'Item Category Not Found Of This User.');
          }
        } else {
          order_item_get_list.value = [];
          Utils.showErrorToastification(
              'API Error',
              jsonResponse["message"] == null
                  ? 'Invalid response format'
                  : jsonResponse["message"]);
        }
      } catch (e) {
        order_item_category_list.value = [];
        print(e);
      }finally{
        loading.value=false;
      }
    }).onError((error, stackTrace) {
      loading.value=false;
      order_item_category_list.value = [];
    }).whenComplete(() {
      loading.value=false;
    },);
  }
  orderItemLineInsert(String orderNo,String itemNo,int qty,String tag,String from_page) {
    if (!isButtonEnabled)
      return; // Do not proceed if the button is disabled
    isButtonEnabled = false;
    if(tag=='ADD'){
      qty+=1;
    }
    else if(tag=='REMOVE'){
      qty-=1;
    }

    Map<String, String> data ={
      "order_no": orderNo,
      "item_no": itemNo,
      "qty":qty.toString() ?? '',
      "email_id":email
    };
    loading.value = true;
    _api.orderLineInsert(data, sessionManagement).then((value) {
      print(value);
      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<OrderHeaderCreateModel> response =
          jsonResponse.map((data) => OrderHeaderCreateModel.fromJson(data)).toList();
          if (response!=null && response.length>0 && response[0].condition == 'True') {
            isButtonEnabled = true;
            order_details_list.value=response;
            print(response);

           // getOrderItemGroupGet(order_detail_list[0].orderNo!,SelectedVariety.value,'');

            //Utils.sanckBarSuccess('Success Message!', order_detail_list[0].message.toString());

            //todo for refresh item category list

           // getOrderItemCategoryGet(order_details_list[0].orderNo!);

            if(from_page=='VARIETY' || from_page=='CART' || from_page=='Dialog')
            {
              if(order_item_get_list.length>0)
                getOrderItemGet(orderNo,this.order_item_get_list[0].categoryCode!,"");
            }
          } else {

            isButtonEnabled = true;
            Utils.sanckBarError('False Message!', response[0].message.toString());
            print(value);
          }
        } else {

          isButtonEnabled = true;
          Utils.sanckBarError('API Response Error', jsonResponse);
        }
      } catch (e) {

        isButtonEnabled = true;
        printError();
        Utils.sanckBarException('Exception Message!', e.toString());
      }finally{
        loading.value = false;
      }
    }).onError((error, stackTrace) {
      print(error);

      isButtonEnabled = true;
    }).whenComplete(() {
      loading.value = false;
    },);
  }

  orderHeaderComplete(String orderNo) {
    Map<String, String> data ={
      "order_no": orderNo,
      "email_id":email,
      "description": order_Complete_remark_controller.text
    };
    print(data);
    loading.value = true;
    _api.orderHeaderComplete(data, sessionManagement).then((value) {
      print(value);
      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<OrderHeaderCreateModel> response =
          jsonResponse.map((data) => OrderHeaderCreateModel.fromJson(data)).toList();
          if (response!=null && response.length>0 && response[0].condition == 'True') {
            loading.value = false;
            Utils.sanckBarSuccess('Success Message!', response[0].message.toString());
            Get.dialog(
              WillPopScope(
                onWillPop: () async {
                  return false; // Return true to allow popping the route
                },
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.white, // Change this color or add decoration as needed
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          "assests/images/check.png", // Replace with your tick image asset
                          width: 100,
                          height: 100,
                          // Adjust width and height according to your image size
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text('Order Confirmed !',
                        style: GoogleFonts.poppins(
                            color: AllColors.blackColor,
                            fontSize: AllFontSize.twentee,
                            fontWeight: FontWeight.w700
                        ),
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text("Your order,(${response[0].orderNo!}) has been completed.",
                          style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w500
                          ),),
                      ),
                      SizedBox(height: 20),
                      TextButton(
                        child: Text(
                            'Continue Shopping',
                            style: GoogleFonts.poppins(
                                color: AllColors.customDarkerWhite,
                                fontSize: AllFontSize.sisxteen,
                                fontWeight: FontWeight.w700
                            )
                        ),
                        onPressed: () {
                          Get.offAllNamed(RoutesName.order_screen);
                        //  orderHeaderApi(pageNumber);
                        },
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.grey,
                            elevation: 2,
                            backgroundColor: AllColors.primaryDark1),
                      ),
                    ],
                  ),
                ),
              ),
              barrierDismissible: false, // Set to true to allow dismissing by tapping outside
              // barrierColor: Colors.black.withOpacity(0.5), // Adjust background opacity as needed
              useSafeArea: true, // Ensure content is within safe area boundaries
            );

          } else {
            loading.value = false;
            Utils.sanckBarError('False Message!', response[0].message.toString());
            print(value);
          }
        } else {
          loading.value = false;
          Utils.sanckBarError('API Response Error', jsonResponse);
        }
      } catch (e) {
        loading.value = false;
        printError();
        Utils.sanckBarException('Exception Message!', e.toString());
      }
    })
        .onError((error, stackTrace) {
      print(error);
      loading.value = false;
    }).whenComplete(() {
      loading.value = false;
    },);
  }

  orderHeaderCreate(String order_type){

    order_details_list.value=[];
    if(order_type=='order'){
      if(customers_controller.text.isEmpty){
        Utils.sanckBarError('Error : ', 'Please Select Customer.');
        return;
      }
    }
    if(isCheckBoxChecked.value && consignee_name_drop_down_controller.text.isEmpty){
      Utils.sanckBarError('Error : ', 'Please Select Consignee Name.');
      return;
    }

    if(order_date_controller.text.isEmpty){
      Utils.sanckBarError('Error : ', 'Please Select Order Date.');
      return;
    }

    /*if(location_center_controller.text.isEmpty){
      Utils.sanckBarError('Error : ', 'Please Select Payment Term.');
      return;
    }*/


    if(order_expiry_date_controller.text.isEmpty){
      Utils.sanckBarError('Error : ', 'Please Select Expiry Date.');
      return;
    }
    loading.value = true;
    Map<String ,String> data={
      "order_no": "",
      "order_date": order_date_controller.text,
      "payment_term_code": "",
      "expiry_date": "",
      "customer_no": selected_customer.value.customerNo.toString(),
      "consignee_id": "",
      "email_id": email
    };
    print("hlw________dar${data}");
    _api.orderHeaderCreate(data, sessionManagement).then((value) {
      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<OrderHeaderCreateModel> response =
          jsonResponse.map((data) => OrderHeaderCreateModel.fromJson(data)).toList();
          if (response[0].condition == 'True') {
            loading.value = false;
            order_details_list.value=response;
            Utils.showToastification('Success Message!', response[0].message.toString());
            //Get.offAllNamed(RoutesName.orderItemCategoryScreen);
            Get.toNamed(RoutesName.order_item_category_screen);
            getOrderItemCategoryGet(order_details_list[0].orderNo!);

          } else {
            loading.value = false;
            Utils.showErrorToastification('False Message!', response[0].message.toString());
            print(value);
          }
        } else {
          loading.value = false;
          Utils.showErrorToastification('API Response Error!',jsonResponse);
        }
      } catch (e) {
        loading.value = false;
        printError();
        Utils.sanckBarException('Exception Message!', e.toString());
      }
    }).onError((error, stackTrace) {
      print(error);
      loading.value = false;
    }).whenComplete(() {
      loading.value = false;
    },);
  }


  getConsignee(String code){
    print('code......'+code);
    Map data = {
      'name':'',
      'customer_code': code
    };
    print("code.......${data}");
    _api.getConsignee(data, sessionManagement).then((value) {
      print("code.......${data}");
      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<ConsigneeModel> response =
          jsonResponse
              .map((data) => ConsigneeModel.fromJson(data))
              .toList();
          if (response[0].condition == 'True') {
            consignee_list.value = response;
            print(consignee_list);

          } else {
            consignee_list.value = [];
            Utils.sanckBarError('Consignee!', response[0].message.toString());
          }
        } else {
          consignee_list.value = [];
          Utils.sanckBarError('API Error', jsonResponse);
        }
      } catch (e) {
        consignee_list.value = [];
        printError();
      }
    }).onError((error, stackTrace) {
      print(error);
      consignee_list.value = [];
    }).whenComplete(() {
      loading.value = false;
    },);
  }

  void resetAllNewOrderFields(){
    isShowDropDown.value=false;
    isShowCustomerDetails.value = false;

    
   // isShowConsigneeDetails.value = false;
    isCheckBoxChecked.value=false;
   // consignee_name_drop_down_controller.clear();
    selected_customer.value=new CustomersModel();
    customers_controller.clear();
  //  location_center_controller.clear();
    order_expiry_date_controller.clear();
    order_date_controller.clear();
    isShowDropDown.value=true;
    //todo reset all consignee fields...............
   // resetAllConsigneeFields();

  }


}