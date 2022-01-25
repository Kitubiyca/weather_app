import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:weather_app/services/data_structures.dart';
import 'package:weather_app/services/manager.dart';

import 'loading.dart';

class Favourites extends StatefulWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {

  Set<String> toRemove = {};
  bool setIsChanged = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async{
          if(setIsChanged) toRemove.clear();
          bool ret = !setIsChanged;
          setIsChanged = false;
          setState(() {});
          return ret;
        },
      child: Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        leading: AnimatedCrossFade(
          duration: const Duration(milliseconds: 200),
        firstChild: checkButton(),
        secondChild: returnButton(),
        crossFadeState: (setIsChanged)
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
      ),
        title: Text('Избранное', style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color),),
      ),
        body: generateFavourites(),
    ),
        );
  }

  Widget generateFavourites(){
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: UserData.favourites.length,
      itemBuilder: (BuildContext context, int index) => favouritesCard(index),
    );
  }

  Widget favouritesCard(int i){
    return Neumorphic(
      style: NeumorphicStyle(oppositeShadowLightSource: true, depth: -3, color: Theme.of(context).textTheme.headline4!.color, boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),),
      child: ListTile(
        onTap: (() async {
          if(UserData.favourites.elementAt(i)!=UserData.cityData.name) {
            await Loading.reloadData(UserData.favourites.elementAt(i));
            setState(() {});
          }
        }),
        title: AnimatedCrossFade(
          duration: const Duration(milliseconds: 200),
          firstChild: Text(UserData.favourites.elementAt(i), style: TextStyle(fontSize: 16, color: Colors.blueAccent)),
          secondChild: Text(UserData.favourites.elementAt(i), style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.bodyText1!.color)),
          crossFadeState: (UserData.favourites.elementAt(i) == UserData.cityData.name)
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
        ),
        trailing: Neumorphic(
          style: NeumorphicStyle(depth: 0, color: Theme.of(context).textTheme.bodyText2!.color, boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),),
          child: AnimatedCrossFade(
          duration: const Duration(milliseconds: 200),
          firstChild: addIcon(i),
          secondChild: removeIcon(i),
          crossFadeState: (toRemove.contains(UserData.favourites.elementAt(i)))
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
        )
        ),
      ),
    );
  }

  Widget removeIcon(int i){
    return IconButton(onPressed: () =>{
      setState(() {toRemove.add(UserData.favourites.elementAt(i)); setIsChanged = toRemove.isNotEmpty;})
    }, icon: (SettingsVars.theme ? Icon(Icons.clear) : Icon(Icons.cancel)));
  }

  Widget addIcon(int i){
    return IconButton(onPressed: ((){
      toRemove.remove(UserData.favourites.elementAt(i));
      setIsChanged = toRemove.isNotEmpty;
      setState(() {

      });
    }), icon: Icon(Icons.add_outlined));
  }

  Widget returnButton() {
    return IconButton(
        onPressed: ((){Navigator.maybePop(context);}),
        icon: Icon(Icons.arrow_back_ios_new_rounded, color: Theme.of(context).textTheme.bodyText1!.color,));
  }

  Widget checkButton() {
    return IconButton(
        onPressed: (() {
          UserData.favourites.removeWhere((element) => toRemove.contains(element));
          toRemove.clear();
          setIsChanged = false;
          SPManager.setUserDataFavourites();
          setState(() {});
        }),
        icon: Icon(Icons.check, color: Theme.of(context).textTheme.bodyText1!.color));
  }

}
