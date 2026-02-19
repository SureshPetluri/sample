import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/home_provider.dart';

class GroceriesHomePage extends ConsumerWidget {
  const GroceriesHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeProvider);

    return  Center(
        child: Text(homeState),

    );
  }
}
