import 'package:data_flow/home/home_bloc.dart';
import 'package:flutter/material.dart';

class MessageOption extends StatelessWidget {

  final HomeBloc bloc;

  MessageOption(this.bloc);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: <Widget>[
        _buildClickableSelectionText("This is a dead end message", false),
        _buildClickableSelectionText("I am a valid one", true),
        _buildClickableSelectionText("If you choose me, u cannot accept it", false),
        _buildClickableSelectionText("Choose me", true),
        ],
      ),
    );
  }

  Widget _buildClickableSelectionText(String message, bool isValid) {
    return InkWell(
      onTap: () {
        bloc.setMessage(message);
        bloc.setValidState(isValid);
      },
      child: Container(
        padding: EdgeInsets.all(8.0),
        alignment: Alignment.center,
        height: 50,
        child: Text(message),
      ),
    );
  }
}
