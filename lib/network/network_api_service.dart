import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import '../reources/routes/routes_name.dart';
import '../viewModel/SessionManagment/session_managment.dart';
import 'base_api_service.dart';

class NetworkApiServices<T> extends BaseApiServices {
  @override
  Future<String> getApi(String url,SessionManagement sessionManagement,Map<String, String> queryParams) async {
    if (kDebugMode) {
      print(url);
    }
    var token = await sessionManagement.getAuthToken();
    var request_host_name = await sessionManagement.getRequestHostName();
    var company_id = await sessionManagement.getCompanyId();

    if(queryParams!=null && queryParams.length>0){
      String queryString = Uri(queryParameters: queryParams).query;
      url= url + '?' + queryString;
    }

    Map<String, String> headers ={
      'Content-Type': 'application/json; charset=UTF-8',
    };
    if (token != null && token != "") {
      headers.addAll({"Authorization": token});
    }
    if (request_host_name != null && request_host_name != "") {
      headers.addAll({"request_host_name": request_host_name});
    }
    if (company_id != null && company_id != "") {
      headers.addAll({"company_id": company_id});
    }
    var response = await http.get(
        Uri.parse(url),
        headers: headers
    ).timeout(Duration(seconds: 60));
    print(response);
    String reply = response.body.toString();
    if (response.statusCode != 200) {
      if(response.statusCode == 401)
        {
          sessionManagement.clearSession();
          Get.offAllNamed(RoutesName.splashscreen);
          print("Unauthorized");
        }
      throw Exception("Api Error [ Status Code :" +
          response.statusCode.toString() +
          " Response :" +
          reply +
          " ]");
    }
    return reply;

  }

  @override
  Future<String> postApi(var data, String url, SessionManagement sessionManagement) async {
    if (kDebugMode) {
      print(url);
      print(data);
    }
    var token = await sessionManagement.getAuthToken();
    var request_host_name = await sessionManagement.getRequestHostName();
    var company_id = await sessionManagement.getCompanyId();
    String adminCheck = await sessionManagement.getIsAdminPermission() ?? '';
    print(token);
    Map<String, String> headers ={
      'Content-Type': 'application/json; charset=UTF-8',
    };
    if (token != null && token != "") {
      headers.addAll({"Authorization": token});
    }
    if (request_host_name != null && request_host_name != "") {
      headers.addAll({"request_host_name": request_host_name});
    }
    if (company_id != null && company_id != "") {
      headers.addAll({"company_id": company_id});
    }
    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: utf8.encode(jsonEncode(data)),
    ).timeout(Duration(seconds: adminCheck=="1"?180:60));
    print(response);
    String reply = response.body.toString();
    if (response.statusCode != 200) {
      if(response.statusCode == 401)
      {
        sessionManagement.clearSession();
        Get.offAllNamed(RoutesName.splashscreen);
        print("Unauthorized");
      }
      throw Exception("Api Error [ Status Code :" +
          response.statusCode.toString() +
          " Response :" +
          reply +
          " ]");
    }
    return reply;

    // HttpClient client = new HttpClient();
    // client.badCertificateCallback =
    // ((X509Certificate cert, String host, int port) => true);
    // client.connectionTimeout= const Duration(seconds: 60);
    // HttpClientRequest request = await client.postUrl(Uri.parse(url));
    // request.headers.add("Content-Type", "application/json");
    // if (token != null && token != "") {
    //   request.headers.add("Authorization", token);
    // }
    // if (request_host_name != null && request_host_name != "") {
    //   request.headers.add("request_host_name", request_host_name);
    // }
    // if (company_id != null && company_id != "") {
    //   request.headers.add("company_id", company_id);
    // }
    //
    //
    // request.add(utf8.encode(jsonEncode(data)));
    // HttpClientResponse response = await request.close();
    // String reply = await response.transform(utf8.decoder).join();
    // if (response.statusCode != 200) {
    //   throw Exception("Api Error [ Status Code :" +
    //       response.statusCode.toString() +
    //       " Response :" +
    //       reply +
    //       " ]");
    // }
    // return reply;
  }


  @override
  Future<String> postFormApiHttpClient(http.MultipartRequest clint_request,
      SessionManagement sessionManagement) async {
    if (kDebugMode) {
      print(clint_request);
      print(clint_request.fields);
    }
    Map<String, String>? headers = Map();
    headers.addAll({"Content-Type": 'application/json'});
    var token = await sessionManagement.getAuthToken();
    if (token != null && token != "") {
      print(token);
      headers.addAll({"Authorization": token});
    }
    var request_host_name = await sessionManagement.getRequestHostName();
    if (request_host_name != null && request_host_name != "") {
      headers.addAll({"request_host_name": request_host_name});
    }
    var company_id = await sessionManagement.getCompanyId();
    if (company_id != null && company_id != "") {
      headers.addAll({"company_id": company_id});
    }

    clint_request.headers.addAll(headers);

    http.StreamedResponse streamedResponse=await clint_request.send().timeout(Duration(seconds: 60));
    String reply = await streamedResponse.stream.bytesToString();
    if (streamedResponse.statusCode != 200) {
      if(streamedResponse.statusCode == 401)
      {
        sessionManagement.clearSession();
        Get.offAllNamed(RoutesName.splashscreen);
        print("Unauthorized");
      }
      throw Exception("Api Error [ Status Code :" +
          streamedResponse.statusCode.toString() +
          " Response :" +
          reply +
          " ]");
    }

    return reply;

  }
}