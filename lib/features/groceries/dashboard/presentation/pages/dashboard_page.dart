import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../app/routes/app_routes.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/navigation_utils.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../providers/dashboard_provider.dart';

class GroceriesDashBoardPage extends ConsumerWidget {
  final Widget child;

  GroceriesDashBoardPage({super.key, required this.child});

  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (isWeb(context)) Text("Sample"),
            Flexible(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: isWeb(context) ? 400 : double.infinity,
                ),
                child: AppTextField(
                  hintText: "Enter your name",
                  controller: nameController,
                  prefixIcon: Icon(Icons.search),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Name cannot be empty";
                    }
                    return null;
                  },
                ),
              ),
            ),
            if (isWeb(context)) Text("Categories"),
            if (isWeb(context)) Icon(Icons.shopping_cart),
          ],
        ),
      ),
      body: Center(child: child),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _calculateIndex(context),
        onTap: (index) {
          switch (index) {
            case 0:
              NavigationUtils.push(context, AppRoutes.groceriesHome);
              break;
            case 1:
              NavigationUtils.push(context, AppRoutes.brands);
              break;
            case 2:
              NavigationUtils.push(context, AppRoutes.categories);
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.branding_watermark),
            label: 'Brands',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            label: 'Categories',
          ),
        ],
      ),
    );
  }

  int _calculateIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith(AppRoutes.brands)) return 1;
    if (location.startsWith(AppRoutes.categories)) return 2;
    return 0;
  }
}
