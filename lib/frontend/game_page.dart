import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_widgets/choice_button_widget.dart';
import '../view_models/game_view_model.dart';
import 'dart:math';

class GamePage extends StatelessWidget {
  GamePage(GameViewModel gameViewModel) {
    this.gameViewModel = gameViewModel;
  }

  late final GameViewModel gameViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(gameViewModel.gameType.toString()),
        ),
        body: Center(
          child: StreamBuilder<GameState>(
              stream: gameViewModel.streamController.stream,
              builder: (context, snapshot) {
                var text =
                    snapshot.data == null ? '' : snapshot.data!.mainLetter;
                var choiceList =
                    snapshot.data == null ? <String>[] : snapshot.data!.choices;
                var rounds = snapshot.data == null ? 0 : snapshot.data!.rounds;
                var wrongs = snapshot.data == null ? 0 : snapshot.data!.wrongs;
                var rights = snapshot.data == null ? 0 : snapshot.data!.rights;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text(
                      "RIGHTS: " + rights.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.green, fontSize: 25),
                    ),
                    Text(
                      "WRONGS: " + wrongs.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red, fontSize: 25),
                    ),
                    Text(
                      "ROUNDS: " + rounds.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black45, fontSize: 25),
                    ),
                    Text(
                      "RATE: " + gameViewModel.getRate().toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black45, fontSize: 25),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 30),
                      color: Colors.green,
                      child: MaterialButton(
                        onPressed: () {
                          gameViewModel.textToSpeech(text);
                        },
                        child: Icon(Icons.play_arrow),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 30),
                      color: Colors.green,
                      child: MaterialButton(
                        onPressed: () {
                          gameViewModel.reset();
                        },
                        child: Icon(Icons.update),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: 300,
                        height: 300,
                        child: GridView.count(
                          crossAxisCount: 2,
                          children: List.generate(choiceList.length, (index) {
                            return ChoiceButton(
                              text: choiceList[index],
                              onPressed: () {
                                if (snapshot.data != null) {
                                  gameViewModel.onLetterChosen(
                                      snapshot.data!, index);
                                }
                              },
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                );
              }),
        ));
  }
}
