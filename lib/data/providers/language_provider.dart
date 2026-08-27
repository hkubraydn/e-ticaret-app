import 'package:flutter/material.dart';
import '../localization/translations.dart';

class LanguageProvider extends ChangeNotifier {
  // Aktif dil bilgisi
  Locale _currentLocale = const Locale('tr');

  Locale get currentLocale => _currentLocale;

  // key alıyo parametre olarak, sonra şuanki dil kodunu kontrol ediyo
  String translate(String key) {
    final langCode = _currentLocale.languageCode;
    // Eğer anahtar bulunamazsa uygulamanın çökmemesi için anahtarın kendisini döner
    return Translations.data[langCode]?[key] ?? key;
  }

  // Dili değiştiren fonksiyon
  void changeLanguage(String languageCode) {
    if (_currentLocale.languageCode == languageCode) return;
    _currentLocale = Locale(languageCode);
    notifyListeners();
  }
}
