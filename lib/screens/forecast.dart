import 'package:flutter/material.dart';
import 'package:storyswiper/storyswiper.dart';
import 'package:weather_app/services/data_structures.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'home_screen.dart';

class Days{
  int day = 1;
  int month = 1;
  int temperature = 0;
  int wind = 0;
  int humidity = 0;
  int pressure = 0;
}

class Forecast extends StatefulWidget {
  const Forecast({Key? key}) : super(key: key);

  @override
  _ForecastState createState() => _ForecastState();
}

class _ForecastState extends State<Forecast> {
  City city = City('london');

  @override
  Widget build(BuildContext context) {
    city = ModalRoute.of(context)!.settings.arguments as City;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Container(
          height: 40,
        ),
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("Прогноз на неделю", style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color, fontSize: 30, fontWeight: FontWeight.bold),)
          ],
        ),
        SizedBox(
          height: 450,
          child: StorySwiper.builder(
            itemCount: city.days.length,
            aspectRatio: 4 / 5,
            depthFactor: 0.2,
            dx: 60,
            dy: 20,
            paddingStart: 32,
            verticalPadding: 32,
            visiblePageCount: 3,
            widgetBuilder: (index) {
              return Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 10,),
                        Text(city.days[index].date.toString().substring(8, 10) + ' ' + getMonth(int.parse(city.days[index].date.toString().substring(5, 7))),
                        style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color, fontSize: 24, fontWeight: FontWeight.bold)),
                      ]
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 10,),
                        SizedBox(height: 110, width: 150, child: Image.asset(city.days[index].secondIcon)),
                      ],
                    ),
                    createInnerCard((SettingsVars.temperature ? (city.days[index].temp*9/5+32).round().toString() : city.days[index].temp.round().toString()), (SettingsVars.temperature ? '°F' : '°c'), 'assets/icons/thermometer.png'),
                    createInnerCard((SettingsVars.wind ? (city.days[index].wind*3.6).round().toString() : city.days[index].wind.round().toString()), (SettingsVars.wind ? ' км/ч' : 'м/с'), 'assets/icons/wind.png'),
                    createInnerCard(city.days[index].humidity.round().toString(), '%', 'assets/icons/humidity.png'),
                    createInnerCard((SettingsVars.pressure ? city.days[index].pressure.round().toString() : (city.days[index].pressure * 0.750064).round().toString()), (SettingsVars.pressure ? ' гПа' : 'мм.рт.ст'), 'assets/icons/barometer.png'),
                  ],
                ),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.4, 1],
                        colors: (SettingsVars.theme ? [Color(0xff223a6e), Color(0xff102042)] : [Color(0xffcddaf5), Color(0xff9fbefe)])
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              )
              ,
              );
            },
          ),
        ),
        TextButton(
          style: ButtonStyle(
              backgroundColor:
              MaterialStateProperty.all(Theme.of(context).primaryColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      side: BorderSide(color: (Theme.of(context).textTheme.bodyText1!.color)!)))),
          child: Text('Вернуться на главную',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyText1!.color,
                fontSize: 15,
              )),
          onPressed: () => {Navigator.pop(
            context),
          },
        ),
        Container(
          height: 40,
        )
      ]),
    );
  }

  Widget createInnerCard(String info, String postfix, String icon){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(width: 10,),
        SizedBox(height: 30, width: 30, child: Image.asset(icon, color: Theme.of(context).textTheme.bodyText1!.color,)),
        const SizedBox(width: 10,),
        Text(info, style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color, fontSize: 20),),
        Text(postfix,style: const TextStyle(fontSize: 20, color: Colors.grey)),
      ],
    );
  }

}