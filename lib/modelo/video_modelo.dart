

class Video{

    final String id;
    final String titulo;
    final String miniatura;
    final String canal;

    Video({this.id, this.titulo, this.miniatura, this.canal});

    factory Video.fromJson(Map<String, dynamic> json){
      return Video(
          id: json["id"]["videoId"],
          titulo: json["snippet"]["title"],
          miniatura: json["snippet"]["thumbnails"]["high"]["url"],
          canal: json["snippet"]["channelTitle"]
      );
    }

}