import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:myyoutube/api.dart';
import 'package:myyoutube/modelo/video_modelo.dart';

class VideosBloc implements BlocBase {

  Api api;

  List<Video> videos;

  final StreamController<List<Video>> _videosController = StreamController<List<Video>>();
  Stream get outVideos => _videosController.stream;

  final StreamController<String> _buscarController = StreamController<String>();
  Sink get inBuscar => _buscarController.sink;

  VideosBloc(){
    api = Api();

    _buscarController.stream.listen(_buscar);
  }

  void _buscar(String busca) async{
    if(busca != null){
      _videosController.sink.add([]);
      videos = await api.buscando(busca);
    }else{
      videos += await api.proximaPagina();
    }
    _videosController.sink.add(videos);
  }

  @override
  void addListener(listener) {
    // TODO: implement addListener
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _videosController.close();
    _buscarController.close();
  }

  @override
  // TODO: implement hasListeners
  bool get hasListeners => null;

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
  }

  @override
  void removeListener(listener) {
    // TODO: implement removeListener
  }

}