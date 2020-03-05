import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myyoutube/modelo/video_modelo.dart';

const API_KEY = "AIzaSyA4DJuPK-XyrNDGiLQh4owxl5riQFzcfro";

class Api {

  busca(String busca) async{

    http.Response response = await http.get(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$busca&type=video&key=$API_KEY&maxResults=10"
    );

    codigo(response);

  }

  List<Video> codigo(http.Response response){

    /* O código 200 significa que ele recebeu os dados com sucesso */
    if(response.statusCode == 200){

      var decodificando = json.decode(response.body);

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