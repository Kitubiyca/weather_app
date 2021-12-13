import 'dart:typed_data';

import 'package:flutter/material.dart';

class UserData{

  static Set<String> favourites = {};
  static City cityData = City('Санкт-Петербург');
  static Day today = Day(DateTime.now(),0,0,0,0,0);
  static Function callback = ((){});
}

class SettingsVars{

  static bool temperature = false;
  static bool wind = false;
  static bool pressure = false;
  static bool theme = false;

  static bool intToBool(int i){
    return ( i > 0 ? true : false);
  }

  static int boolToInt(bool b){
    return ( b ? 1 : 0);
  }

}

class Day {

  DateTime date;
  String icon = 'assets/icons/question-mark';
  String secondIcon = 'assets/icons/question-mark';
  double temp;
  double wind;
  int humidity;
  int pressure;

  Day(this.date, this.temp, this.wind, this.humidity, this.pressure, int id){
    icon = getIcon(id);
    secondIcon = getSecondIcon(id);
  }

  Day.fromMemory(this.date, this.icon, this.secondIcon, this.temp, this.wind, this.humidity, this.pressure);

  static String getIcon(int id){
    if ((200<=id)&&(id<=233)) return 'assets/icons/storm'; //thunderstorm
    if ((300<=id)&&(id<=321)) return 'assets/icons/rainy-day'; //drizzle
    if ((500<=id)&&(id<=531)) return 'assets/icons/rain';
    if ((600<=id)&&(id<=622)) return 'assets/icons/snow';
    if ((800==id)) return 'assets/icons/sun'; //clear
    if ((801<=id)&&(id<=804)) {
      return 'assets/icons/clouds';
    } else {
      return 'assets/icons/question-mark'; //atmosphere
    }
  }

  static String getSecondIcon(int id){
    if ((200<=id)&&(id<=233)) return 'assets/icons/second/storm.png'; //thunderstorm
    if ((300<=id)&&(id<=321)) return 'assets/icons/second/rain.png'; //drizzle
    if ((500<=id)&&(id<=531)) return 'assets/icons/second/rain.png';
    if ((600<=id)&&(id<=622)) return 'assets/icons/second/snow.png';
    if ((800==id)) return 'assets/icons/second/sun.png'; //clear
    if ((801<=id)&&(id<=804)) {
      return 'assets/icons/second/clouds.png';
    } else {
      return 'assets/icons/question-mark.png'; //atmosphere
    }
  }

}

class City {

  String name = 'Санкт-Петербург';
  List<Day> days = [];
  List<Card> temps = [];

  City(this.name);

  void addDay(DateTime date, double temp, double wind, int humidity, int pressure, int id){
    days.add(Day(date, temp, wind, humidity, pressure, id));
  }

  void addDayFromMemory(Day day){
    days.add(day);
  }

  void addTempFromMemory(Card temp){
    temps.add(temp);
  }

  void addTemp(DateTime date, double temp, int code){
    //Map<int, String> buff = {temp: Day.getIcon(code)};
    //temps[date] = buff;
    temps.add(Card(date, temp, Day.getIcon(code)));
  }

}

class Card{

  DateTime dateTime;
  double temp;
  String image;

  Card(this.dateTime, this.temp, this.image);

}