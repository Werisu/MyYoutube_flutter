import 'package:flutter/material.dart';
import 'package:myyoutube/modelo/video_modelo.dart';

class VideoTile extends StatelessWidget {

  final Video video;

  VideoTile(this.video);

  @override
  Widget build(BuildContext context) {
    return Container(
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
              IconButton(
                icon: Icon(Icons.star_border),
                color: Colors.white,
                iconSize: 30,
                onPressed: (){

                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
