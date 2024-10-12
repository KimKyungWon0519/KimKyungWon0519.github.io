import 'package:go_router/go_router.dart';
import 'package:kkw_blog/resource/l10n/generated/l10n.dart';
import 'package:kkw_blog/src/core/routes/app_routes.dart';
import 'dart:html' as html;

final class AppPages {
  const AppPages._();

  static final String _initialLocation = AppRoutes.main.path;

  static final GoRouter routeConfigs = GoRouter(
    routes: AppRoutes.routes,
    initialLocation: _initialLocation,
    redirect: (context, state) {
      if (state.fullPath == '/') {
        html.document.title = Messages.of(context).blogTitle;
      }

      return null;
    },
  );
}
