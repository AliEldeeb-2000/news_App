import 'package:shared_preferences/shared_preferences.dart';

class CashedHelper{
  static late SharedPreferences _sharedPreferences;

  static init() async{
    _sharedPreferences = await SharedPreferences.getInstance();
  }
  
  static Future putData({required String key , required bool value}) async{
    await _sharedPreferences.setBool(key, value);
  }


  static getData({required String key }) {
    _sharedPreferences.getBool(key);
  }



}