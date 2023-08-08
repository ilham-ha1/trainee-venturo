import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/commons/asset_const.dart';
import 'langs/en_us.dart';
import 'langs/id_id.dart';

// localization class
class Localization extends Translations {
  // default locale constant
  static const defaultLocale = Locale('id', 'ID');

  // fallback locale constant
  static const fallbackLocale = Locale('en', 'US');

  // supported languages constant
  static const langs = [
    'English',
    'Indonesia',
  ];

  // flags asset image list constant
  static const flags = [
    AssetConst.flagEN,
    AssetConst.flagID,
  ];

  // locale list constant
  static const locales = [
    Locale('en', 'US'),
    Locale('id', 'ID'),
  ];

  // locale keys constants
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': translationsEnUs,
        'id_ID': translationsIdId,
      };

  // change locale
  static void changeLocale(String lang) async {
    final locale = getLocaleFromLanguage(lang);
    await Get.updateLocale(locale);
  }

  // search for language and return locale
  static Locale getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (langs[i].toLowerCase() == lang.toLowerCase()) {
        return locales[i];
      }
    }
    return defaultLocale;
  }

  // get current locale
  static Locale get currentLocale {
    return Get.locale ?? fallbackLocale;
  }

  // get current language
  static String get currentLanguage {
    return langs.elementAt(locales.indexOf(currentLocale));
  }
}