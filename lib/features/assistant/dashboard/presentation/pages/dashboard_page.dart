import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../app/routes/app_routes.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/navigation_utils.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../providers/dashboard_provider.dart';

class AssistantDashBoardScreen extends ConsumerWidget {
  final Widget child;

  AssistantDashBoardScreen({super.key, required this.child});

  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (isWeb(context)) ...[Text("Sample"), SizedBox(width: 12)],
            Flexible(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: !isWeb(context) ? double.infinity : 400,
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
            if (isWeb(context)) ...[
              SizedBox(width: 12),
              Text("Categories"),
              SizedBox(width: 12),
            ],
            if (isWeb(context)) ...[
              Icon(Icons.shopping_cart),
              SizedBox(width: 12),
            ],
          ],
        ),
      ),
      body: Center(child: child),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _calculateIndex(context),
        onTap: (index) {
          switch (index) {
            case 0:
              NavigationUtils.push(context,AppRoutes.assistantHome);
              break;
            case 1:
              NavigationUtils.push(context,AppRoutes.services);
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.cleaning_services),
            label: 'Services',
          ),
        ],
      ),
    );
  }

  int _calculateIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith(AppRoutes.services)) return 1;
    return 0;
  }
}
