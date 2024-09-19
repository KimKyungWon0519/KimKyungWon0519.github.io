import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kkw_blog/src/core/routes/app_pages.dart';
import 'package:kkw_blog/src/core/values/theme.dart';
import 'package:responsive_builder/responsive_builder.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        Size size = ScreenUtil.defaultSize;

        if (sizingInformation.isDesktop) {
          size = const Size(1440, 1024);
        } else if (sizingInformation.isMobile) {
          size = const Size(360, 1024);
        }

        return ScreenUtilInit(
          designSize: size,
          builder: (context, child) => MaterialApp.router(
            theme: lightThemeData,
            darkTheme: darkThemeData,
            themeMode: ThemeMode.light,
            routerConfig: AppPages.routeConfigs,
          ),
        );
      },
    );
  }
}
