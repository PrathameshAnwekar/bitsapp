// import 'package:shared_preferences/shared_preferences.dart';

// class SharedPrefs {
//   static SharedPreferences? prefs;

//   static Future init() async => prefs = await SharedPreferences.getInstance();

//   static  setBool(String key, bool value) async {
//     await prefs!.setBool(key, value);
//   }

//   static  setString(String key, String value) async {
//     await prefs!.setString(key, value);
//   }

//  static getBool(String key) {
//     return prefs!.getBool(key);
//   }

//   static  getString(String key) {
//     return prefs!.getString(key);
//   }

//   static  setInt(String key, int value) async {
//     await prefs!.setInt(key, value);
//   }

//   static getInt(String key) {
//     return prefs!.getInt(key) ;
//   }
  
// }