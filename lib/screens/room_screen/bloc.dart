import 'dart:async';

import 'package:beacon/screens/room_screen/event.dart';

class FireBaseBloc {
  var roomDetails = Map();

  final _sinkController = StreamController<FireBaseEvent>();
  final _streamController = StreamController<Map>();

  StreamSink get input => _sinkController.sink;
  StreamSink get _intermediate => _streamController.sink;
  Stream get output => _streamController.stream;

  FireBaseBloc() {
    _mapEventToState(FireBaseEvent event) {}

    _sinkController.stream.listen(_mapEventToState);
  }

  void dispose() {
    _sinkController.close();
    _streamController.close();
  }
}
