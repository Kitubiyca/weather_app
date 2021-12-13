import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:weather_app/screens/about.dart';
import 'package:weather_app/screens/favourites.dart';
import 'package:weather_app/screens/forecast.dart';
import 'package:weather_app/screens/home_screen.dart';
import 'package:weather_app/screens/loading.dart';
import 'package:weather_app/screens/search.dart';
import 'package:weather_app/screens/settings.dart';
import 'package:weather_app/services/data_structures.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
        light: ThemeData(
            primaryColor: Color(0xffdde6f9),
            scaffoldBackgroundColor: const Color(0xffeaf0ff),
            primarySwatch: Colors.blue,
            textTheme: TextTheme(
              bodyText1: TextStyle(
                color: Colors.black,
              ),
              bodyText2: TextStyle(
                color: Color(0xffc8daff),
              ),
              headline4: TextStyle(
                color: Color(0xffdee9ff),
              ),
            )),
        dark: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: TextTheme(
              bodyText1: TextStyle(color: Colors.white),
              bodyText2: TextStyle(color: Color(0xff192d55)),
              headline4: TextStyle(
                color: Color(0xff0d172b),
              )),
          primaryColor: Color(0xff0d172b),
          canvasColor: Color(0xff0d172b),
          brightness: Brightness.dark,
        ),
        initial: AdaptiveThemeMode.light,
        builder: (theme, darkTheme) => MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Weather App',
              theme: theme,
              darkTheme: darkTheme,
              home: const Loading(),
              routes: {
                'homeScreen': (context) => MyHomeScreen(),
                'forecast': (context) => Forecast(),
                'about': (context) => About(),
                'settings': (context) => Settings(),
                'search': (context) => Search(),
                'favourites': (context) => Favourites(),
              },
            ));
  }
}
