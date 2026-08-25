import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  // Aktif dil bilgisi
  Locale _currentLocale = const Locale('tr');

  Locale get currentLocale => _currentLocale;

  // 1. Tüm çevirileri doğrudan Dart Map (Sözlük) yapısında tutuyoruz
  static const Map<String, Map<String, String>> _translations = {
    'tr': {
      'loginTitle': 'Giriş Yap',
      'welcomeMessage': 'Hoş geldin, seni tekrar görmek güzel!',
      'username': 'Kullanıcı adı',
      'password': 'Şifre',
      'loginError': 'Kullanıcı adı veya şifre yanlış!',
    },
    'en': {
      'loginTitle': 'Login',
      'welcomeMessage': 'Welcome, it\'s nice to see you again!',
      'username': 'Username',
      'password': 'Password',
      'loginError': 'Username or password is wrong!',
    },
  };

  // 2. Metinleri anahtara (key) göre çeken yardımcı fonksiyon
  String translate(String key) {
    final langCode = _currentLocale.languageCode;
    // Eğer anahtar bulunamazsa uygulamanın çökmemesi için anahtarın kendisini döner
    return _translations[langCode]?[key] ?? key;
  }

  // Dili değiştiren fonksiyon
  void changeLanguage(String languageCode) {
    if (_currentLocale.languageCode == languageCode) return;
    _currentLocale = Locale(languageCode);
    notifyListeners();
  }
}
