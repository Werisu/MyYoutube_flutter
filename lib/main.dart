import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:myyoutube/Telas/home.dart';
import 'package:myyoutube/api.dart';
import 'package:myyoutube/bloc/videos_bloc.dart';

void main() {
  Api api = Api();
  api.buscando("Enjuru");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        bloc: VideosBloc(),
        child: MaterialApp(
          title: 'FlutterTube',
          debugShowCheckedModeBanner: false,
          home: Home(),
        ),
    );
  }
}

/*
*
* "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$API_KEY&maxResults=10"
* "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$API_KEY&maxResults=10&pageToken=$_nextToken"
* "http://suggestqueries.google.com/complete/search?hl=en&ds=yt&client=youtube&hjson=t&cp=1&q=$search&format=5&alt=json"
*
* */