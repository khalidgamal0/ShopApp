import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper{
  static Dio? dio;
  static init(){
    dio=Dio(BaseOptions(
      baseUrl:'https://student.valuxapps.com/api/',
      receiveDataWhenStatusError: true,

    ));
  }
  static Future<Response> getData({
    @required String? method_url,
    Map<String,dynamic>? query,
     String? lang='en',
    @required String? token='',
  })async{
    dio!.options.headers={
      'lang':lang,
      'Content-Type':'application/json',
      'Authorization':token,
    };
   return await dio!.get(method_url!,queryParameters:query);
  }
  static Future<Response> postData({
    @required String? method_url,
    Map<String,dynamic>? query,
    @required Map<String,dynamic>? data,
     String? lang='en',
     String? token='',
  })async{
    dio!.options.headers={
      'lang':'en',
      'Content-Type':'application/json',
      'Authorization':token,
    };
    return await dio!.post(method_url!,data: data,queryParameters:query );
  }
  static Future<Response>PutData({
    @required String?method_url,
    Map<String,dynamic>? query,
    @required Map<String,dynamic>? data,
    String lang='en',
    String? token,
  })async{
    dio!.options.headers={
      'lang':lang,
      'Content-Type':'application/json',
      'Authorization':token??'',
    };
    return dio!.put(
      method_url!,
      queryParameters: query,
      data: data,
    );
  }
}