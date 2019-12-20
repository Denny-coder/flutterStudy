import 'package:dio/dio.dart';
import 'dart:convert';

class DioUtils {
  static DioUtils _singleton;

  static DioUtils get instance => DioUtils();
  static final DioUtils dioUtil = DioUtils._internal();
  static Dio _dio;

  factory DioUtils() {
    if (_singleton == null) {
      _singleton = DioUtils._internal();
    }
    return _singleton;
  }
  DioUtils._internal() {
    var options = BaseOptions(
      connectTimeout: 15000,
      receiveTimeout: 15000,
      responseType: ResponseType.plain,
      validateStatus: (status) {
        // 不使用http状态码判断状态，使用AdapterInterceptor来处理（适用于标准REST风格）
        return true;
      },
      headers: {
        'token': 'crm:wecat:token0000Fu',
        'content-type': 'application/json'
      },
      baseUrl: "https://test.aiwoke.com.cn/",
    );
    _dio = Dio(options);
  }
  // 数据返回格式统一，统一处理异常
  Future _request<T>(String method, String url,
      {dynamic data,
      Map<String, dynamic> queryParameters,
      CancelToken cancelToken,
      Options options}) async {
    var response = await _dio.request(url,
        data: data,
        queryParameters: queryParameters,
        options: _checkOptions(method, options),
        cancelToken: cancelToken);
    try {
      /// 集成测试无法使用 isolate
      Map<String, dynamic> _map = parseData(response.data.toString());
      return _map;
    } catch (e) {
      print(e);
      return "数据解析错误";
    }
  }

  Options _checkOptions(method, options) {
    if (options == null) {
      options = new Options();
    }
    options.method = method;
    return options;
  }

  Future requestNetwork<T>(Method method, String url,
      {Function(T t) onSuccess,
      Function(Map<String, dynamic>) onSuccessList,
      Function(int code, String msg) onError,
      dynamic params,
      Map<String, dynamic> queryParameters,
      CancelToken cancelToken,
      Options options,
      bool isList: false}) async {
    String m = _getRequestMethod(method);
    return await _request<T>(m, url,
            data: params,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken)
        .then((result) {
      if (result['status'] == 0) {
        if (isList) {
          if (onSuccessList != null) {
            onSuccessList(result);
          }
        } else {
          if (onSuccess != null) {
            onSuccess(result);
          }
        }
      } else {
        _onError(result['code'], result['msg'], onError);
      }
    }, onError: (e, _) {
      _cancelLogPrint(e, url);
      print(e);
      // NetError error = ExceptionHandle.handleException(e);
      // _onError(error.code, error.msg, onError);
    });
  }

  _cancelLogPrint(dynamic e, String url) {
    if (e is DioError && CancelToken.isCancel(e)) {
      print("取消请求接口： $url");
    }
  }

  _onError(int code, String msg, Function(int code, String mag) onError) {
    if (code == null) {
      msg = "未知异常";
    }
    print("接口请求异常： code: $code, mag: $msg");
    if (onError != null) {
      onError(code, msg);
    }
  }

  String _getRequestMethod(Method method) {
    String m;
    switch (method) {
      case Method.get:
        m = "GET";
        break;
      case Method.post:
        m = "POST";
        break;
      case Method.put:
        m = "PUT";
        break;
      case Method.patch:
        m = "PATCH";
        break;
      case Method.delete:
        m = "DELETE";
        break;
      case Method.head:
        m = "HEAD";
        break;
    }
    return m;
  }
}

Map<String, dynamic> parseData(String data) {
  return json.decode(data);
}

enum Method { get, post, put, patch, delete, head }
