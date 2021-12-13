import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart' hide AnimatedScale;
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/services/data_structures.dart';
import 'package:weather_app/services/manager.dart';
import 'home_screen.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  Future<void> loadApp(BuildContext context) async {
    if (await SPManager.checkFirstStart()) {
      try {
        await firstStart();
      } catch (e) {
        SystemNavigator.pop();
      }
    } else {
      try {
        await routineStart();
      } catch (e) {
        await memoryStart();
      }
    }
    Navigator.pushReplacementNamed(context, 'homeScreen');
  }

  @override
  Widget build(BuildContext context) {
    loadApp(context);
    return const Scaffold(body: SpinKitRing(color: Colors.blueAccent));
  }

  static Future<void> reloadData(String city) async {
    UserData.today = await getTodayData(city);
    UserData.cityData = await getWeekData(city);
    UserData.callback();
    SPManager.setDay('today', UserData.today);
    SPManager.setCity('target', UserData.cityData);
  }

  static Future<void> firstStart() async {
    await reloadData(UserData.cityData.name);
    await SPManager.setSettingsTemp();
    await SPManager.setSettingsWind();
    await SPManager.setSettingsPressure();
    await SPManager.setSettingsTheme();
    await SPManager.setUserDataFavourites();
  }

  static Future<void> routineStart() async {
    await memoryStart();
    await reloadData(UserData.cityData.name);
  }

  static Future<void> memoryStart() async {
    await SPManager.getSettings();
    await SPManager.getUserDataFavourites();
    UserData.today = await SPManager.getDay('today');
    UserData.cityData = await SPManager.getCity('target');
  }

  static Future<Day> getTodayData(String cityName) async {
    http.Response response = await http.get(Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?q=$cityName&units=metric&appid=72ea4c6881129f633de5a03d4e465b66'));
    Map data = jsonDecode(response.body);

    double temp = 0;
    if (data['main']['temp'] is double) {
      temp = data['main']['temp'];
    } else {
      temp = data['main']['temp'].toDouble();
    }

    double wind = 0;
    if (data['wind']['speed'] is double) {
      wind = data['wind']['speed'];
    } else {
      wind = data['wind']['speed'].toDouble();
    }
    return Day(
        DateTime.parse(data['dt'].toString()),
        temp,
        wind,
        data['main']['humidity'],
        data['main']['pressure'],
        data['weather'][0]['id']);
  }

  static Future<City> getWeekData(String cityName) async {
    http.Response response = await http.get(Uri.parse(
        'http://api.openweathermap.org/data/2.5/forecast?q=$cityName&appid=72ea4c6881129f633de5a03d4e465b66&units=metric'));
    Map data = jsonDecode(response.body);
    List weatherData = data['list'];
    String buff = weatherData[0]['dt_txt'].toString().substring(11, 16);
    int counter = 1;
    if ((buff == '00:00') ||
        (buff == '06:00') ||
        (buff == '12:00') ||
        (buff == '18:00')) counter = 2;
    City city = City(cityName);
    while (counter < 40) {
      double temp = 0;
      if (weatherData[counter]['main']['temp'] is double) {
        temp = weatherData[counter]['main']['temp'];
      } else {
        temp = weatherData[counter]['main']['temp'].toDouble();
      }
      city.addTemp(DateTime.parse(weatherData[counter]['dt_txt']), temp,
          weatherData[counter]['weather'][0]['id']);
      counter += 2;
    }
    int check = 4;
    if (buff == '12:00') check = 3;
    counter = 1;
    while (counter < 40) {
      if (weatherData[counter]['dt_txt'].toString().substring(11, 16) ==
          '12:00') {
        double temp = 0;
        if (weatherData[counter]['main']['temp'] is double) {
          temp = weatherData[counter]['main']['temp'];
        } else {
          temp = weatherData[counter]['main']['temp'].toDouble();
        }
        double wind = 0;
        if (weatherData[counter]['wind']['speed'] is double) {
          wind = weatherData[counter]['wind']['speed'];
        } else {
          wind = weatherData[counter]['wind']['speed'].toDouble();
        }
        city.addDay(
            DateTime.parse(weatherData[counter]['dt_txt']),
            temp,
            wind,
            weatherData[counter]['main']['humidity'],
            weatherData[counter]['main']['pressure'],
            weatherData[counter]['weather'][0]['id']);
        break;
      }
      counter++;
    }
    while (check > 0) {
      counter += 8;
      double temp = 0;
      if (weatherData[counter]['main']['temp'] is double) {
        temp = weatherData[counter]['main']['temp'];
      } else {
        temp = weatherData[counter]['main']['temp'].toDouble();
      }
      double wind = 0;
      if (weatherData[counter]['wind']['speed'] is double) {
        wind = weatherData[counter]['wind']['speed'];
      } else {
        wind = weatherData[counter]['wind']['speed'].toDouble();
      }
      city.addDay(
          DateTime.parse(weatherData[counter]['dt_txt']),
          temp,
          wind,
          weatherData[counter]['main']['humidity'],
          weatherData[counter]['main']['pressure'],
          weatherData[counter]['weather'][0]['id']);
      check--;
    }
    return city;
  }
}
