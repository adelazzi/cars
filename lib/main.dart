import 'dart:developer';

import 'package:cars/app/core/constants/storage_keys_constants.dart';
import 'package:cars/app/core/services/local_notification_service.dart';
import 'package:cars/app/core/services/local_storage_service.dart';
import 'package:cars/app/core/styles/theme_styles.dart';
import 'package:cars/app/core/utils/theme_util.dart';
import 'package:cars/app/core/utils/translation_util.dart';
import 'package:cars/app/core/utils/translations/translation.dart';
import 'package:cars/app/core/utils/translations/translations_assets_reader.dart';
import 'package:cars/app/modules/user_controller.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

late final FirebaseMessaging _messaging;
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Background message received: ${message.notification?.title}');
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Future<void> requestAndRegisterNotification() async {
  await Firebase.initializeApp();

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  _messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await _messaging.requestPermission(
    alert: true,
    badge: true,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission for notifications');

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    try {
      String? token = await _messaging.getToken();

      print("FCM Token: $token");
      print("Firebase Token: $token");

      if (await LocalStorageService.loadData(
              key: StorageKeysConstants.fcmToken, type: DataTypes.string) ==
          null) {
        LocalStorageService.saveData(
          key: StorageKeysConstants.fcmToken,
          type: DataTypes.string,
          value: token,
        );
      }
    } catch (e) {
      print("Error fetching FCM Token: $e");
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Message received: ${message.notification?.title}');
// TODO :  manage this for all notification tyme , dialog , notification , .......
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body != null && notification.body!.startsWith('{')
              ? 'You have a new notification'
              : notification.body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'delivary_fr_app',
              'delivary_fr_app',
              channelDescription: 'delivary_fr_app',
              importance: Importance.max,
              priority: Priority.high,
            ),
          ),
        );
        log(notification.title ?? 'No title');
        log(notification.body ?? 'No body');
      }
    });
  } else {
    print('User denied or has not granted permission for notifications');
  }
}

Future<void> initializeLocalNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TranslationsAssetsReader.initialize();
  await TranslationUtil.initialize();
  await ThemeUtil.initialize();
  await requestAndRegisterNotification();
  LocalNotificationService.initialize();
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
          title: "CAR DZ",
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
