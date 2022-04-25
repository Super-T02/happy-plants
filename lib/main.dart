// Firebase
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:happy_plants/screens/authenticate/forget_password.dart';
import 'package:happy_plants/screens/authenticate/sign_up_form.dart';
import 'package:happy_plants/screens/home/tabs/garden/new_garden.dart';
import 'package:happy_plants/screens/wrapper.dart';
import 'package:happy_plants/services/authentication.dart';
import 'package:happy_plants/shared/models/received_notification.dart';
import 'package:happy_plants/shared/models/user.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'config.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';


// Flutter
import 'package:flutter/material.dart';
import 'package:happy_plants/shared/utilities/theme.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// Settings for the notification class
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

/// Streams are created so that app can respond to notification-related events
/// since the plugin is initialised in the `main` function
final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject = BehaviorSubject<ReceivedNotification>();

final BehaviorSubject<String?> selectNotificationSubject = BehaviorSubject<String?>();

const MethodChannel platform = MethodChannel('dexterx.dev/flutter_local_notifications_example');

String? selectedNotificationPayload;

/// Start the app
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();

  // Load firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

/// Main (root) widget
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    currentTheme.addListener(() {
      setState(() {});
    });
    super.initState();
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
          '/': (context) => const Wrapper(),
          '/newGarden': (context) => const NewGarden(),
          '/forgetPassword': (context) => const ForgetPassword(),
          '/signUp': (context) => const SignUpForm(),
        },
      ),
    );
  }
}


