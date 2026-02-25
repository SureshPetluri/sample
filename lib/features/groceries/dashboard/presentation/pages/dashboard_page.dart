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

    return child;
  }

  int _calculateIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith(AppRoutes.brands)) return 1;
    if (location.startsWith(AppRoutes.categories)) return 2;
    return 0;
  }
}
