import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:myyoutube/bloc/favorite_bloc.dart';
import 'package:myyoutube/modelo/video_modelo.dart';

class FavoritosTela extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final _bloc = BlocProvider.of<FavoriteBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favoritos"
        ),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Colors.black87,
      body: StreamBuilder<Map<String, Video>>(
        stream: _bloc.outFav,
        initialData: {},
        builder: (context, snapshot){
          return ListView(
            children: snapshot.data.values.map((v){
              return InkWell(
                onTap: (){

                },
                onLongPress: (){
                  _bloc.togglerFavoritos(v);
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 50,
                      width:  100,
                      child: Image.network(v.miniatura),
                    ),
                    Expanded(
                      child: Text(
                        v.titulo,
                        style: TextStyle(
                          color: Colors.white70
                        ),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
