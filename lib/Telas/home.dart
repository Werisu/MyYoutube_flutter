import 'package:flutter/material.dart';
import 'package:myyoutube/delegats/data_pesquisa.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            child: Text("0"),
          ),
          IconButton(
            icon: Icon(Icons.star),
            onPressed: (){

            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async{
              String resultado = await showSearch(context: context, delegate: DataPesquisa());
            },
          )
        ],
      ),
      body: Container(),
    );
  }
}
