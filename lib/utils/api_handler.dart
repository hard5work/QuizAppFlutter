import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quiz_app_flutter/models/response_body.dart';
import 'package:quiz_app_flutter/utils/string_constant.dart';

Future<List<ResponseBody>> fetchDataWithHeaders() async {
  Map<String, String> headers = {
    'content-type': 'application/json',
    'X-Api-Key': StringConstant.api_key
  };

  try {
    final response = await http.get(
      Uri.parse(StringConstant.base_url + StringConstant.get_questions),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);

      List<ResponseBody> quizDataList = jsonData.map((data) {
        return ResponseBody.fromJson(data);
      }).toList();
      return quizDataList;
    } else {
      print('Response error :-> ${response.body}');
      print('Response error :-> ${response.statusCode}');
      return [];
    }
  } catch (e) {
    print('Exception $e');
    return [];
  }
}
