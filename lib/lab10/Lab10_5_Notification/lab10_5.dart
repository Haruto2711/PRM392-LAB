import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin
    notifications =
    FlutterLocalNotificationsPlugin();

void runLab10_5() async {

  WidgetsFlutterBinding.ensureInitialized();

  const AndroidInitializationSettings
      androidSettings =
      AndroidInitializationSettings(
    '@mipmap/ic_launcher',
  );

  const InitializationSettings
      settings =
      InitializationSettings(
    android: androidSettings,
  );

  await notifications.initialize(
    settings: settings,
  );

  runApp(
    const NotificationApp(),
  );
}

class NotificationApp
    extends StatelessWidget {

  const NotificationApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner:
          false,
      home:
          const NotificationScreen(),
    );
  }
}

class NotificationScreen
    extends StatefulWidget {

  const NotificationScreen({
    super.key,
  });

  @override
  State<NotificationScreen>
      createState() =>
          _NotificationScreenState();
}

class _NotificationScreenState
    extends State<NotificationScreen> {

  Future<void>
      requestPermission() async {

    notifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  Future<void>
      showNotification() async {

    const AndroidNotificationDetails
        androidDetails =
        AndroidNotificationDetails(
      'lab10_channel',
      'Lab10 Notifications',

      channelDescription:
          'Notification Demo',

      importance:
          Importance.max,

      priority:
          Priority.high,
    );

    const NotificationDetails
        details =
        NotificationDetails(
      android: androidDetails,
    );

    await notifications.show(
      id: 0,
      title: 'Lab 10 Notification',
      body: 'Hello from Flutter Local Notification!',
      notificationDetails: details,
    );
  }

  @override
  void initState() {
    super.initState();

    requestPermission();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lab10 Notification',
        ),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [

            const Icon(
              Icons.notifications,
              size: 100,
              color: Colors.orange,
            ),

            const SizedBox(
                height: 20),

            const Text(
              'Local Notification Demo',
              style: TextStyle(
                fontSize: 22,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
                height: 30),

            ElevatedButton.icon(
              onPressed:
                  showNotification,

              icon: const Icon(
                Icons.send,
              ),

              label: const Text(
                'SHOW NOTIFICATION',
              ),
            ),
          ],
        ),
      ),
    );
  }
}