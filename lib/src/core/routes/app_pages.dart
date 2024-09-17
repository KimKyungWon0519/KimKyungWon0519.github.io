import 'package:go_router/go_router.dart';
import 'package:kkw_blog/src/core/routes/app_routes.dart';

final class AppPages {
  const AppPages._();

  static const String _initialLocation = '/';

  static final GoRouter routeConfigs = GoRouter(
    routes: AppRoutes.routes,
    initialLocation: _initialLocation,
  );
}
