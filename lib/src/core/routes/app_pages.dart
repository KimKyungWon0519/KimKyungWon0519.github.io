import 'package:go_router/go_router.dart';
import 'package:kkw_blog/src/core/routes/app_routes.dart';

final class AppPages {
  const AppPages._();

  static final String _initialLocation = AppRoutes.main.path;

  static final GoRouter routeConfigs = GoRouter(
    routes: AppRoutes.routes,
    initialLocation: _initialLocation,
  );
}
