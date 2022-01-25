import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

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
          "О разработчике",
          style: TextStyle(fontSize: 24, color: Theme.of(context).textTheme.bodyText1!.color),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 100,
          ),
          SizedBox(
            height: 70,
            width: 250,
            child: Neumorphic(
                style: NeumorphicStyle(
                  shape: NeumorphicShape.concave,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
                  depth: -5,
                  lightSource: LightSource.top,
                  color: Theme.of(context).primaryColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Weather App",
                          style: TextStyle(
                              color: Theme.of(context).textTheme.bodyText1!.color, fontSize: 26, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                )),
          ),
          Container(
            height: 130,
          ),
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Neumorphic(
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.concave,
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
                    depth: -5,
                    lightSource: LightSource.top,
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "by ITMO University",
                            style: TextStyle(
                                color: Theme.of(context).textTheme.bodyText1!.color, fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Версия 1.0",
                            style: TextStyle(
                                fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "От 30 Сентября 2021",
                            style: TextStyle(
                                fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Expanded(child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "2021",
                                style: TextStyle(
                                    color: Theme.of(context).textTheme.bodyText1!.color, fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Container(
                            height: 10,
                          )
                        ],
                      ))
                    ],
                  )),
            ),
          )
        ],
      ),
    );
  }
}
