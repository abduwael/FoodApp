import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init()
  {
    dio = Dio(
      BaseOptions(
          baseUrl: 'http://mvs.bslmeiyu.com/api/', //https://demo.crossworkers.com/api
          receiveDataWhenStatusError: true,

        ),
    );
  }

   static  Future<Response> getData(
      {required String url,
         Map<String, dynamic>? query,
        String lang='en',
        String? token,
      }
        )
  async {
    dio.options.headers=
    {
      'Content-Type': 'application/json',
      'lang':lang,
      'Authorization':'Bearer $token',
    };
    return await dio.get(url, queryParameters: query,);
  }

  static Future<Response> postData(
      {
        required String path,
        String ? token,

      Map<String, dynamic>? query,
      required Map<String, dynamic> data})
  async {
    dio.options.headers={
      'lang':'en',
      'Authorization':'Bearer $token',
      'Content-Type': 'application/json',
    };
    return await dio.post(path, queryParameters: query, data: data);
  }

  static Future<Response> putData(
      {
        required String path,
        String ? token,
        Map<String, dynamic>? query,
        required Map<String, dynamic> data})
  async {
    dio.options.headers={
      'lang':'en',
      'Authorization':token,
      'Content-Type': 'application/json',
    };
    return await dio.put(path, queryParameters: query, data: data);
  }
}

//base url /https://newsapi.org/v2/everything?
// method or path v2/everything?
// query q=tesla&from=2021-07-15&sortBy=publishedAt&apiKey=53bca7e5758746c6b9a88e61fc287514
