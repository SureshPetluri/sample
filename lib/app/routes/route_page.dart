import 'package:go_router/go_router.dart';
import 'package:sample/features/assistant/home/presentation/pages/home_page.dart';
import 'package:sample/features/dashboard/presentation/pages/dashboard_page.dart';

import '../../features/assistant/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/assistant/services/presentation/pages/service_page.dart';
import '../../features/groceries/brands/presentation/pages/brands_page.dart';
import '../../features/groceries/categories/presentation/pages/categories_page.dart';
import '../../features/groceries/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/groceries/home/presentation/pages/home_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import 'app_routes.dart';

final GoRouter router = GoRouter(
  initialLocation: AppRoutes.groceriesHome,
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return DashBoardPage(child: child);
      },
      routes: [
        // Groceries Feature Branch
        ShellRoute(
          builder: (context, state, child) =>
              GroceriesDashBoardPage(child: child),
          routes: [
            GoRoute(
              name: "GroceriesHome",
              path: AppRoutes.groceriesHome,
              builder: (context, state) => const GroceriesHomePage(),
            ),
            GoRoute(
              name: "Brands",
              path: AppRoutes.brands,
              builder: (context, state) => const BrandsPage(),
            ),
            GoRoute(
              name: "Categories",
              path: AppRoutes.categories,
              builder: (context, state) => const CategoriesPage(),
            ),
          ],
        ),
        // Assistant Feature Branch
        ShellRoute(
          builder: (context, state, child) =>
              AssistantDashBoardScreen(child: child),
          routes: [
            GoRoute(
              name: "AssistanceHome",
              path: AppRoutes.assistantHome,
              builder: (context, state) => const AssistantHomeScreen(),
            ),
            GoRoute(
              name: "Services",
              path: AppRoutes.services,
              builder: (context, state) =>
                  const ServiceScreen(), // Matches original logic
            ),
          ],
        ),

        // Profile
      ],
    ),
    GoRoute(
      name: "Profile",
      path: AppRoutes.profile,
      builder: (context, state) => const ProfilePage(),
    ),
  ],
);
