import 'dart:io';

abstract class IJsonManager {
  Future<Map<String, dynamic>> readJson();
  Future<void> writeJson(Map<String, dynamic> jsonData);
}
