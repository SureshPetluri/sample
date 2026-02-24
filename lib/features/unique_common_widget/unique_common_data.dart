import 'unique_common_type.dart';

class UniqueCommonData {
  final UniqueCommonType type;
  final String content;
  final Map<String, dynamic>? metadata;

  UniqueCommonData({
    required this.type,
    required this.content,
    this.metadata,
  });
}
