import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:notif/controllers/fcm_controller.dart';
import 'package:notif/mixins/cache_mixin.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initLocalNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const darwinInitializationSettings = DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: darwinInitializationSettings,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

class NotificationService {
  static Future<void> showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'com_example_notif_channel',
      'com_example_notif_channel_1',
      priority: Priority.high,
      importance: Importance.max,
    );

    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails();

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      "${message.notification?.title}",
      "${message.notification?.body}",
      platformChannelSpecifics,
      payload: message.data['body'],
    );
  }
}

void onDidReceiveLocalNotification(
  int id,
  String? title,
  String? body,
  String? payload,
) async {
  /*showDialog(
    //context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text(title ?? ""),
      content: Text(body ?? ""),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () async {
            Navigator.of(context, rootNavigator: true).pop();
            Get.offAllNamed(Routes.home);
          },
          child: const Text('Ok'),
        ),
      ],
    ),
  );*/
}

class FCMService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final box = GetStorage();
  final _fcmController = Get.find<FcmController>();

  Future<void> setupFCM() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    //_firebaseMessaging.subscribeToTopic('your_topic');

    String? storedToken = box.read(CacheManagerKey.fcmToken.toString());
    if (storedToken == null) {
      String? fcmToken = await _firebaseMessaging.getToken();
      if (fcmToken != null) {
        await box.write('fcmToken', fcmToken);
        await _fcmController.storeToken(fcmToken);
      }
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Handle foreground messages
      print('Received foreground message: $message');
      // Show local notification using flutter_local_notifications
    });

    //FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Handle when app is opened from background
      print('Opened app from background with message: $message');
    });
  }

/*Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // Handle background messages
    print('Received background message: $message');
    // Show local notification using flutter_local_notifications
  }*/
}
