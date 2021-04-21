import 'package:csv/csv.dart';
import 'package:death_to_romaji/backend/data_sources/letter_data_source.dart';
import 'package:death_to_romaji/models/letter.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:math';

class AssetKanaReader implements LetterSource {
  String? data;
  List<Letter>? letters;

  AssetKanaReader() {
    loadAsset().then((value) {
      data = value;
      List<List<dynamic>> kanaCSV = const CsvToListConverter().convert(data);
      letters = <Letter>[];
      for(var i = 0; i < kanaCSV.length; i++) {
        var hiragana = kanaCSV[i][0].toString();
        var katakana = kanaCSV[i][1].toString();
        var family = LetterFamily.KA;
        LetterFamily.values.forEach((element) {
          if (element.toString() == 'LetterFamily.' + kanaCSV[i][2]) {
            family = element;
          }
        });
        letters!.add(Letter(hiragana, katakana, family));
      }
    });
  }


  @override
  List<Letter> getAll() {
    if (letters != null)
      return letters!;
    else
      return <Letter>[];
  }

  @override
  List<Letter> getAllFromFamily(LetterFamily letterFamily) {
    List<Letter> familyLetters = <Letter>[];
    if (letters != null) {
      letters!.forEach((element) {
        if (element.letterFamily == letterFamily) {
          familyLetters.add(element);
        }
      });
    }
    return familyLetters;
  }

  @override
  Letter getRandomOne() {
    var rng = Random();
    if (letters == null) {
      return Letter("","",LetterFamily.KA);
    } else {
      Letter randomLetter = letters![rng.nextInt(letters!.length)];
      return randomLetter;
    }
  }

  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/kana csv.csv');
  }
}