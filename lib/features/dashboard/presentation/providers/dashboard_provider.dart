import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final homeProvider = StateProvider<String>((ref) {
  return 'Welcome to Riverpod Feature Structure';
});
