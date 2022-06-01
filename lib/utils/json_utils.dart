import 'dart:convert';

import 'package:dio/dio.dart';

class JsonUtils {
  static Map<String, dynamic> getMap(dynamic data) {
    try {
      if (data != null) {
        if (data is ResponseBody) return {'value': data.statusMessage};
        if (data is Map) return data as Map<String, dynamic>;
        final decoded = jsonDecode(data.toString());
        if (decoded is Map) return decoded as Map<String, dynamic>;
        return {'value': decoded};
      }
    } catch (e) {
      print('JsonUtils: ${e.toString()}');
    }
    return {};
  }

  static List<Map<String, dynamic>> getMapList(dynamic data) {
    final List<Map<String, dynamic>> mapList = [];
    if (data == null) return mapList;

    try {
      if (data is! List) {
        data = jsonDecode(data.toString()) as List<dynamic>;
      }
      data.forEach((data) {
        final element = getMap(data);
        mapList.add(element);
      });
    } catch (e) {
      print('JsonUtils: ${e.toString()}');
    }

    return mapList;
  }
}
