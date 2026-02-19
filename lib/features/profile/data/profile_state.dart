class ProfileState {
  final String name;
  final String email;

  const ProfileState({
    this.name = '',
    this.email = '',
  });

  ProfileState copyWith({
    String? name,
    String? email,
  }) {
    return ProfileState(
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }
}