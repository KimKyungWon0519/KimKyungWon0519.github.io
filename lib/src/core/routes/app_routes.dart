import 'package:go_router/go_router.dart';
import 'package:kkw_blog/src/presentation/pages/main_page/main_page.dart';

final class AppRoutes {
  const AppRoutes._();

  static final GoRoute main = GoRoute(
    path: '/',
    name: 'main',
    builder: (context, state) => const MainPage(),
  );

  static final List<RouteBase> routes = [
    main,
  ];
}
