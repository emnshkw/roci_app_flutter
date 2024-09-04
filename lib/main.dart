import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';
import 'package:roci_app/pages/main_page.dart';
import "package:awesome_notifications/awesome_notifications.dart";

MaterialApp MyApp() {

  return MaterialApp(
    theme: ThemeData(
        fontFamily: 'Ubuntu',
        primaryColor: Color(0xffBAEE68),
        colorScheme: const ColorScheme.light(
          primary: Color(0xffBAEE68),
        ),
        scrollbarTheme: ScrollbarThemeData(
            thumbVisibility: MaterialStateProperty.all(true),
            thickness: MaterialStateProperty.all(7),
            thumbColor: MaterialStateProperty.all(const Color(0xffBAEE68)),
            radius: const Radius.circular(10),
            minThumbLength: 100)),
    localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: const [
      Locale('ru', 'RU'),
    ],
    initialRoute: '/main_page',
    routes: {'/main_page': (context) => MainPage()},
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Step 3
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(MyApp()));
  // runApp(MyApp());
  AwesomeNotifications().initialize(
    null,
      // 'resourse://@mipmap/ic_launcher',
      [
        NotificationChannel(
          channelKey: "roci_channel",
          channelName: 'Уведомления Roci',
          channelDescription: "Получайте уведомления о новых конкурсах!",
          defaultColor: Color(0xffBAEE68),
          ledColor: Colors.white,
          importance: NotificationImportance.Max,
          channelShowBadge: true,
          onlyAlertOnce: true,
          criticalAlerts: true
        )
      ],
      debug: false);
  runApp(MyApp());
}
