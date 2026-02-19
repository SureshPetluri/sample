import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/navigation_utils.dart';
import '../providers/profile_provider.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(profileProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          NavigationUtils.pop(context);
        }, icon: Icon(Icons.arrow_back)),

      ),
      body: Center(child: Text(homeState.name)),
    );
  }
}
