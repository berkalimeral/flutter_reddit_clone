import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

import '../../features/screens/auth/view/login_view.dart';
import '../../features/screens/community/community_screen.dart';
import '../../features/screens/community/create_community_view.dart';
import '../../features/screens/community/edit_community_screen.dart';
import '../../features/screens/community/mod_tools_screen.dart';
import '../../features/screens/home/view/home_view.dart';

class AppRouter {
  static final loggedInRoute = RouteMap(routes: {
    '/': (route) {
      return const MaterialPage(child: HomeScreen());
    },
    '/create-community': (route) =>
        const MaterialPage(child: CreateCommunityScreen()),
    '/r/:name': (route) => MaterialPage(
          child: CommunityScreen(
            name: route.pathParameters['name']!,
          ),
        ),
    '/mod-tools/:name': (route) => MaterialPage(
          child: ModToolsScreen(
            name: route.pathParameters['name']!,
          ),
        ),
    '/edit-community/:name': (route) => MaterialPage(
          child: EditCommunityScreen(
            name: route.pathParameters['name']!,
          ),
        ),
  });

  static final loggedOutRoute = RouteMap(routes: {
    '/': (route) {
      return const MaterialPage(child: LoginScreen());
    },
  });
}
