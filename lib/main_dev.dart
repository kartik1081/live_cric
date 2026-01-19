import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:live_cric/firebase_options.dart';
import 'package:live_cric/utils/flaove_config.dart';
import 'package:live_cric/utils/notification_service.dart';
import 'package:live_cric/utils/remote_configs.dart';
import 'package:live_cric/utils/routes.dart';
import 'package:live_cric/utils/theme/app_theme.dart';
import 'package:nb_utils/nb_utils.dart' as nb;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlavorConfig.setFlavor(FlavorEnum.dev);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await nb.initialize();
  await RemoteConfigs.initConfig();
  await MobileAds.instance.initialize();
  await NotificationService.flutterLocalNotificationInit();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(systemNavigationBarContrastEnforced: false),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(402, 874),
      builder: (context, child) => MaterialApp(
        title: RemoteConfigs.appNameRc,
        theme: AppTheme.lightTheme,
        initialRoute: Routes.splashRt,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (settings) => Routes.onGenerateRoute(settings),
      ),
    );
  }
}
