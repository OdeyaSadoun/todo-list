import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../../../infrastructures/interfaces/i_json_manager.dart';

class JsonManager implements IJsonManager {
  final String fileName;

  JsonManager({required this.fileName});

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$fileName');
  }

  @override
  Future<Map<String, dynamic>> readJson() async {
    try {
      final file = await _getFile();

      if (!file.existsSync()) {
        return {};
      }

      final jsonString = await file.readAsString();
      return json.decode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Error reading JSON file: $e');
    }
  }

  @override
  Future<void> writeJson(Map<String, dynamic> jsonData) async {
    try {
      final file = await _getFile();
      final jsonString = json.encode(jsonData);
      await file.writeAsString(jsonString);
    } catch (e) {
      throw Exception('Error writing to JSON file: $e');
    }
  }
}
