import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/services/data_structures.dart';
import 'package:weather_app/services/manager.dart';

import 'loading.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController _input = TextEditingController();
  bool isSearching = false;
  bool showResult = false;
  String searchText = '';
  List<String> result = [];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          bool ret = false;
          if (isSearching) {
            setState(() {
              isSearching = !isSearching;
            });
          } else {
            ret = true;
          }
          return ret;
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          appBar: AppBar(
            leading: ((isSearching || _input.text!= '') ? clearButton() : returnButton()),
            iconTheme: IconThemeData(
                color: Theme.of(context).textTheme.bodyText1!.color),
            backgroundColor: Theme.of(context).primaryColor,
            elevation: 0,
            title: InkWell(
              onTap: () => {
                setState(() {
                  isSearching = true;
                })
              },
              child: isSearching
                  ? _buildSearchField()
                  : Text((_input.text != '' ? _input.text : "Введите название города..."),
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
            ),
            actions: [
              IconButton(onPressed: () => request(), icon: Icon(Icons.search)),
            ],
          ),
          body: InkWell(
            onTap: () => {
              setState(() {
                isSearching = false;
              })
            },
            child: checkResult(),
          ),
        ));
  }

  Future<void> request() async {
    await search();
    setState(() {
    });
  }

  Widget returnButton() {
    return IconButton(
        onPressed: () => {Navigator.maybePop(context)},
        icon: Icon(Icons.arrow_back_ios_new_rounded));
  }

  Widget clearButton() {
    return IconButton(
        onPressed: () => {
              setState(() {
                isSearching = false;
                _input.clear();
                result.clear();
              })
            },
        icon: Icon(Icons.clear));
  }

  Widget _buildSearchField() {
    return TextField(
          controller: _input,
          autofocus: true,
          decoration: InputDecoration(
            hintText: "Введите название города...",
            border: InputBorder.none,
            hintStyle: TextStyle(
                fontSize: 16,
                color: Colors.grey,),
          ),
          style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).textTheme.bodyText1!.color),
        );
  }

  Widget checkResult(){
    if(showResult) if(result.isNotEmpty) return generateResult();
    else return showFiller();
    else return Container();
  }

  Widget generateResult(){
    return ListView.builder(
      itemCount: result.length,
      itemBuilder: (BuildContext context, int index) => resultCard(index),
    );
  }

  Widget resultCard(int i){
    return ListTile(
      onTap: (() async {
        await Loading.reloadData(result[i]);
        setState(() {});
      }),
      title: Text(result[i], style: (result[i] == UserData.cityData.name ? TextStyle(fontSize: 16, color: Colors.blueAccent) : TextStyle(fontSize: 16, color: Theme.of(context).textTheme.bodyText1!.color)),),
      trailing: (UserData.favourites.contains(result[i]) ? deleteStar(i) : addStar(i)),
    );
  }

  Widget addStar(int i){
    return IconButton(onPressed: () => setState((){
      UserData.favourites.add(result[i]);
      SPManager.setUserDataFavourites();
    }), icon: Icon(Icons.star_border));
  }

  Widget deleteStar(int i){
    return IconButton(onPressed: () => setState((){
      UserData.favourites.remove(result[i]);
      SPManager.setUserDataFavourites();
    }), icon: Icon(Icons.star));
  }

  Widget showFiller(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Здесь ничего нет', style: TextStyle(color: Colors.grey, fontSize: 20),)
          ],
        )
      ],
    );
  }

  Future<void> search() async {
    result.clear();
    setState(() {
      showResult = true;
    });
    String request = _input.text;
    if (request == '') return;
    http.Response response = await http.get(Uri.parse('http://api.geonames.org/searchJSON?q=$request&maxRows=100&lang=ru&searchlang=ru&orderby=relevance&username=kitubiyca'));
    Map data = jsonDecode(response.body);
    List geonames = data['geonames'];
    int counter = 0;
    int addCounter = 10;
    while (counter < 100 && addCounter > 0){
      if (geonames[counter]['fclName'] == "city, village,...") {
        result.add(geonames[counter]['name']);
        addCounter--;
      }
      counter++;
    }
    return;
  }

}
