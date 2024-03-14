import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class WatchListService {
  static const String _watchListKey = 'watchList';

  static Future<void> addToWatchList(String item) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> watchList = prefs.getStringList(_watchListKey) ?? [];
    if (!watchList.contains(item)) {
      watchList.add(item);
      await prefs.setStringList(_watchListKey, watchList);
    }
  }

  static Future<void> removeFromWatchList(int itemId) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> watchList = prefs.getStringList(_watchListKey) ?? [];
    watchList.removeWhere((item) {
      var decodedItem = jsonDecode(item);
      return decodedItem['id'] == itemId;
    });
    await prefs.setStringList(_watchListKey, watchList);
  }

  static Future<List<String>> getWatchList() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_watchListKey) ?? [];
  }
}
