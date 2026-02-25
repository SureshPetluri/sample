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
    return child;
  }

  int _calculateIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith(AppRoutes.services)) return 1;
    return 0;
  }
}
