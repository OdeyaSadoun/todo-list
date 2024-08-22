import 'dart:convert';
import 'dart:io';
import '../../../infrastructures/interfaces/i_json_manager.dart';

class JsonManager implements IJsonManager {
    final Directory directory = Directory.current;

  @override
  Future<Map<String, dynamic>> readJson(String path) async {
    try {
      final currentDirectory = "${directory.path}\\assets\\$path";
      final file = File(currentDirectory);

      final jsonData = await file.readAsString();
      return json.decode(jsonData) as Map<String, dynamic>;
    } catch (e) {
      throw Exception("Error reading JSON from $path");
    }
  }

  @override
  Future<void> writeJson(String path, Map<String, dynamic> data) async {
    try {
      final currentDirectory = "${directory.path}\\assets\\$path";
      final file = File(currentDirectory);
      await file.writeAsString(json.encode(data));
    } catch (e) {
      throw Exception("Error writing JSON to $path");
    }
  }
}
