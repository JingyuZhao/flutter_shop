import 'package:dio/dio.dart';
import 'package:flutter_shop/config/service_url.dart';
import 'dart:io';
import 'dart:async';

/**
 * 首页数据
 */
Future getHomePageContent() async {
  try {
    print('开始获取首页数据...............');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType = "application/x-www-form-urlencoded";
    var formData = {'lon': '121.42184448242188', 'lat': '31.200902938842773'};
    response = await dio.post(servicePath['homePageContent'], data: formData);
    if (response.statusCode == 200) {
      print(response.data);
      return response.data;
    } else {
      throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
    }
  } catch (e) {
    return print('ERROR:======>${e}');
  }
}

/**
 * 通用网络请求，post请求
 */
Future postRequest(String url, {var paramter}) async {
  try {
    print("开始上拉加载数据");
    Response response;
    Dio dio = new Dio();
    dio.options.contentType = "application/x-www-form-urlencoded";
    if (paramter == null) {
      response = await dio.post(servicePath[url]);
    } else {
      response = await dio.post(servicePath[url], data: paramter);
    }
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
    }
  } catch (e) {
    return print('Error ==========>$e');
  }
}

/**
 * 通用网络请求,get请求
 */
Future getRequest(String url, {var paramter}) async {
  try {
    print("开始上拉加载数据");
    Response response;
    Dio dio = new Dio();
    dio.options.contentType = "application/x-www-form-urlencoded";
    if (paramter == null) {
      response = await dio.get(servicePath[url]);
    } else {
      response = await dio.get(servicePath[url], queryParameters: paramter);
    }
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
    }
  } catch (e) {
    return print('Error ==========>$e');
  }
}
