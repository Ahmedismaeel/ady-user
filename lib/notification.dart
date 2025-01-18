import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_sixvalley_ecommerce/firebase_options.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description:
      'This channel is used for important notifications.', // description
  importance: Importance.max,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
final StreamController<ReceivedNotification> didReceiveLocalNotificationStream =
    StreamController<ReceivedNotification>.broadcast();

final StreamController<String?> selectNotificationStream =
    StreamController<String?>.broadcast();

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // ignore: avoid_print
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  print('notification action tapped with input: ${notificationResponse.input}');
  // if (MyApp.navKey.currentState?.context != null) {
  //   NotificationModel notificationModel = NotificationModel.fromJson(
  //       json.decode(notificationResponse.payload ?? "{}"));
  //   switch (notificationModel.module) {
  //     case "TASK":
  //       TaskDetails(
  //         taskId: int.tryParse(notificationModel.entity_id ?? "") ?? 0,
  //       ).launch(MyApp.navKey.currentState!.context,
  //           pageRouteAnimation: PageRouteAnimation.Fade);
  //       break;
  //     case "PROJECT":
  //       ProjectDetailsView(
  //         projectId: int.tryParse(notificationModel.entity_id ?? "") ?? 0,
  //       ).launch(MyApp.navKey.currentState!.context,
  //           pageRouteAnimation: PageRouteAnimation.Fade);
  //       break;
  //     case "LEAD":
  //       LeadDetails(
  //         leadId: int.tryParse(notificationModel.entity_id ?? "") ?? 0,
  //       ).launch(MyApp.navKey.currentState!.context,
  //           pageRouteAnimation: PageRouteAnimation.Fade);
  //       break;

  //     default:
  //   }
  // }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  AndroidNotification? android = message.notification?.android;
  flutterLocalNotificationsPlugin.show(
      Random().nextInt(100),
      // message.data['description'],
      // (message.data['title'] ?? "") + " " + (message.data['body'] ?? ""),
      message.data['title'] ?? "",
      message.data['body'] ?? "",
      NotificationDetails(
          android: AndroidNotificationDetails(
        channel.id, channel.name,
        channelDescription: channel.description,
        importance: Importance.max,
        priority: Priority.high,
        icon: android?.smallIcon,
        groupKey: null,
        largeIcon: DrawableResourceAndroidBitmap('notification_icon'),
        // other properties...
      )),
      payload: json.encode(message.data));
}

// Future<String> _downloadAndSaveFile(String url, String fileName) async {
//   final Directory directory = await getApplicationDocumentsDirectory();
//   final String filePath = '${directory.path}/$fileName';
//   final http.Response response = await http.get(Uri.parse(url));
//   final File file = File(filePath);
//   await file.writeAsBytes(response.bodyBytes);
//   return filePath;
// }
//  final String largeIconPath =
//         await _downloadAndSaveFile('https://dummyimage.com/48x48', 'largeIcon');
//     final String bigPicturePath = await _downloadAndSaveFile(
//         'https://dummyimage.com/400x800', 'bigPicture');
//     final BigPictureStyleInformation bigPictureStyleInformation =
//         BigPictureStyleInformation(FilePathAndroidBitmap(bigPicturePath),
//             largeIcon: FilePathAndroidBitmap(largeIconPath),
//             contentTitle: 'overridden <b>big</b> content title',
//             htmlFormatContentTitle: true,
//             summaryText: 'summary <i>text</i>',
//             htmlFormatSummaryText: true);
//     final AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails(
//             'big text channel id', 'big text channel name',
//             channelDescription: 'big text channel description',
//             styleInformation: bigPictureStyleInformation);
//     final NotificationDetails notificationDetails =
//         NotificationDetails(android: androidNotificationDetails);

