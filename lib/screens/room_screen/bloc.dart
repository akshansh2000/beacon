import 'dart:async';

import 'package:beacon/firebase_calls/controller.dart';
import 'package:beacon/screens/room_screen/event.dart';

import 'package:random_string/random_string.dart';

FirebaseBloc bloc;

class FirebaseBloc {
  var roomDetails = Map();

  final _sinkController = StreamController<FirebaseEvent>();
  final _streamController = StreamController<Map>();

  StreamSink get input => _sinkController.sink;
  StreamSink get _intermediate => _streamController.sink;
  Stream get output => _streamController.stream;

  FirebaseBloc() {
    _mapEventToState(FirebaseEvent event) {
      if (event is CreateRoom) {
        roomDetails = controller.createRoom(randomAlphaNumeric(15));
      }

      _intermediate.add(roomDetails);
      print(roomDetails);
    }

    _sinkController.stream.listen(_mapEventToState);
  }

  void dispose() {
    _sinkController.close();
    _streamController.close();
  }
}
