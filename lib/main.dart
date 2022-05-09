import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:happy_plants/screens/authenticate/forget_password.dart';
import 'package:happy_plants/screens/authenticate/sign_up_form.dart';
import 'package:happy_plants/screens/home/tabs/garden/new_garden.dart';
import 'package:happy_plants/screens/wrapper.dart';
import 'package:happy_plants/services/authentication.dart';
import 'package:happy_plants/services/shared_preferences_controller.dart';
import 'package:happy_plants/shared/models/received_notification.dart';
import 'package:happy_plants/shared/models/user.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'config.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/material.dart';
import 'package:happy_plants/shared/utilities/theme.dart';
import 'screens/notifications/notification.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// Settings for the notification class
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

/// Streams are created so that app can respond to notification-related events
/// since the plugin is initialised in the `main` function
final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject = BehaviorSubject<ReceivedNotification>();
final BehaviorSubject<String?> selectNotificationSubject = BehaviorSubject<String?>();
String? selectedNotificationPayload;



/// Start the app
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();



  /// INIT SHARED PREFS
  sharedPreferences = await SharedPreferences.getInstance();

  /// INIT notificationNextId
  notificationNextId = SharedPreferencesController.getNotificationNextId();

  /// INIT NOTIFICATIONS
  await _configureLocalTimeZone();

  final NotificationAppLaunchDetails? notificationAppLaunchDetails = !kIsWeb && Platform.isLinux
      ? null : await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String? payload) async {
        if (payload != null) {
          debugPrint('notification payload: $payload');
        }
        selectedNotificationPayload = payload;
        selectNotificationSubject.add(payload);
      }
  );



  /// LOAD FIREBASE
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  /// START APP
  runApp(
    MyApp(notificationAppLaunchDetails: notificationAppLaunchDetails)
  );
}

/// Configures the local time Zone for the project
Future<void> _configureLocalTimeZone() async {
  if (kIsWeb || Platform.isLinux) {
    return;
  }
  tz.initializeTimeZones();
  final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName!));
}

/// Main (root) widget
class MyApp extends StatefulWidget {
  const MyApp({Key? key, this.notificationAppLaunchDetails}) : super(key: key);


  final NotificationAppLaunchDetails? notificationAppLaunchDetails;

  bool get didNotificationLaunchApp => notificationAppLaunchDetails?.didNotificationLaunchApp ?? false;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });

    // NotificationScreen stuff
    _requestPermissions();
    _configureDidReceiveLocalNotificationSubject();

  }

  /// Request notification permissions
  void _requestPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        MacOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  /// Checks if the notification arrives and gives it to the notification widget
  void _configureDidReceiveLocalNotificationSubject() {
    didReceiveLocalNotificationSubject.stream
        .listen((ReceivedNotification receivedNotification) async {
      await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: receivedNotification.title != null
              ? Text(receivedNotification.title!)
              : null,
          content: receivedNotification.body != null
              ? Text(receivedNotification.body!)
              : null,
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop();
                await Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        NotificationScreen(eventId: receivedNotification.payload),
                  ),
                );
              },
              child: const Text('Ok'),
            )
          ],
        ),
      );
    });
  }

  @override
  void dispose() {
    didReceiveLocalNotificationSubject.close();
    selectNotificationSubject.close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return StreamProvider<CustomUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        title: 'Happy Plants',
        themeMode: currentTheme.currentMode,
        theme: MyAppTheme.lightTheme,
        darkTheme: MyAppTheme.darkTheme,
        navigatorKey: navigatorKey,
        initialRoute: '/',
        routes: {
          '/': (_) => const Wrapper(),
          NotificationScreen.routeName: (context) => NotificationScreen(eventId: selectedNotificationPayload,),
          '/newGarden': (context) => const NewGarden(),
          '/forgetPassword': (context) => const ForgetPassword(),
          '/signUp': (context) => const SignUpForm(),
        },
      ),
    );
  }
}


