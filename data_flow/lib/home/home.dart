import 'package:data_flow/common/bloc_provider.dart';
import 'package:data_flow/home/home_bloc.dart';
import 'package:data_flow/home/message_options.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {

  static Widget create() => BlocProvider(
        bloc: HomeBloc(),
        child: Home(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _mainContent(context),
      ),
    );
  }

  Widget _mainContent(BuildContext context) {
    HomeBloc bloc = BlocProvider.of<HomeBloc>(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              StreamBuilder(
                stream: bloc.messageListener,
                initialData: "No message selected",
                builder: (BuildContext context, AsyncSnapshot async) {
                  final message = async.data;
                  return Text(message);
                },
              ),
              RaisedButton(
                onPressed: () { showSelectorDialog(context, bloc);},
                child: Text("OPEN DIALOG SELECTION"),
              )
            ],
          ),
        ),
      ),
    );
  }

  showSelectorDialog(BuildContext context, HomeBloc bloc) async {
    await showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  _dialogTitle(),
                  _messageOptions(bloc),
                  _dialogActionButtons(context, bloc),
                ],
              ),
            ),
          );
        });
  }

  Widget _dialogTitle() {
    return Text(
      "Select the right message",
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _messageOptions(HomeBloc bloc) {
    return Expanded(
      child: MessageOption(bloc),
    );
  }

  Widget _dialogActionButtons(BuildContext context, HomeBloc bloc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("CANCEL"),
        ),
        StreamBuilder(
          stream: bloc.validationListener,
          initialData: false,
          builder: (BuildContext context, AsyncSnapshot async) {
            final isValid = async.data;
            return FlatButton(
              onPressed: isValid ? () {
                bloc.streamMessage();
                Navigator.pop(context);
              } : null,
              child: Text("ACCEPT"),
            );
          },
        ),
      ],
    );
  }
}
