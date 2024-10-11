import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kkw_blog/resource/l10n/generated/l10n.dart';
import 'package:kkw_blog/src/core/constants/supabase.dart';
import 'package:kkw_blog/src/core/riverpods/theme_mode_notifier.dart';
import 'package:kkw_blog/src/core/routes/app_pages.dart';
import 'package:kkw_blog/resource/values/theme.dart';
import 'package:kkw_blog/src/dependency_injection.dart' as DI;
import 'package:responsive_builder/responsive_builder.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  usePathUrlStrategy();

  GoRouter.optionURLReflectsImperativeAPIs = true;

  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseKey,
  );

  await initializeDateFormatting();

  DI.initializeDI();

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
          builder: (context, child) => const _MyMaterialApp(),
        );
      },
    );
  }
}

class _MyMaterialApp extends ConsumerWidget {
  const _MyMaterialApp();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _intializeThemeMode(context, ref);

    return MaterialApp.router(
      localizationsDelegates: const [
        Messages.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: Messages.delegate.supportedLocales,
      theme: AppTheme.lightTheme,
      highContrastTheme: AppTheme.lightHighContrastThemeData,
      darkTheme: AppTheme.darkTheme,
      highContrastDarkTheme: AppTheme.darkHighContrastThemeData,
      themeMode: ref.watch(themeModeNotifierProvider),
      routerConfig: AppPages.routeConfigs,
    );
  }

  void _intializeThemeMode(BuildContext context, WidgetRef ref) {
    if (ref.read(themeModeNotifierProvider) == ThemeMode.system) {
      Future(() {
        Brightness brightness = MediaQuery.of(context).platformBrightness;

        ref.read(themeModeNotifierProvider.notifier).initialize(brightness);
      });
    }
  }
}
