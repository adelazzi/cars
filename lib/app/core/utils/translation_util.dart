// ignore_for_file: prefer_const_constructors

import 'package:cars/app/core/constants/storage_keys_constants.dart';
import 'package:cars/app/core/services/local_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class TranslationUtil {
//   static Locale? currentLang = Locale('ar');

//   static void changeLang({required TranslationLanguages lang}) {
//     LocalStorageService.saveData(
//         key: StorageKeysConstants.localeLang,
//         value: (lang == TranslationLanguages.arabic) ? 'ar' : 'en',
//         type: DataTypes.string);
//     Get.updateLocale(
//         Locale((lang == TranslationLanguages.arabic) ? 'ar' : 'en'));
//     currentLang = (lang == TranslationLanguages.arabic)
//         ? const Locale('ar')
//         : const Locale('en');
//   }

//   static Future<void> initialize() async {
//     if (await LocalStorageService.loadData(
//             key: StorageKeysConstants.localeLang, type: DataTypes.string) !=
//         null) {
//       currentLang = (await LocalStorageService.loadData(
//                   key: StorageKeysConstants.localeLang,
//                   type: DataTypes.string) ==
//               'ar')
//           ? const Locale('ar')
//           : const Locale('en');
//     }
//   }
// }

// enum TranslationLanguages {
//   english,
//   arabic,
// }
class TranslationUtil {
  static Locale? currentLang = Locale('ar');

  static void changeLang({required TranslationLanguages lang}) {
    String languageCode = 'ar';

    switch (lang) {
      case TranslationLanguages.english:
        languageCode = 'en';
        break;
      case TranslationLanguages.arabic:
        languageCode = 'ar';
        break;
      case TranslationLanguages.french:
        languageCode = 'fr';
        break;
    }

    LocalStorageService.saveData(
        key: StorageKeysConstants.localeLang,
        value: languageCode,
        type: DataTypes.string);

    Get.updateLocale(Locale(languageCode));
    currentLang = Locale(languageCode);
  }

  static Future<void> initialize() async {
    String? savedLang = await LocalStorageService.loadData(
        key: StorageKeysConstants.localeLang, type: DataTypes.string);

    if (savedLang != null) {
      currentLang = Locale(savedLang);
    }
  }
}

enum TranslationLanguages {
  english,
  arabic,
  french, // Added French language
}
