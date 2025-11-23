import 'dart:convert';

import 'package:dynamic_form/core/shared/app_constant.dart';
import 'package:hive/hive.dart';

class FormRepository {
  static const String boxName = AppConstant.fieldsBox;

  Future<void> saveFields(List<Map<String, dynamic>> fields) async {
    final box = Hive.box(boxName);
    final encoded = jsonEncode(fields);
    await box.put(AppConstant.formData, encoded);
  }

  Future<List<Map<String, dynamic>>?> loadFields() async {
    final box = Hive.box(boxName);
    final encoded = box.get(AppConstant.formData);
    
    if (encoded == null) return null;
    final decoded = jsonDecode(encoded);
    return List<Map<String, dynamic>>.from(decoded);
  }
}
