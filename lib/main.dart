import 'package:cars/app/core/styles/theme_styles.dart';
import 'package:cars/app/core/utils/theme_util.dart';
import 'package:cars/app/core/utils/translation_util.dart';
import 'package:cars/app/core/utils/translations/translation.dart';
import 'package:cars/app/core/utils/translations/translations_assets_reader.dart';
import 'package:cars/app/modules/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app/routes/app_pages.dart';

import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TranslationsAssetsReader.initialize();
  await TranslationUtil.initialize();
  await ThemeUtil.initialize();
  Get.put(UserController(), permanent: true);

  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );

  runApp(
    ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          // onInit: () async {
          // Future.delayed(const Duration(microseconds: 500), () {
          // // print("::::::::::::::::::::::::::::::: iam splash secreen");
          // // LocalNotificationService.showNotification(title: "test", body: "test notification");
          // FlutterNativeSplash.remove();
          // }
          // );
          // },

          transitionDuration: const Duration(milliseconds: 1000),
          defaultTransition: Transition.circularReveal,
          debugShowCheckedModeBanner: false,
          title: "GIM DZ",
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          translations: Translation(),
          locale: TranslationUtil.currentLang,
          fallbackLocale: TranslationUtil.currentLang,
          themeMode: ThemeUtil.currentTheme,
          theme: ThemeStyles.lightTheme,
          darkTheme: ThemeStyles.darkTheme,
        );
      },
    ),
  );
}
