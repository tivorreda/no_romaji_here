class Letter {
  Letter(String hiragana, String katakana, LetterFamily family) {
    this.hiraganaText = hiragana;
    this.katakanaText = katakana;
    this.letterFamily = family;
  }

  late String hiraganaText;
  late String katakanaText;
  late LetterFamily letterFamily;
}

enum LetterFamily {
  VOWELS,
  KA,
  GA,
  SA,
  ZA,
  TA,
  DA,
  NA,
  HA,
  BA,
  PA,
  MA,
  RA,
  YA,
  WA,
  N,
  KYA,
  GYA,
  SHA,
  JA,
  CHA,
  NYA,
  HYA,
  BYA,
  PYA,
  MYA,
  RYA
}