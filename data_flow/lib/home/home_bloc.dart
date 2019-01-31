import 'dart:async';

import 'package:data_flow/common/bloc_provider.dart';

class HomeBloc extends BlocBase {

  String _message;

  StreamController<String> _messageController = StreamController.broadcast();
  StreamController<bool> _validationController = StreamController.broadcast();

  StreamSink<String> get _messageValue => _messageController.sink;
  StreamSink<bool> get _isValidMessageSelected => _validationController.sink;

  Stream<String> get messageListener => _messageController.stream;
  Stream<bool> get validationListener => _validationController.stream;

  setMessage(String message) {
    this._message = message;
  }

  setValidState(bool isValid) {
    this._isValidMessageSelected.add(isValid);
  }

  streamMessage() {
    this._messageValue.add(this._message);
  }

  @override
  void dispose() {
    _messageController.close();
    _validationController.close();
  }

}