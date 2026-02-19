import 'package:flutter_riverpod/legacy.dart';

import '../../data/profile_state.dart';

class ProfileNotifier extends StateNotifier<ProfileState> {
  ProfileNotifier() : super(const ProfileState()) {
    profileFetch();
  }

  void profileFetch() {
    state = state.copyWith(name: 'John Doe', email: 'john@example.com');
  }

  void updateName(String newName) {
    state = state.copyWith(name: newName);
  }
}

final profileProvider = StateNotifierProvider<ProfileNotifier, ProfileState>((
  ref,
) {
  return ProfileNotifier();
});
