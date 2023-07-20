import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../api_requests/base_request/request_model.dart';

class ApiServicesGet {
  String releaseUrl = "https://deezerdevs-deezer.p.rapidapi.com";
  String baseUrl = '';
  String serverApiUrl = '';

  RequestModel? requestModel;

  var dio = Dio();

  ApiServicesGet() {
    baseUrl = releaseUrl;
    serverApiUrl = '$baseUrl/';
    interceptorInit();
  }

  void interceptorInit() {
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      if (requestModel != null) {
        if (requestModel?.showLoading == true) {
          EasyLoading.show(status: 'loading...');
        }
      }
      return handler.next(options);
    }, onResponse: (response, handler) async {
      if (requestModel != null) {
        if (requestModel?.showLoading == true) {
          EasyLoading.dismiss();
        }
      }
      return handler.next(response);
    }, onError: (DioError e, handler) {
      print('API ERROR: ${e.toString()}');
      return handler.next(e);
    }));
  }

  Future<Options> _baseOptions() async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'X-RapidAPI-Key': 'dc2fc4d8f5mshcc29f8e3e1695cdp17b386jsnfc0bffc8b1a0',
      'X-RapidAPI-Host': 'deezerdevs-deezer.p.rapidapi.com'
    };
    return Options(
      validateStatus: (status) => true,
      headers: headers,
      sendTimeout: const Duration(seconds: 3), // 3s
      receiveTimeout: const Duration(seconds: 3), //3s
    );
  }

  Future<dynamic> request(String url) async {
    return await _requestGet(url);
  }

  Future<dynamic> _requestGet(String url) async {
    var response = await dio.get(
      url,
      options: await _baseOptions(),
    );
    final apiResponse = response.data;
    return apiResponse;
  }
}
