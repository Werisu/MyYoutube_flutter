import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:myyoutube/bloc/favorite_bloc.dart';
import 'package:myyoutube/modelo/video_modelo.dart';

import '../api.dart';

class VideoTile extends StatelessWidget {

  final Video video;

  VideoTile(this.video);

  @override
  Widget build(BuildContext context) {

    final favc = BlocProvider.of<FavoriteBloc>(context);

    return GestureDetector(
      onTap: (){
        FlutterYoutube.playYoutubeVideoById(
            apiKey: API_KEY, videoId: video.id, autoPlay: true
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            AspectRatio(
              aspectRatio:  16.0/9.0,
              child: Image.network(video.miniatura, fit: BoxFit.cover,),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          video.titulo,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16
                          ),
                          maxLines: 2,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          video.canal,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                StreamBuilder<Map<String, Video>>(
                  stream: favc.outFav,
                  builder: (context, snapshot){
                    if(snapshot.hasData){
                      return IconButton(
                        icon: Icon(snapshot.data.containsKey(video.id) ?
                        Icons.star : Icons.star_border),
                        color: Colors.white,
                        iconSize: 30,
                        onPressed: (){
                          favc.togglerFavoritos(video);
                        },
                      );
                    } else{
                      return Container(
                        height: 40,
                        width: 40,
                        alignment: Alignment.center,
                        child: Container(
                          width: 150,
                          height: 150,
                          child: FlareActor(
                            "animation/player.flr",
                            animation: "trocarCores",
                          ),
                        ),
                      );
                    }
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
