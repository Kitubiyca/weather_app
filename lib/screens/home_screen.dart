import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/material.dart' hide AnimatedScale;

//import 'package:flutter_neumorphic/flutter_neumorphic.dart' hide AnimatedScale;
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:weather_app/services/data_structures.dart';

import 'forecast.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({Key? key}) : super(key: key);

  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  String _timeString = '';
  ExpansionStatus expStat = ExpansionStatus.contracted;
  City city = City('Санкт-Петербург');
  Day day = Day(DateTime.now(), 0, 0, 0, 0, 0);

  GlobalKey<ExpandableBottomSheetState> key = GlobalKey();

  _MyHomeScreenState createState() => _MyHomeScreenState();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void callback() {
    setState(() {});
  }

  @override
  void initState() {
    _timeString = _formatTime(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserData.callback = (() {
      callback();
    });
    //city = ModalRoute.of(context)!.settings.arguments as City;
    city = UserData.cityData;
    day = UserData.today;
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        key: _scaffoldKey,
        drawer: Drawer(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 60,
            ),
            Text(
              'Weather app',
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                  fontWeight: FontWeight.bold,
                  fontSize: 40),
            ),
            Container(
              height: 30,
            ),
            drawerElement(
                context, 'assets/icons/setting.png', 'Настройки', 'settings'),
            drawerElement(
                context, 'assets/icons/heart.png', 'Избранное', 'favourites'),
            drawerElement(
                context, 'assets/icons/user.png', 'О приложении', 'about'),
          ],
        )),
        body: ExpandableBottomSheet(
          onIsExtendedCallback: () => setState(() {
            expStat = ExpansionStatus.expanded;
          }),
          onIsContractedCallback: () => setState(() {
            expStat = ExpansionStatus.contracted;
          }),
          key: key,
          background: background(context),
          persistentHeader: persistentHeaderExpanded(context),
          //AnimatedSwitcher(
          //duration: const Duration(milliseconds: 300),
          //transitionBuilder: (Widget child, Animation<double> animation) {
          //  return ScaleTransition(child: child, scale: animation);},
          //child:
          //AnimatedCrossFade(
          //  duration: const Duration(milliseconds: 200),
          //  firstChild: persistentHeaderExpanded(context),
          //  secondChild: persistentHeaderContracted(context),
          //  crossFadeState: (expStat == ExpansionStatus.expanded) ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          //),
          expandableContent: expandableContent(context),
        ));
  }

  //((expStat == ExpansionStatus.expanded)
  //? persistentHeaderExpanded(context)
  //    : persistentHeaderContracted(context)),

  Widget drawerElement(
      BuildContext context, String image, String label, String navigate) {
    return SizedBox(
        height: 60,
        child: InkWell(
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Container(
              width: 20,
            ),
            SizedBox(
              height: 30,
              width: 30,
              child: Image.asset(
                image,
                color: Theme.of(context).textTheme.bodyText1!.color,
              ),
            ),
            Container(
              width: 20,
            ),
            Text(
              label,
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                  fontSize: 20),
            ),
          ]),
          onTap: () => {
            Navigator.pushNamed(
              context,
              navigate,
            )
          },
        ));
  }

  Widget background(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: (SettingsVars.theme
                ? AssetImage("assets/images/background-dark.png")
                : AssetImage("assets/images/background.jpg")),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                  SizedBox(
                      height: 40,
                      width: 40,
                      child: NeumorphicButton(
                        onPressed: () =>
                            _scaffoldKey.currentState!.openDrawer(),
                        style: NeumorphicStyle(
                          color: (SettingsVars.theme
                              ? Theme.of(context).primaryColor
                              : Colors.blueAccent),
                          shape: NeumorphicShape.flat,
                          boxShape: NeumorphicBoxShape.circle(),
                        ),
                        padding: const EdgeInsets.all(0),
                        child: const FittedBox(
                            child: Icon(
                          Icons.menu,
                          color: Colors.white,
                        )),
                      )),
                ]),
                Container(
                  width: 30,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AnimatedCrossFade(
                      duration: const Duration(milliseconds: 200),
                      firstChild: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 30,
                          ),
                          Text(
                            city.name,
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          Text(
                              (SettingsVars.temperature
                                  ? (day.temp * 9 / 5 + 32).round().toString() +
                                      '°F'
                                  : day.temp.round().toString() + '°c'),
                              style:
                                  TextStyle(fontSize: 80, color: Colors.white)),
                        ],
                      ),
                      secondChild: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 30,
                          ),
                          Text(
                              (SettingsVars.temperature
                                  ? (day.temp * 9 / 5 + 32).round().toString() +
                                      '°F'
                                  : day.temp.round().toString() + '°c'),
                              style:
                                  TextStyle(fontSize: 80, color: Colors.white)),
                          Text(
                            _timeString,
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ],
                      ),
                      crossFadeState: (expStat == ExpansionStatus.expanded)
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                    ),
                  ],
                ),
                Container(
                  width: 30,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                        height: 40,
                        width: 40,
                        child: NeumorphicButton(
                          onPressed: () => {
                            Navigator.pushNamed(
                              context,
                              'search',
                            )
                          },
                          style: NeumorphicStyle(
                            color: (SettingsVars.theme
                                ? Theme.of(context).primaryColor
                                : Colors.blueAccent),
                            shape: NeumorphicShape.flat,
                            boxShape: NeumorphicBoxShape.circle(),
                          ),
                          padding: const EdgeInsets.all(0),
                          child: const FittedBox(
                              child: Icon(
                            Icons.add_circle_outline,
                            color: Colors.white,
                          )),
                        )),
                  ],
                ),
              ],
            ),
          ],
        ));
  }

  Widget persistentHeaderExpanded(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
      child: Container(
          height: 240,
          color: Theme.of(context).primaryColor,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(
                  height: 5,
                ),
                expandableDash(context),
                const SizedBox(
                  height: 5,
                ),
                Visibility(
                  visible: (expStat == ExpansionStatus.expanded),
                    child: AnimatedCrossFade(
                  duration: const Duration(milliseconds: 200),
                  firstChild: Text(
                    _timeString,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1!.color,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  secondChild: Container(),
                  crossFadeState: (expStat == ExpansionStatus.expanded)
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                )),
                const SizedBox(
                  height: 10,
                ),
                cardsRow(context),
                const SizedBox(
                  height: 10,
                ),
                AnimatedCrossFade(
                  duration: const Duration(milliseconds: 200),
                  firstChild: TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).primaryColor),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    side: BorderSide(
                                        color: (SettingsVars.theme
                                            ? Colors.white
                                            : Colors.blue))))),
                    child: Text('Прогноз на неделю',
                        style: TextStyle(
                          color: (SettingsVars.theme
                              ? Colors.white
                              : Colors.blueAccent),
                          fontSize: 15,
                        )),
                    onPressed: () => {
                      Navigator.pushNamed(context, 'forecast', arguments: city)
                    },
                  ),
                  secondChild: Container(),
                  crossFadeState: (expStat == ExpansionStatus.contracted)
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                ),
                const SizedBox(
                  height: 10,
                ),
              ])),
    );
  }

  Widget persistentHeaderContracted(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
      child: Container(
          height: 240,
          color: Theme.of(context).primaryColor,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(
                  height: 5,
                ),
                expandableDash(context),
                const SizedBox(
                  height: 5,
                ),
                cardsRow(context),
                TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              side: BorderSide(
                                  color: (SettingsVars.theme
                                      ? Colors.white
                                      : Colors.blue))))),
                  child: Text('Прогноз на неделю',
                      style: TextStyle(
                        color: (SettingsVars.theme
                            ? Colors.white
                            : Colors.blueAccent),
                        fontSize: 15,
                      )),
                  onPressed: () => {
                    Navigator.pushNamed(context, 'forecast', arguments: city)
                  },
                ),
                const SizedBox(
                  height: 20,
                )
              ])),
    );
  }

  Widget expandableDash(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: const SizedBox(
          width: 80,
          height: 4,
          child: DecoratedBox(
            decoration: BoxDecoration(color: Colors.blueAccent),
          )),
    );
  }

  Widget expandableContent(BuildContext context) {
    return Container(
      height: 240,
      color: Theme.of(context).primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            expandableCard(
                context,
                'assets/icons/thermometer.png',
                (SettingsVars.temperature
                    ? (day.temp * 9 / 5 + 32).round().toString() + ' °F'
                    : day.temp.round().toString() + ' °c')),
            expandableCard(context, 'assets/icons/humidity.png',
                day.humidity.toString() + ' %'),
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              expandableCard(
                  context,
                  'assets/icons/wind.png',
                  (SettingsVars.wind
                      ? (day.wind * 3.6).round().toString() + ' км/ч'
                      : day.wind.round().toString() + ' м/с')),
              expandableCard(
                  context,
                  'assets/icons/barometer.png',
                  (SettingsVars.pressure
                      ? day.pressure.round().toString() + ' гПа'
                      : (day.pressure * 0.750064).round().toString() +
                          ' мм.рт.ст.')),
            ],
          ),
          Container(
            height: 40,
          )
        ],
      ),
    );
  }

  Widget expandableCard(BuildContext context, String icon, String info) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Neumorphic(
            style: NeumorphicStyle(
                shape: NeumorphicShape.concave,
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                depth: 8,
                lightSource: LightSource.topLeft,
                color: Theme.of(context).primaryColor),
            child: Container(
              height: 80,
              width: 150,
              color: Theme.of(context).primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 30,
                      width: 30,
                      child: Image.asset(icon,
                          color: Theme.of(context).textTheme.bodyText1!.color)),
                  Text(
                    '   ' + info,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Theme.of(context).textTheme.bodyText1!.color,
                    ),
                  )
                ],
              ),
            )));
  }

  Widget cardsRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        //if(mainCity.temps.isEmpty) card(context, '06:00', 'assets/icons/storm.png', '10 C'),
        //if(mainCity.temps.isEmpty) card(context, '12:00', 'assets/icons/sun.png', '12 C'),
        //if(mainCity.temps.isEmpty) card(context, '18:00', 'assets/icons/rainy-day.png', '14 C'),
        //if(mainCity.temps.isEmpty) card(context, '00:00', 'assets/icons/rain.png', '11 C'),
        if (city.temps.isNotEmpty)
          card(
              context,
              city.temps[0].dateTime.toString().substring(11, 16),
              city.temps[0].image,
              (SettingsVars.temperature
                  ? (city.temps[0].temp * 9 / 5 + 32).round().toString() + ' °F'
                  : city.temps[0].temp.round().toString() + ' °c')),
        if (city.temps.isNotEmpty)
          card(
              context,
              city.temps[1].dateTime.toString().substring(11, 16),
              city.temps[1].image,
              (SettingsVars.temperature
                  ? (city.temps[1].temp * 9 / 5 + 32).round().toString() + ' °F'
                  : city.temps[1].temp.round().toString() + ' °c')),
        if (city.temps.isNotEmpty)
          card(
              context,
              city.temps[2].dateTime.toString().substring(11, 16),
              city.temps[2].image,
              (SettingsVars.temperature
                  ? (city.temps[2].temp * 9 / 5 + 32).round().toString() + ' °F'
                  : city.temps[2].temp.round().toString() + ' °c')),
        if (city.temps.isNotEmpty)
          card(
              context,
              city.temps[3].dateTime.toString().substring(11, 16),
              city.temps[3].image,
              (SettingsVars.temperature
                  ? (city.temps[3].temp * 9 / 5 + 32).round().toString() + ' °F'
                  : city.temps[3].temp.round().toString() + ' °c')),
      ],
    );
  }

  Widget card(BuildContext context, String time, String image, String temp) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Neumorphic(
            style: NeumorphicStyle(
                shape: NeumorphicShape.concave,
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                depth: 8,
                lightSource: LightSource.topLeft,
                color: Theme.of(context).primaryColor),
            child: Container(
                height: 115,
                width: 60,
                color: Theme.of(context).primaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).textTheme.bodyText1!.color,
                      ),
                    ),
                    SizedBox(
                        height: 30,
                        width: 30,
                        child: (SettingsVars.theme
                            ? Image.asset(image + '-dark.png')
                            : Image.asset(image + '.png'))),
                    Text(
                      temp,
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).textTheme.bodyText1!.color,
                      ),
                    ),
                  ],
                ))));
  }

  //void status() => expStat = key.currentState?.expansionStatus ?? expStat;

  void _getTime() {
    final String formattedDateTime = _formatTime(DateTime.now());
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  String _formatTime(DateTime datetime) {
    return (datetime.day.toString() +
        " " +
        getMonth(int.parse(datetime.month.toString())) +
        " " +
        datetime.year.toString());
  }
}

String getMonth(int num) {
  switch (num) {
    case 1:
      return "Января";
    case 2:
      return "Февраля";
    case 3:
      return "Марта";
    case 4:
      return "Апреля";
    case 5:
      return "мая";
    case 6:
      return "Июня";
    case 7:
      return "Июля";
    case 8:
      return "Августа";
    case 9:
      return "Сентября";
    case 10:
      return "Октября";
    case 11:
      return "Ноября";
    case 12:
      return "Декабря";
    default:
      return "Января";
  }
}
