import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:weather_app/services/data_structures.dart';
import 'package:weather_app/services/manager.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: ((){Navigator.maybePop(context);}),
            icon: Icon(Icons.arrow_back_ios_new_rounded, color: Theme.of(context).textTheme.bodyText1!.color,)),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Настройки",
          style: TextStyle(fontSize: 24, color: Theme.of(context).textTheme.bodyText1!.color),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(width: 20,),
              Text("Единицы измерения", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),),
            ],
          ),
          Container(height: 10,),
          SizedBox(
            height: 60,
            width: MediaQuery.of(context).size.width-40,
            child: Neumorphic(
                style: NeumorphicStyle(
                  shape: NeumorphicShape.concave,
                  boxShape:
                  NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
                  depth: 5,
                  lightSource: LightSource.top,
                  color: Theme.of(context).primaryColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(width: 10,),
                        Text("Температура", style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color, fontSize: 16, fontWeight: FontWeight.bold),),
                        Spacer(),
                        NeumorphicToggle(
                          height: 30,
                          width: 150,
                          selectedIndex: SettingsVars.boolToInt(SettingsVars.temperature),
                          displayForegroundOnlyIfSelected: true,
                          style: NeumorphicToggleStyle(backgroundColor: Theme.of(context).primaryColor,borderRadius: BorderRadius.all(Radius.circular(50))),
                          children: [
                            ToggleElement(
                              background: Center(child: Text("°C", style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color, fontWeight: FontWeight.w500),)),
                              foreground: Center(child: Text("°C", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),)),
                            ),
                            ToggleElement(
                              background: Center(child: Text("°F", style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color, fontWeight: FontWeight.w500),)),
                              foreground: Center(child: Text("°F", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),)),
                            )
                          ],
                          thumb: Neumorphic(
                            style: NeumorphicStyle(
                                boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(50)),
                              color: Color(0xff4b5f88),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              SettingsVars.temperature = SettingsVars.intToBool(value);
                            });
                            SPManager.setSettingsTemp();
                            UserData.callback();
                          },
                        ),
                        Container(width: 10,),
                      ],
                    ),
                  ],
                ))
          ),

          Container(height: 20,),

          SizedBox(
              height: 60,
              width: MediaQuery.of(context).size.width-40,
              child: Neumorphic(
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.concave,
                    boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
                    depth: 5,
                    lightSource: LightSource.top,
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(width: 10,),
                          Text("Ветер", style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color, fontSize: 16, fontWeight: FontWeight.bold),),
                          Spacer(),
                          NeumorphicToggle(
                            height: 30,
                            width: 150,
                            selectedIndex: SettingsVars.boolToInt(SettingsVars.wind),
                            displayForegroundOnlyIfSelected: true,
                            style: NeumorphicToggleStyle(backgroundColor: Theme.of(context).primaryColor,borderRadius: BorderRadius.all(Radius.circular(50))),
                            children: [
                              ToggleElement(
                                background: Center(child: Text("м/с", style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color, fontWeight: FontWeight.w500),)),
                                foreground: Center(child: Text("м/с", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),)),
                              ),
                              ToggleElement(
                                background: Center(child: Text("км/ч", style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color, fontWeight: FontWeight.w500),)),
                                foreground: Center(child: Text("км/ч", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),)),
                              )
                            ],
                            thumb: Neumorphic(
                              style: NeumorphicStyle(
                                boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(50)),
                                color: Color(0xff4b5f88),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                SettingsVars.wind = SettingsVars.intToBool(value);
                              });
                              SPManager.setSettingsWind();
                              UserData.callback();
                            },
                          ),
                          Container(width: 10,),
                        ],
                      ),
                    ],
                  ))
          ),

          Container(height: 20,),

          SizedBox(
              height: 60,
              width: MediaQuery.of(context).size.width-40,
              child: Neumorphic(
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.concave,
                    boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
                    depth: 5,
                    lightSource: LightSource.top,
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(width: 10,),
                          Text("Давление", style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color, fontSize: 16, fontWeight: FontWeight.bold),),
                          Spacer(),
                          NeumorphicToggle(
                            height: 30,
                            width: 150,
                            selectedIndex: SettingsVars.boolToInt(SettingsVars.pressure),
                            displayForegroundOnlyIfSelected: true,
                            style: NeumorphicToggleStyle(backgroundColor: Theme.of(context).primaryColor,borderRadius: BorderRadius.all(Radius.circular(50))),
                            children: [
                              ToggleElement(
                                background: Center(child: Text("мм.рт.ст", style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color, fontWeight: FontWeight.w500),)),
                                foreground: Center(child: Text("мм.рт.ст", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),)),
                              ),
                              ToggleElement(
                                background: Center(child: Text("гПа", style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color, fontWeight: FontWeight.w500),)),
                                foreground: Center(child: Text("гПа", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),)),
                              )
                            ],
                            thumb: Neumorphic(
                              style: NeumorphicStyle(
                                boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(50)),
                                color: Color(0xff4b5f88),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                SettingsVars.pressure = SettingsVars.intToBool(value);
                              });
                              SPManager.setSettingsPressure();
                              UserData.callback();
                            },
                          ),
                          Container(width: 10,),
                        ],
                      ),
                    ],
                  ))
          ),

          Container(height: 20,),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(width: 20,),
              Text("Смена темы", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),),
            ],
          ),
          Container(height: 10,),
          SizedBox(
              height: 60,
              width: MediaQuery.of(context).size.width-40,
              child: Neumorphic(
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.concave,
                    boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
                    depth: 5,
                    lightSource: LightSource.top,
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(width: 10,),
                          Text("Тема", style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color, fontSize: 16, fontWeight: FontWeight.bold),),
                          Spacer(),
                          NeumorphicToggle(
                            height: 30,
                            width: 150,
                            selectedIndex: SettingsVars.boolToInt(SettingsVars.theme),
                            displayForegroundOnlyIfSelected: true,
                            style: NeumorphicToggleStyle(backgroundColor: Theme.of(context).primaryColor,borderRadius: BorderRadius.all(Radius.circular(50))),
                            children: [
                              ToggleElement(
                                background: Center(child: Text("Светлая", style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color, fontWeight: FontWeight.w500),)),
                                foreground: Center(child: Text("Светлая", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),)),
                              ),
                              ToggleElement(
                                background: Center(child: Text("Тёмная", style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color, fontWeight: FontWeight.w500),)),
                                foreground: Center(child: Text("Тёмная", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),)),
                              )
                            ],
                            thumb: Neumorphic(
                              style: NeumorphicStyle(
                                boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(50)),
                                color: Color(0xff4b5f88),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                SettingsVars.theme = SettingsVars.intToBool(value);
                                if(SettingsVars.theme) AdaptiveTheme.of(context).setDark();
                                else AdaptiveTheme.of(context).setLight();
                              });
                              SPManager.setSettingsTheme();
                              UserData.callback();
                            },
                          ),
                          Container(width: 10,),
                        ],
                      ),
                    ],
                  ))
          ),
        ],
      ),
    );
  }
}