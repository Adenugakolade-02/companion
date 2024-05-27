import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class StorageService{
  static const storage =  FlutterSecureStorage();

  Future<String?> getToken(String key) async{
    return await storage.read(key: key);
  }
  void storeToken(String key, String value) async{
    await storage.write(key: key, value: value);
  }
  void clearToken(String key) async{
    await storage.delete(key: key);
  }
}