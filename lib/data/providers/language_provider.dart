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
      'dashboard': 'Pano',
      //---------------User add page---------------
      'users': 'Kullanıcılar',
      'userAdd': 'Kullanıcı ekle',
      'userNotFound': 'Kayıtlı kullanıcı bulunamadı.',
      'deleteUserAlertText': 'Bu kullanıcıyı silmek istediğinize emin misiniz?',
      //---------------User add page---------------
      'userTitle': 'Ünvan',
      'userExists': 'Bu kullanıcı adı zaten kayıtlı.',
      //---------------User edit page---------------
      'userEdit': 'Kullanıcıyı düzenle',
      //--------------save - delete function---------------
      'save': 'Kaydet',
      'deleteAlertTitle': 'Emin misiniz?',
      'cancel': 'İptal',
      'delete': 'Sil',

      'categories': 'Kategoriler',
      'products': 'Ürünler',
    },

    'en': {
      'loginTitle': 'Login',
      'welcomeMessage': 'Welcome, it\'s nice to see you again!',
      'username': 'Username',
      'password': 'Password',
      'loginError': 'Username or password is wrong!',
      'dashboard': 'Dashboard',
      //---------------USERS---------------
      'users': 'Users',
      'userAdd': 'Add User',
      'userNotFound': 'No users found.',
      'deleteUserAlertText': 'Are you sure you want to delete this user?',
      //---------------User add page---------------
      'userTitle': 'Title',
      'userExists': 'This user already exists.',
      //---------------User edit page---------------
      'userEdit': 'Edit user',
      //--------------save - delete function---------------
      'save': 'Save',
      'deleteAlertTitle': 'Are you sure?',
      'cancel': 'Cancel',
      'delete': 'Delete',

      'categories': 'Categories',
      'products': 'Products',
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
