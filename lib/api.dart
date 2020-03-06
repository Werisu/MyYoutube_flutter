import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myyoutube/modelo/video_modelo.dart';

const API_KEY = "AIzaSyCYpv0WcKkKS_ZLPaw454vS2xg8-RDsuns";

class Api {

  String _busca;
  String _nextToken;

  Future<List<Video>> buscando(String busca) async{

    _busca = busca;

    print("=*=*=*=*=*=*=*=*=*=*=*=*=*=*=");

    http.Response response = await http.get(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$busca&type=video&key=$API_KEY&maxResults=10"
    );

    return codigo(response);

  }

  Future<List<Video>> proximaPagina() async{
    http.Response response = await http.get(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_busca&type=video&key=$API_KEY&maxResults=10&pageToken=$_nextToken"
    );

    return codigo(response);

  }

  List<Video> codigo(http.Response response){

    /* O código 200 significa que ele recebeu os dados com sucesso */
    if(response.statusCode == 200){

      var decodificando = json.decode(response.body);

      _nextToken = decodificando["nextPageToken"];

      /* Transformar em uma lista de objetos vídeo */

      List<Video> videos = decodificando["items"].map<Video>(
          (map){
            return Video.fromJson(map);
          }
      ).toList();

      return videos;

    }else{
      throw Exception("Falha ao carregar vídeo");
    }

  }

}