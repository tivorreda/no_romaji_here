import 'package:death_to_romaji/backend/asset_kana_reader.dart';
import 'package:death_to_romaji/models/letter.dart';

class LetterDataSource {
  LetterDataSource(LetterSource letterSource) {
    this.letterSource = AssetKanaReader();
  }

  late LetterSource letterSource;

  List<Letter> getAll() {
    return letterSource.getAll();
  }

  List<Letter> getAllFromFamily(LetterFamily letterFamily) {
    return letterSource.getAllFromFamily(letterFamily);
  }

  Letter getRandomOne() {
    return letterSource.getRandomOne();
  }
}

abstract class LetterSource {
  List<Letter> getAll();
  List<Letter> getAllFromFamily(LetterFamily letterFamily);
  Letter getRandomOne();
}