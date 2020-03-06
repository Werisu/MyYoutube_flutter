import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:myyoutube/Telas/favoritos.dart';
import 'package:myyoutube/Tiles/video_tile.dart';
import 'package:myyoutube/bloc/favorite_bloc.dart';
import 'package:myyoutube/delegats/data_pesquisa.dart';
import 'package:myyoutube/bloc/videos_bloc.dart';
import 'package:myyoutube/modelo/video_modelo.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final _bloc = BlocProvider.of<VideosBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 60,
          child: Image.asset("imagens/youtube.png"),
        ),
        elevation: 0,
        backgroundColor: Colors.blueGrey,
        actions: <Widget>[
          Align(
            alignment: Alignment.center,
            child: StreamBuilder<Map<String, Video>>(
              stream: BlocProvider.of<FavoriteBloc>(context).outFav,
              builder: (context, snapshot){
                if(snapshot.hasData){
                  return Text("${snapshot.data.length}");
                }else{
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
            ),
          ),
          IconButton(
            icon: Icon(Icons.star),
            onPressed: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => FavoritosTela()
                )
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async{
              String resultado = await showSearch(context: context, delegate: DataPesquisa());
              if(resultado != null) _bloc.inBuscar.add(resultado);
            },
          )
        ],
      ),
      backgroundColor: Colors.black,
      body: StreamBuilder(
        stream: _bloc.outVideos,
        initialData: [],
        builder: (context, snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemBuilder: (context, index){
                if(index < snapshot.data.length){
                  return VideoTile(snapshot.data[index]);
                }else if (index > 1){
                  _bloc.inBuscar.add(null);
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
                }else{
                  return Container();
                }
              },
              itemCount: snapshot.data.length + 1,
            );
          }else{
            return Container();
          }
        },
      ),
    );
  }
}
