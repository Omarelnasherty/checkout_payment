import 'package:dio/dio.dart';

class ApiService {
  final Dio dio = Dio();

  Future<Response> post({
    required dynamic body,
    required String url,
    required String token,
    String? contentType,
    required Map<String, String> headers,
  }) async {
    final combinedHeaders = {
      'Authorization': "Bearer $token",
      if (headers.isNotEmpty) ...headers,
    };

    var response = await dio.post(
      url,
      data: body,
      options: Options(contentType: contentType, headers: combinedHeaders),
    );
    return response;
  }
}