Future<void> notificationInit() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  final NotificationAppLaunchDetails? notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    // var selectedNotificationPayload =
    //     notificationAppLaunchDetails!.notificationResponse?.payload;
    // initialRoute = SecondPage.routeName;
  }

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('notification_icon');

  final List<DarwinNotificationCategory> darwinNotificationCategories =
      <DarwinNotificationCategory>[
    DarwinNotificationCategory(
      "darwinNotificationCategoryText",
      actions: <DarwinNotificationAction>[
        DarwinNotificationAction.text(
          'text_1',
          'Action 1',
          buttonTitle: 'Send',
          placeholder: 'Placeholder',
        ),
      ],
    ),
    DarwinNotificationCategory(
      "darwinNotificationCategoryPlain",
      actions: <DarwinNotificationAction>[
        DarwinNotificationAction.plain('id_1', 'Action 1'),
        DarwinNotificationAction.plain(
          'id_2',
          'Action 2 (destructive)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.destructive,
          },
        ),
        DarwinNotificationAction.plain(
          "navigationActionId",
          'Action 3 (foreground)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.foreground,
          },
        ),
        DarwinNotificationAction.plain(
          'id_4',
          'Action 4 (auth required)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.authenticationRequired,
          },
        ),
      ],
      options: <DarwinNotificationCategoryOption>{
        DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
      },
    )
  ];

  final DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
    onDidReceiveLocalNotification:
        (int id, String? title, String? body, String? payload) async {
      didReceiveLocalNotificationStream.add(
        ReceivedNotification(
          id: id,
          title: title,
          body: body,
          payload: payload,
        ),
      );
    },
    notificationCategories: darwinNotificationCategories,
  );

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
    macOS: initializationSettingsDarwin,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse:
        (NotificationResponse notificationResponse) {
      "onClick ${notificationResponse.payload}".log();
      // if (MyApp.navKey.currentState?.context != null) {
      //   "navigator key not eq ${notificationResponse.payload}".log();
      //   NotificationModel notificationModel = NotificationModel.fromJson(
      //       json.decode(notificationResponse.payload ?? "{}"));
      //   switch (notificationModel.module) {
      //     case "TASK":
      //       TaskDetails(
      //         taskId: int.tryParse(notificationModel.entity_id ?? "") ?? 0,
      //       ).launch(MyApp.navKey.currentState!.context,
      //           pageRouteAnimation: PageRouteAnimation.Fade);
      //       break;
      //     case "PROJECT":
      //       ProjectDetailsView(
      //         projectId: int.tryParse(notificationModel.entity_id ?? "") ?? 0,
      //       ).launch(MyApp.navKey.currentState!.context,
      //           pageRouteAnimation: PageRouteAnimation.Fade);
      //       break;
      //     case "LEAD":
      //       LeadDetails(
      //         leadId: int.tryParse(notificationModel.entity_id ?? "") ?? 0,
      //       ).launch(MyApp.navKey.currentState!.context,
      //           pageRouteAnimation: PageRouteAnimation.Fade);
      //       break;

      //     default:
      //   }

      // try {
      //   PayloadModel model = PayloadModel.fromJson(
      //       json.decode("${notificationResponse.payload}"));
      //   TaskDetails(
      //     taskId:
      //         json.decode(notificationResponse.payload ?? "{}")["task_id"] ??
      //             0,
      //   ).launch(MyApp.navKey.currentState!.context,
      //       pageRouteAnimation: PageRouteAnimation.Fade);
      // } catch (e) {
      //   "failed ".log();
      // }
      // }
    },
    onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    AndroidNotification? android = message.notification?.android;
    "notification log onMessage ${message.data} ${message.data['title']}".log();
    // NotificationModel notificationModel =
    //     NotificationModel.fromJson(json.decode("${message.data}"));
    "loading ".log();
    flutterLocalNotificationsPlugin.show(
        Random().nextInt(100),
        // message.data['description'],
        // (message.data['title'] ?? "") + " " + (message.data['body'] ?? ""),
        message.data['title'] ?? "",
        message.data['body'] ?? "",
        NotificationDetails(
            android: AndroidNotificationDetails(
          channel.id, channel.name,
          channelDescription: channel.description, importance: Importance.max,
          priority: Priority.high,
          icon: android?.smallIcon,
          groupKey: null,
          largeIcon: DrawableResourceAndroidBitmap('notification_icon'),
          // other properties...
        )),
        payload: json.encode(message.data));
    // flutterLocalNotificationsPlugin.show(
    //     Random().nextInt(100),
    //     message.notification?.title,
    //     message.notification?.body,
    //     NotificationDetails(
    //         android: AndroidNotificationDetails(
    //       channel.id,
    //       channel.name,
    //       channelDescription: channel.description,
    //       icon: android?.smallIcon,
    //       // other properties...
    //     )));
  });
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    AndroidNotification? android = message.notification?.android;
    // NotificationModel notificationModel =
    //     NotificationModel.fromJson(message.data);
    flutterLocalNotificationsPlugin.show(
        Random().nextInt(100),
        // message.data['description'],
        // (message.data['title'] ?? "") + " " + (message.data['body'] ?? ""),
        message.data['title'] ?? "",
        message.data['body'] ?? "",
        NotificationDetails(
            android: AndroidNotificationDetails(
          channel.id, channel.name,
          channelDescription: channel.description, importance: Importance.max,
          priority: Priority.high,
          icon: android?.smallIcon,
          largeIcon: DrawableResourceAndroidBitmap('notification_icon'),
          groupKey: null,
          // other properties...
        )),
        payload: json.encode(message.data));
  });
}
