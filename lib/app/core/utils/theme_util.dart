// ignore_for_file: deprecated_member_use

import 'package:cars/app/core/constants/storage_keys_constants.dart';
import 'package:cars/app/core/services/local_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class ThemeUtil {
  static ThemeMode currentTheme = ThemeMode.light;

  static RxBool isDarkMode = false.obs;

  static void changeTheme({required ThemeMode theme}) {
    LocalStorageService.saveData(
        key: StorageKeysConstants.localeTheme,
        value: (theme == ThemeMode.light) ? 'dark' : 'light',
        type: DataTypes.string);
    isDarkMode(theme == ThemeMode.light);
    Get.changeThemeMode(theme);
    currentTheme = theme;
  }

  static Future<void> initialize() async {
    if (await LocalStorageService.loadData(
            key: StorageKeysConstants.localeTheme, type: DataTypes.string) !=
        null) {
      isDarkMode(await LocalStorageService.loadData(
              key: StorageKeysConstants.localeTheme, type: DataTypes.string) ==
          'dark');
      currentTheme = (await LocalStorageService.loadData(
                  key: StorageKeysConstants.localeTheme,
                  type: DataTypes.string) ==
              'dark')
          ? ThemeMode.light
          : ThemeMode.light;
    } else {
      isDarkMode(SchedulerBinding.instance.window.platformBrightness ==
          Brightness.light);
    }
  }
}
