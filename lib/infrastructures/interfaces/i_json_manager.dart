abstract class IJsonManager {
  Future<Map<String, dynamic>> readJson(String path);
  Future<void> writeJson(String path, Map<String, dynamic> jsonData);
}
