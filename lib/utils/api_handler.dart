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
      // print('Response body -> ${response.body}');
      final List<dynamic> jsonData = json.decode(response.body);

      // print('Response body -> ${jsonData}');
      List<ResponseBody> quizDataList = jsonData.map((data) {
        // print('Response body data -> ${data}');
        return ResponseBody.fromJson(data);
      }).toList();

      print('Response body -> ${quizDataList.length}');

      print('Response body -> ${quizDataList}');
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
