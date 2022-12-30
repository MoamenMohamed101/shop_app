// import 'package:flutter/foundation.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// // 1-
// class CacheHelper {
//   static SharedPreferences? sharedPreferences;
//
//   static init() async {
//     sharedPreferences = await SharedPreferences.getInstance();
//   }
//
//   static Future<bool> putBoolean({
//     @required String? key,
//     @required bool? value,
//   }) async {
//     return await sharedPreferences!.setBool(key!, value!);
//   }
//
//   static getBoolean({
//     @required String? key,
//   }) {
//     return sharedPreferences!.getBool(key!);
//   }
// }
