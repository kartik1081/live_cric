import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:live_cric/utils/remote_configs.dart';
import 'package:live_cric/utils/routes.dart';
import 'package:live_cric/utils/theme/app_theme.dart';
import 'package:nb_utils/nb_utils.dart' as nb;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  nb.initialize();
  RemoteConfigs.initConfig();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

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
        onGenerateRoute: (settings) => Routes.onGenerateRoute(settings),
      ),
    );
  }
}
