import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("background message: ${message.messageId}");
  // Handle the background notification here.
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController textEditingController = TextEditingController();
  final TextEditingController titleTextEditingController =
      TextEditingController();
  final TextEditingController bodyTextEditingController =
      TextEditingController();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FirebaseFirestore _firebaseStore = FirebaseFirestore.instance;

  final TextEditingController _controller = TextEditingController();
  StreamSubscription<RemoteMessage>? streamSubscription;

  String? fcmToken = '';
  bool submitted = false;

  void reqPerm() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    switch (settings.authorizationStatus) {
      case AuthorizationStatus.authorized:
        print('permission granted');
        break;
      case AuthorizationStatus.denied:
        print('permission denied');
        break;
      case AuthorizationStatus.notDetermined:
        print('permission not determined');
        break;
      case AuthorizationStatus.provisional:
        print('permission provisional');
        break;
    }
  }

  void getToken() async {
    _firebaseMessaging.getToken().then((String? token) {
      setState(() {
        fcmToken = token;
      });
    });
  }

  void storeToken(String token) async {
    _firebaseStore
        .collection('Tokens')
        .doc(textEditingController.text.trim())
        .set({'token': token});
  }

  @override
  void initState() {
    super.initState();
    reqPerm();
    getToken();

    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    DarwinInitializationSettings iosInitialization =
        const DarwinInitializationSettings();
    InitializationSettings initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitialization);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    streamSubscription =
        FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print(
          '========================================================= firebase on message ============================================================');
      print('title: ${message.notification?.title}');
      print('body: ${message.notification?.body}');
      await _showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("message opened: ${message.notification?.title}");
    });
  }

  Future<void> _showNotification(RemoteMessage message) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'com_example_notif_channel',
      'com_example_notif_channel_1',
      priority: Priority.high,
      importance: Importance.max,
    );

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
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

  @override
  void dispose() {
    streamSubscription?.cancel();
    textEditingController.dispose();
    super.dispose();
  }

  Future<void> _subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
  }

  Future<void> _unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
  }

  Future<void> _sendNotification(
    String token,
    String title,
    String body,
  ) async {
    try {
      // in test only, this use legacy FCM server,
      // I don't have time to setup notification server
      // for this test purposes
      await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
                'key=AAAA56eM9Fg:APA91bF3epa7MuJUPYQRgyWyEEQSt_1oI9yEtsRxdCBnSLH_5yrNlVOF1c2zHdNbH-mQZGZUEEVugt4hIiEuq9gyPR10rAygQUu-cTwjFsBQQ2LVmZT4sAA0RTJCtSXPPyda6VhkfP5Y'
          },
          body: jsonEncode({
            'priority': 'high',
            'data': {'title': title, 'body': body},
            'notification': {
              'title': title,
              'body': body,
              'android_channel_id': 'com_example_notif_channel',
            },
            'to': token
          }));
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notif Example'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Username',
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.grey),
              ),
            ),
            //readOnly: !submitted,
            controller: textEditingController,
          ),
          const Text(
            'available value, "u1" or "u2"',
            style: TextStyle(fontSize: 12),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            child: const Text('Register Device'),
            onPressed: () async {
              if (fcmToken != null) {
                storeToken(fcmToken as String);
                setState(() {
                  submitted:
                  true;
                });
              }
            },
          ),
          const SizedBox(height: 32.0),
          TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Notif Title',
              disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.grey)),
            ),
            //readOnly: !submitted,
            controller: titleTextEditingController,
          ),
          const SizedBox(height: 16.0),
          TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Notif Body',
              disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.grey)),
            ),
            //readOnly: !submitted,
            controller: bodyTextEditingController,
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            child: const Text('Send Notif'),
            onPressed: () async {
              if (fcmToken != null) {
                String title = titleTextEditingController.text;
                String body = bodyTextEditingController.text;
                String user = textEditingController.text.trim();
                DocumentSnapshot snap = await _firebaseStore
                    .collection('Tokens')
                    .doc(user == 'u1' ? 'u2' : 'u1')
                    .get();
                String token = snap['token'];
                _sendNotification(token, title, body);
                setState(() {
                  submitted:
                  true;
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
