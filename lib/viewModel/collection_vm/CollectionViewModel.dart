import 'dart:convert';

import 'package:get/get.dart';
import 'package:navigation_drawer_flutter/network/network_api_service.dart';
import 'package:navigation_drawer_flutter/repository/collection_repository/collection_repository.dart';
import 'package:navigation_drawer_flutter/utils/app_utils.dart';

import '../../models/collectioModel/collection_model.dart';
import '../SessionManagment/session_managment.dart';

class CollectionViewModel extends GetxController{
  final _api=CollectionRepository();
SessionManagement sessionManagement= SessionManagement();
  RxList<CollectionModel> collection_list=<CollectionModel>[].obs;
  RxBool isLoading=false.obs;
  String email='';
  String title='';


  @override
  void onInit()  async {
    email=await sessionManagement.getName() ?? '';
    title=await sessionManagement.getCountry() ?? '';
    print('emiallll........${email}');
    print('emiallll........${title}');
   getCollectionList();
  }

  getCollectionList(){
    Map<String, String> data={
      'email':email
    };
    _api.getCollectionApiHit(data, sessionManagement).then((value) {
      isLoading.value=true;
      print(value);
      try{
        final jsnResponse=json.decode(value);
        if(jsnResponse is List){
          List<CollectionModel> respnose=jsnResponse.map((e) => CollectionModel.fromJson(e)).toList();
          if(respnose!=null && respnose[0].condition=='True'){

            isLoading.value=false;
            print("Success");
            Utils.sanckBarSuccess('Success', respnose[0].message.toString());
            collection_list.value=respnose;
            print('list........${respnose.length}');
            print('List Size...........${ collection_list.value.length}');

          } else{
            isLoading.value=false;
            Utils.sanckBarError('Error', respnose[0].message.toString());

          }
        }
      }catch(e){
        print(e);
      }finally{
        //isLoading.value=false;
      }

    },).onError((error, stackTrace) {
       print(error);
       Utils.sanckBarError('Api Error', error.toString());

    },);











  }


  
  
  
}