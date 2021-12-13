import 'package:shared_preferences/shared_preferences.dart';

import 'data_structures.dart';

class SPManager {

  static Future<bool> checkFirstStart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return !prefs.containsKey('themeVar');
  }

  static Future<void> setDateTime(String key, DateTime dateTime) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int timestamp = dateTime.millisecondsSinceEpoch;
    await prefs.setInt(key, timestamp);
  }

  static Future<DateTime> getDateTime(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? timestamp = prefs.getInt(key);
    return DateTime.fromMillisecondsSinceEpoch(timestamp!);
  }

  static Future<void> setUserDataFavourites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favourites', UserData.favourites.toList());
  }

  static Future<void> getUserDataFavourites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserData.favourites = prefs.getStringList('favourites')!.toSet();
  }

  static Future<void> setSettingsTemp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('temperatureVar', SettingsVars.temperature);
  }

  static Future<void> setSettingsWind() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('windVar', SettingsVars.wind);
  }

  static Future<void> setSettingsPressure() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('pressureVar', SettingsVars.pressure);
  }

  static Future<void> setSettingsTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('themeVar', SettingsVars.theme);
  }

  static Future<void> getSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    SettingsVars.temperature = prefs.getBool('temperatureVar')!;
    SettingsVars.wind = prefs.getBool('windVar')!;
    SettingsVars.pressure = prefs.getBool('pressureVar')!;
    SettingsVars.theme = prefs.getBool('themeVar')!;
  }

  static Future<void> setCard(String key, Card card) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, true);
    await SPManager.setDateTime(key + '-datetime', card.dateTime);
    await prefs.setDouble(key + '-temp', card.temp);
    await prefs.setString(key + '-image', card.image);
  }

  static Future<Card> getCard(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(key)) {
      DateTime dateTime = await SPManager.getDateTime(key + '-datetime');
      double? temp = prefs.getDouble(key + '-temp');
      String? image = prefs.getString(key + '-image');
      return Card(dateTime, temp!, image!);
    }
    throw 'No card found';
  }

  static Future<void> setDay(String key, Day day) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, true);
    await SPManager.setDateTime(key + '-datetime', day.date);
    await prefs.setString(key + '-icon', day.icon);
    await prefs.setString(key + '-secondicon', day.secondIcon);
    await prefs.setDouble(key + '-temp', day.temp);
    await prefs.setDouble(key + '-wind', day.wind);
    await prefs.setInt(key + '-humidity', day.humidity);
    await prefs.setInt(key + '-pressure', day.pressure);
  }

  static Future<Day> getDay(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(key)) {
      DateTime dateTime = await SPManager.getDateTime(key + '-datetime');
      String? icon = prefs.getString(key + '-icon');
      String? secondIcon = prefs.getString(key + '-secondicon');
      double? temp = prefs.getDouble(key + '-temp');
      double? wind = prefs.getDouble(key + '-wind');
      int? humidity = prefs.getInt(key + '-humidity');
      int? pressure = prefs.getInt(key + '-pressure');
      return Day.fromMemory(dateTime, icon!, secondIcon!, temp!, wind!, humidity!, pressure!);
    }
    throw 'No day found';
  }

  static Future<void> setCity(String key, City city) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, true);
    await prefs.setInt(key + 'days', city.days.length);
    await prefs.setInt(key + 'cards', city.temps.length);
    await prefs.setString(key+'-name', city.name);
    for(int i = 0; i < city.days.length; i++){
      SPManager.setDay(key + 'day-' + i.toString(), city.days[i]);
    }
    for(int i = 0; i < city.temps.length; i++){
      SPManager.setCard(key + 'card-' + i.toString(), city.temps[i]);
    }
  }

  static Future<City> getCity(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(key)) {
      String? name = prefs.getString(key + '-name');
      int? daysCount = prefs.getInt(key + 'days');
      int? cardsCount = prefs.getInt(key + 'cards');
      City city = City(name!);
      List<Day> days = [];
      for(int i = 0; i < daysCount! ; i++){
        city.addDayFromMemory( await SPManager.getDay(key + 'day-' + i.toString()));
      }
      List<Card> cards = [];
      for(int i = 0; i < cardsCount! ; i++){
        city.addTempFromMemory( await SPManager.getCard(key + 'card-' + i.toString()));
      }
      return city;
    }
    throw 'No city found';
  }

}