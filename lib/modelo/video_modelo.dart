

class Video{

    final String id;
    final String titulo;
    final String miniatura;
    final String canal;

    Video({this.id, this.titulo, this.miniatura, this.canal});

    factory Video.fromJson(Map<String, dynamic> json){
      if(json.containsKey("id"))
        return Video(
            id: json["id"]["videoId"],
            titulo: json["snippet"]["title"],
            miniatura: json["snippet"]["thumbnails"]["high"]["url"],
            canal: json["snippet"]["channelTitle"]
        );
      else
        return Video(
          id: json["videoId"],
          titulo: json["titulo"],
          miniatura: json["miniatura"],
          canal: json["canal"]
        );
    }

    Map<String, dynamic> toJson(){
      return {
        "videoId": id,
        "titulo": titulo,
        "miniatura": miniatura,
        "canal": canal
      };
    }

}