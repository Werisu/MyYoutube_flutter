import 'dart:async';
import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:myyoutube/modelo/video_modelo.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteBloc implements BlocBase{

  Map<String, Video> _favoritos = {};

  final _favControle = BehaviorSubject<Map<String, Video>>();
  Stream<Map<String, Video>> get outFav => _favControle.stream;

  FavoriteBloc(){
    SharedPreferences.getInstance().then((prefs){
      if(prefs.getKeys().contains("favoritos")){
        _favoritos = json.decode(prefs.getString("favoritos")).map((k, v){
          return MapEntry(k, Video.fromJson(v));
        }).cast<String, Video>();
        _favControle.add(_favoritos);
      }
    });
  }

  void togglerFavoritos(Video v){
    if(_favoritos.containsKey(v.id)) _favoritos.remove(v.id);
    else _favoritos[v.id] = v;

    _favControle.sink.add(_favoritos);

    _saveFav();
  }

  void _saveFav(){
    SharedPreferences.getInstance().then((prefs){
      prefs.setString("favoritos", json.encode(_favoritos));
    });
  }

  @override
  void dispose() {
    _favControle.close();
    // TODO: implement dispose
  }

}