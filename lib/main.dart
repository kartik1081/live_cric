import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:live_cric/firebase_options.dart';
import 'package:live_cric/utils/remote_configs.dart';
import 'package:live_cric/utils/routes.dart';
import 'package:live_cric/utils/theme/app_theme.dart';
import 'package:nb_utils/nb_utils.dart' as nb;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  nb.initialize();
  RemoteConfigs.initConfig();
  MobileAds.instance.initialize();
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
        title: 'LiveCric',
        theme: AppTheme.lightTheme,
        initialRoute: Routes.splashRt,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (settings) => Routes.onGenerateRoute(settings),
      ),
    );
  }
}
