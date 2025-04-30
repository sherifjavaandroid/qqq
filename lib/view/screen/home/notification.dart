import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart';
import 'package:timezone/tzdata.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

// class Noti {
//   static final FlutterLocalNotificationsPlugin
//       _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//   static Future<void> onDidReceiveNotificationResponse(
//       NotificationResponse notificationResponse) async {}
//   //static final onclick = BehaviorSubject();
//   // final localLocation = tz.getLocation('America/Detroit'); // Replace with your desired time zone
//   // final scheduledTime = TZDateTime.from(DateTime.now(), tz.local);

//   static Future<void> init() async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     final DarwinInitializationSettings initializationSettingsDarwin =
//         DarwinInitializationSettings(
//             onDidReceiveLocalNotification: (id, title, body, payload) => null);

//     final LinuxInitializationSettings initializationSettingsLinux =
//         LinuxInitializationSettings(defaultActionName: 'Open notification');

//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//             android: initializationSettingsAndroid,
//             iOS: initializationSettingsDarwin,
//             linux: initializationSettingsLinux);

//     await _flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveBackgroundNotificationResponse:
//           onDidReceiveNotificationResponse,
//       onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
//     );
//     await _flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.requestNotificationsPermission();
//   }

//   static Future<void> showSimpleNotification({
//     required String title,
//     required String body,
//     String? payload,
//   }) async {
//     const AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails('your_channel_id', 'your_channel_name',
//             channelDescription: 'your channel description',
//             importance: Importance.max,
//             priority: Priority.high,
//             ticker: 'ticker');

//     const NotificationDetails notificationDetails =
//         NotificationDetails(android: androidNotificationDetails);

//     await _flutterLocalNotificationsPlugin.show(
//       0,
//       title,
//       body,
//       notificationDetails,
//       payload: payload,
//     );
//   }

//   static Future showPerodicNotifiaction({
//     required String title,
//     required String body,
//     String? payload,
//   }) async {
//     const AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails('channel2', 'your_channel_name',
//             channelDescription: 'your channel description',
//             importance: Importance.max,
//             priority: Priority.high,
//             ticker: 'ticker');

//     const NotificationDetails notificationDetails =
//         NotificationDetails(android: androidNotificationDetails);
//     await _flutterLocalNotificationsPlugin.periodicallyShow(
//         1, title, body, RepeatInterval.everyMinute, notificationDetails);
//   }

//   static Future showShedwellNotifiaction({
//     required String title,
//     required String body,
//     String? payload,
//     required DateTime shedelltime,
//   }) async {
//     const AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails('channel2', 'your_channel_name',
//             channelDescription: 'your channel description',
//             importance: Importance.max,
//             priority: Priority.high,
//             ticker: 'ticker');

//     const NotificationDetails notificationDetails =
//         NotificationDetails(android: androidNotificationDetails);
//     await _flutterLocalNotificationsPlugin.zonedSchedule(
//       0,
//       title,
//       body,
//       TZDateTime.from(shedelltime, getLocation('Africa/Cairo')),
//       notificationDetails,
//       uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.absoluteTime,
//       matchDateTimeComponents: DateTimeComponents.dateAndTime,
//       androidAllowWhileIdle: true,
//     );
//   }

//   static Future Cancel(int id) async {
//     await _flutterLocalNotificationsPlugin.cancel(id);
//   }
// }
class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> showNotification(String title, String body,
      {String channelId = 'default_channel_id',
      String channelName = 'Default Channel'}) async {
    // Set the Android notification channel details
    const androidDetails = AndroidNotificationDetails(
      'channel_id', // Channel ID (default can be overridden)
      'channel_name', // Channel name (default can be overridden)
      channelDescription: 'Booking notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    // Set platform-specific notification details
    const platformDetails = NotificationDetails(android: androidDetails);

    // Show the notification
    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      title,
      body,
      platformDetails,
    );
  }

  // Call this method to create a notification channel
  Future<void> createNotificationChannel(
      String channelId, String channelName, String channelDescription) async {
    final AndroidNotificationChannel channel = AndroidNotificationChannel(
      channelId,
      channelName,
      description: channelDescription,
      importance: Importance.max,
      playSound: true,
    );

    // Create the channel in the Android system
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }
}
