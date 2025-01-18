import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/dio/share_preferance.dart';
import 'package:flutter_sixvalley_ecommerce/my_app.dart';
import 'package:flutter_sixvalley_ecommerce/notification.dart';
import 'package:nb_utils/nb_utils.dart';
import 'di_container.dart' as di;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Get {
  static BuildContext? get context => navigatorKey.currentContext;
  static NavigatorState? get navigator => navigatorKey.currentState;
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

late WidgetRef homeRef;

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferenceHelper.init();
  await initialize();
  await DioClient.instance.init();
  await notificationInit();
  await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
  await di.init();
  // flutterLocalNotificationsPlugin
  //     .resolvePlatformSpecificImplementation<
  //         AndroidFlutterLocalNotificationsPlugin>()
  //     ?.requestNotificationsPermission();
  // NotificationBody? body;
  // try {
  //   final RemoteMessage? remoteMessage =
  //       await FirebaseMessaging.instance.getInitialMessage();
  //   if (remoteMessage != null) {
  //     body = NotificationHelper.convertNotification(remoteMessage.data);
  //   }
  //   await NotificationHelper.initialize(flutterLocalNotificationsPlugin);
  //   FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
  // } catch (_) {}

  // await NotificationHelper.initialize(flutterLocalNotificationsPlugin);
  // FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);

  runApp(ProviderScope(
    child: Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        homeRef = ref;
        return MyApp(
          body: null,
        );
      },
    ),
  ));
}
