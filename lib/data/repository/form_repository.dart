import 'dart:convert';

import 'package:hive/hive.dart';

class FormRepository {
  static const String boxName = 'fields';

  Future<void> saveFields(List<Map<String, dynamic>> fields) async {
    final box = Hive.box(boxName);
    final encoded = jsonEncode(fields);
    await box.put('form_data', encoded);
  }

  Future<List<Map<String, dynamic>>?> loadFields() async {
    final box = Hive.box(boxName);
    final encoded = box.get('form_data');
    if (encoded == null) return null;
    final decoded = jsonDecode(encoded);
    return List<Map<String, dynamic>>.from(decoded);
  }
}
