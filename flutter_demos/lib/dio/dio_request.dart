import 'package:dio/dio.dart';

class DioRequest {
  static final dio = Dio();

  static void setUp() {
    InterceptorsWrapper interceptor = InterceptorsWrapper(onRequest: (options, handler) {
      // 在请求被发送之前做一些处理，比如添加通用的请求头
      options.headers['Authorization'] = 'Bearer your_token';
      print('---->请求被发送: ${options.uri}');
      handler.next(options);
    }, onResponse: (response, handler) {
      // 在响应被接收之前做一些处理
      print('---->响应数据: ${response.data}');
      handler.next(response);
    }, onError: (error, handler) {
      print('---->请求错误: ${error.message}');
      handler.next(error);
    });

    InterceptorsWrapper loadingInterceptor = InterceptorsWrapper(onRequest: (options, handler) {
      // 在请求被发送之前做一些处理，比如添加通用的请求头
      options.headers['Authorization'] = 'Bearer your_token';
      print('----> Loading请求被发送: ${options.uri}');
      handler.next(options);
    }, onResponse: (response, handler) {
      // 在响应被接收之前做一些处理
      print('----> Loading 响应数据: ${response.data}');
      handler.next(response);
    }, onError: (error, handler) {
      print('----> Loading 请求错误: ${error.message}');
      handler.next(error);
    });
    dio.interceptors.add(loadingInterceptor);
    dio.interceptors.add(interceptor);
  }

  static void request() async {
    try {
      final response = await dio.get('https://jsonplaceholder.typicode.com/posts');
      print(response.data);
    } catch (e) {
      print('请求异常: $e');
    }
  }
}
