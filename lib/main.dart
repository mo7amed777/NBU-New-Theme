import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'app/data/local/my_shared_pref.dart';
import 'app/routes/app_pages.dart';
import 'config/theme/my_theme.dart';
import 'config/translations/localization_service.dart';

Future<void> main() async {
  // wait for bindings
  WidgetsFlutterBinding.ensureInitialized();
  // init shared preference
  await MySharedPref.init();
  MySharedPref.setCurrentLanguage('ar');
  // await Upgrader.clearSavedSettings();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(RestartWidget(child: MyApp())));
}

/// Widget to allow restarting the app
class RestartWidget extends StatefulWidget {
  final Widget child;

  RestartWidget({required this.child});

  // Call this method to restart the app
  static void restartApp(BuildContext context) {
    final _RestartWidgetState? state =
        context.findAncestorStateOfType<_RestartWidgetState>();
    state?.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey(); // Forces the entire app to rebuild
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key, // KeyedSubtree triggers rebuild when the key changes
      child: widget.child,
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      builder: (context, widget) {
        return GetMaterialApp(
          title: "NBU E-Services",
          debugShowCheckedModeBanner: false,
          useInheritedMediaQuery: true,
          builder: (context, widget) {
            bool isGrayscale = MySharedPref.getIsGrayscale();
            return Theme(
              data: appThemeData,
              child: ColorFiltered(
                colorFilter: isGrayscale
                    ? ColorFilter.matrix(<double>[
                        0.2126,
                        0.7152,
                        0.0722,
                        0,
                        0,
                        0.2126,
                        0.7152,
                        0.0722,
                        0,
                        0,
                        0.2126,
                        0.7152,
                        0.0722,
                        0,
                        0,
                        0,
                        0,
                        0,
                        1,
                        0,
                      ])
                    : ColorFilter.mode(Colors.transparent, BlendMode.multiply),
                child: MediaQuery.withNoTextScaling(
                  // prevent font scaling (some people use big/small device fonts)
                  // but we want our app font to remain the same and not get affected
                  child: SafeArea(child: widget!),
                ),
              ),
            );
          },
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          locale: MySharedPref.getCurrentLocal(),
          textDirection: TextDirection.rtl,
          translations:
              LocalizationService(), // localization services in app (controller app language)
        );
      },
    );
  }
}
