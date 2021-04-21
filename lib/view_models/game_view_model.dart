import 'dart:async';

import 'package:death_to_romaji/backend/asset_kana_reader.dart';
import 'package:death_to_romaji/backend/data_sources/letter_data_source.dart';
import 'package:death_to_romaji/models/letter.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:math';

enum GameType {
  HIRAGANA,
  KATAKANA,
  BOTH
}

class GameViewModel {

  GameViewModel(GameType gameType) {
    this.gameType = gameType;
    generateRandomTask();
  }

  LetterDataSource letterDataSource = LetterDataSource(AssetKanaReader());
  StreamController<GameState> streamController = StreamController<GameState>();
  FlutterTts flutterTts = FlutterTts();
  final japaneseLanguage = "ja-JP";
  late GameType gameType;
  var rounds = 0;
  var rights = 0;
  var wrongs = 0;

  double getRate() {
    return rounds != 0 ? (rights.toDouble() / rounds.toDouble()) : 1;
  }

  void reset() {
    rounds = 0;
    rights = 0;
    wrongs = 0;
    generateRandomTask();
  }

  void generateRandomTask() {
    var mainLetter = letterDataSource.getRandomOne();
    var possibleChoices = <Letter>[mainLetter];
    var familyChoices = letterDataSource.getAllFromFamily(mainLetter.letterFamily).where((e) => e.hiraganaText != mainLetter.hiraganaText);
    if (familyChoices.length <= 3) {
      possibleChoices.addAll(familyChoices);
      while (possibleChoices.length < 4) {
        var randomLetter = letterDataSource.getRandomOne();
        if (possibleChoices.contains(randomLetter)) {
          continue;
        }
        possibleChoices.add(letterDataSource.getRandomOne());
      }
    } else {
      possibleChoices.addAll(familyChoices.toList().getRange(0, 3));
    }
    possibleChoices.shuffle();
    _speak(mainLetter.hiraganaText);
    var randomSeed = Random().nextInt(2);
    streamController.add(GameState(
        letter: _getLetterByGameType(mainLetter, gameType, randomSeed),
        choices: _getChoicesByGameType(possibleChoices, gameType, randomSeed),
        rounds: rounds,
        rights: rights,
        wrongs: wrongs
      )
    );
  }

  String _getLetterByGameType(Letter letter, GameType gameType, int randomSeed) {
    switch(gameType) {
      case GameType.HIRAGANA:
        return letter.hiraganaText;
      case GameType.KATAKANA:
        return letter.katakanaText;
      case GameType.BOTH:
        if (randomSeed == 0) {
          return letter.hiraganaText;
        } else {
          return letter.katakanaText;
        }
    }
  }

  List<String> _getChoicesByGameType(List<Letter> choices, GameType gameType, int randomSeed) {
    switch(gameType) {
      case GameType.HIRAGANA:
        return choices.map((e) => e.hiraganaText).toList();
      case GameType.KATAKANA:
        return choices.map((e) => e.katakanaText).toList();
      case GameType.BOTH:
        if (randomSeed == 0) {
          return choices.map((e) => e.hiraganaText).toList();
        } else {
          return choices.map((e) => e.katakanaText).toList();
        }
    }
  }

  void onLetterChosen(GameState state, int chosenLetter) {
    if (state.mainLetter == state.choices[chosenLetter]) {
      rights++;
    } else {
      wrongs++;
    }
    rounds++;
    generateRandomTask();
  }

  void textToSpeech(String text) async {
    flutterTts.setLanguage(japaneseLanguage);
    await _speak(text);
  }

  Future _speak(String text) async {
    await flutterTts.setVolume(0.5);
    await flutterTts.setSpeechRate(0.3);
    await flutterTts.setPitch(0.7);

    if (text.isNotEmpty) {
      await flutterTts.awaitSpeakCompletion(true);
      await flutterTts.speak(text);
    }
  }
}

class GameState {
  late String mainLetter;
  late List<String> choices;
  late int rounds;
  late int rights;
  late int wrongs;

  GameState({required String letter, required List<String> choices, required int rounds, required int rights, required int wrongs}) {
    this.mainLetter = letter;
    this.choices = choices;
    this.rounds = rounds;
    this.rights = rights;
    this.wrongs = wrongs;
  }
}