import 'package:dio/dio.dart';

class DioHelper{
  static Dio? dio;
  static init(){
    dio = Dio(
        BaseOptions(
          baseUrl:'https://newsdata.io/' ,
          receiveDataWhenStatusError: true,
        )
    );
  }
  static Future<Response?>? getData({required String url,Map<String,dynamic>? query,})async{
    return await dio?.get(url,queryParameters: query);
  }

  static Future<Response?>? postData({
    required String url,
    Map<String,dynamic>? query,
    required Map<String,dynamic> data,String? token,String? lang='en'
  })async{
    dio?.options.headers={
      'Content-Type':'application/json',
      'lang':lang,
      'Authorization':token??'',
    };
    return await dio?.post(
        url,
        queryParameters: query,
        data: data
    );
  }

  static Future<Response?>? registerData({
    required String url,
    Map<String,dynamic>? query,
    required Map<String,dynamic> data,
  })async{
    return await dio?.post(
        url,
        queryParameters: query,
        data: data
    );
  }
}

//apiKey: pub_2800687c1f66d0a2114eed03ca86f1a201d5d